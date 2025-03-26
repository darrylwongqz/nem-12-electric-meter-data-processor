import React, { useState, useRef } from 'react';
import { storage } from '../firebase';
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';
import { FileUploadResponse } from '../types/fileUpload';

interface UploadFormProps {
  onUploadSuccess: (fileId: number, originalFilename: string) => void;
}

export default function UploadForm({ onUploadSuccess }: UploadFormProps) {
  const [file, setFile] = useState<File | null>(null);
  const [isUploading, setIsUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState(0);
  const [error, setError] = useState<string | null>(null);
  const [debug, setDebug] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files.length > 0) {
      setFile(e.target.files[0]);
      setError(null);
    }
  };

  const handleDragOver = (e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
  };

  const handleDrop = (e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
      setFile(e.dataTransfer.files[0]);
      setError(null);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!file) {
      setError('Please select a file to upload');
      return;
    }

    // Check file extension
    const validExtensions = ['.csv', '.txt', '.nem12'];
    const fileExt = file.name.slice(file.name.lastIndexOf('.')).toLowerCase();
    if (!validExtensions.includes(fileExt)) {
      setError(
        `Invalid file type. Supported types: ${validExtensions.join(', ')}`
      );
      return;
    }

    // Upload file to Firebase Storage
    setIsUploading(true);
    setError(null);
    setDebug(null);
    setUploadProgress(0);

    try {
      // Generate a unique identifier using timestamp and random string
      const timestamp = new Date().getTime();
      const randomStr = Math.random().toString(36).substring(2, 8);
      const uniqueId = `${timestamp}_${randomStr}`;

      // Create storage filename with unique identifier
      const storageFilename = `${file.name.slice(
        0,
        file.name.lastIndexOf('.')
      )}_${uniqueId}${fileExt}`;

      // Create a storage reference for the file in the 'uploads/raw' folder
      const storageRef = ref(storage, `uploads/raw/${storageFilename}`);
      setDebug(`Storage reference created: uploads/raw/${storageFilename}`);

      // Create an upload task with progress monitoring
      const uploadTask = uploadBytesResumable(storageRef, file);

      // Monitor upload progress
      uploadTask.on(
        'state_changed',
        (snapshot) => {
          // Calculate and update progress
          const progress = Math.round(
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100
          );
          setUploadProgress(progress);
          setDebug(`Upload progress: ${progress}%`);
        },
        (error) => {
          // Handle unsuccessful uploads
          console.error('Upload failed:', error);
          setError(`Upload failed: ${error.message}`);
          setIsUploading(false);
        },
        async () => {
          try {
            // Upload completed successfully
            // Get the download URL
            setDebug('Upload completed, getting download URL...');
            const downloadURL = await getDownloadURL(uploadTask.snapshot.ref);
            setDebug(
              `Download URL obtained: ${downloadURL.substring(0, 50)}...`
            );

            // Notify backend about the file upload with raw file URL
            setDebug('Notifying backend...');
            const apiUrl = `${process.env.NEXT_PUBLIC_API_URL}/readings/upload`;
            setDebug(`API URL: ${apiUrl}`);

            const payload = {
              original_filename: file.name,
              storage_filename: storageFilename,
              raw_file_url: downloadURL,
            };
            setDebug(`Payload: ${JSON.stringify(payload)}`);

            try {
              const response = await fetch(apiUrl, {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify(payload),
              });

              setDebug(`Response status: ${response.status}`);

              if (!response.ok) {
                const responseText = await response.text();
                setDebug(`Error response: ${responseText}`);

                let errorDetail = 'Failed to notify backend';
                try {
                  const errorData = JSON.parse(responseText);
                  errorDetail = errorData.detail || errorDetail;
                } catch (parseError) {
                  // If JSON parsing fails, use the response text
                  setDebug(`Error parsing JSON response: ${parseError}`);
                  errorDetail = responseText || errorDetail;
                }

                throw new Error(errorDetail);
              }

              const responseText = await response.text();
              setDebug(`Success response: ${responseText}`);

              let data: FileUploadResponse;
              try {
                data = JSON.parse(responseText);
              } catch (e) {
                setDebug(`Error parsing response JSON: ${e}`);
                throw new Error('Invalid response from server');
              }

              // Notify parent component of successful upload
              onUploadSuccess(data.file_id, data.original_filename);
              setDebug('Upload process completed successfully');

              // Reset form
              setFile(null);
              setUploadProgress(0);
              if (fileInputRef.current) {
                fileInputRef.current.value = '';
              }
            } catch (err) {
              console.error('Backend notification error:', err);
              setError(
                err instanceof Error
                  ? `Backend error: ${err.message}`
                  : 'Failed to notify backend'
              );
            }
          } catch (err) {
            console.error('Download URL error:', err);
            setError(
              err instanceof Error ? err.message : 'An unknown error occurred'
            );
          } finally {
            setIsUploading(false);
          }
        }
      );
    } catch (err) {
      console.error('Error starting upload:', err);
      setError(
        err instanceof Error
          ? `Error starting upload: ${err.message}`
          : 'An unknown error occurred'
      );
      setIsUploading(false);
    }
  };

  return (
    <div className="w-full p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-xl font-semibold mb-4 text-gray-800">
        Upload NEM12 File
      </h2>

      <form onSubmit={handleSubmit}>
        <div
          className="border-2 border-dashed border-blue-300 rounded-lg p-8 mb-4 text-center cursor-pointer hover:bg-blue-50 transition"
          onDragOver={handleDragOver}
          onDrop={handleDrop}
          onClick={() => fileInputRef.current?.click()}
        >
          <input
            type="file"
            className="hidden"
            ref={fileInputRef}
            onChange={handleFileChange}
            accept=".csv,.txt,.nem12"
          />

          {file ? (
            <div className="text-center">
              <p className="text-green-600 font-semibold mb-1">File selected</p>
              <p className="text-gray-600">
                {file.name} ({(file.size / 1024).toFixed(1)} KB)
              </p>
            </div>
          ) : (
            <div className="text-center">
              <svg
                className="mx-auto h-12 w-12 text-gray-400"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                />
              </svg>
              <p className="mt-1 text-sm text-gray-600">
                Drag and drop your NEM12 file here, or click to select
              </p>
              <p className="mt-1 text-xs text-gray-500">
                Supported formats: CSV, TXT, NEM12
              </p>
            </div>
          )}
        </div>

        {error && (
          <div className="mb-4 p-3 bg-red-100 text-red-700 rounded-md">
            {error}
          </div>
        )}

        {debug && (
          <div className="mb-4 p-3 bg-gray-100 text-gray-700 rounded-md text-xs overflow-auto max-h-40">
            <strong>Debug Info:</strong>
            <pre className="mt-1 whitespace-pre-wrap">{debug}</pre>
          </div>
        )}

        {isUploading && (
          <div className="mb-4">
            <div className="w-full bg-gray-200 rounded-full h-2.5">
              <div
                className="bg-blue-600 h-2.5 rounded-full transition-all duration-300"
                style={{ width: `${uploadProgress}%` }}
              ></div>
            </div>
            <p className="text-sm text-gray-600 mt-1 text-center">
              {uploadProgress < 100
                ? `Uploading: ${uploadProgress}%`
                : 'Processing file...'}
            </p>
          </div>
        )}

        <button
          type="submit"
          className="w-full py-2 px-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50 disabled:opacity-50"
          disabled={!file || isUploading}
        >
          {isUploading ? 'Uploading...' : 'Upload File'}
        </button>
      </form>
    </div>
  );
}
