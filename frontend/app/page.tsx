'use client';

import { useState, useEffect } from 'react';
import Layout from '../components/Layout';
import StatsCard from '../components/StatsCard';
import RecentUploads from '../components/RecentUploads';
import LoadingSkeleton from '../components/LoadingSkeleton';
import { db } from '../firebase';
import {
  collection,
  onSnapshot,
  query,
  orderBy,
  limit,
} from 'firebase/firestore';
import {
  FileUpload,
  FirestoreFileUpload,
  FirestoreTimestamp,
} from '../types/fileUpload';

// Define types for our stats
interface Stats {
  totalFiles: number;
  processingFiles: number;
  completedFiles: number;
  failedFiles: number;
  totalReadings: number;
  flaggedReadings: number;
}

export default function Home() {
  const [stats, setStats] = useState<Stats>({
    totalFiles: 0,
    processingFiles: 0,
    completedFiles: 0,
    failedFiles: 0,
    totalReadings: 0,
    flaggedReadings: 0,
  });
  const [isLoading, setIsLoading] = useState(true);
  const [recentUploads, setRecentUploads] = useState<FileUpload[]>([]);
  const [error, setError] = useState<string | null>(null);

  // Subscribe to Firestore for real-time updates
  useEffect(() => {
    setIsLoading(true);

    try {
      // Create a query for all uploads to get total counts
      const allUploadsQuery = query(
        collection(db, 'fileUploads'),
        orderBy('upload_time', 'desc')
      );

      // Create a separate query for recent uploads (limited to 5)
      const recentUploadsQuery = query(
        collection(db, 'fileUploads'),
        orderBy('upload_time', 'desc'),
        limit(5)
      );

      // Set up real-time listener for all uploads (for stats)
      const unsubscribeAll = onSnapshot(
        allUploadsQuery,
        (snapshot) => {
          let totalFiles = 0;
          let processingFiles = 0;
          let completedFiles = 0;
          let failedFiles = 0;

          snapshot.forEach((doc) => {
            const data = doc.data() as FirestoreFileUpload;
            totalFiles++;

            switch (data.status) {
              case 'processing':
                processingFiles++;
                break;
              case 'completed':
                completedFiles++;
                break;
              case 'failed':
                failedFiles++;
                break;
            }
          });

          // Update stats with file counts
          setStats((prevStats) => ({
            ...prevStats,
            totalFiles,
            processingFiles,
            completedFiles,
            failedFiles,
          }));
        },
        (err) => {
          console.error('Error getting all uploads:', err);
          setError('Failed to load dashboard data: ' + err.message);
        }
      );

      // Set up real-time listener for recent uploads
      const unsubscribeRecent = onSnapshot(
        recentUploadsQuery,
        (snapshot) => {
          const uploadsList: FileUpload[] = [];

          snapshot.forEach((doc) => {
            const data = doc.data() as FirestoreFileUpload;

            // Add to uploads list
            const upload: FileUpload = {
              id: data.id,
              original_filename: data.original_filename || 'Unnamed file',
              status: data.status || 'pending',
              upload_time:
                typeof data.upload_time === 'object' &&
                'toDate' in data.upload_time
                  ? (data.upload_time as FirestoreTimestamp)
                      .toDate()
                      .toISOString()
                  : data.upload_time instanceof Date
                  ? data.upload_time.toISOString()
                  : String(data.upload_time),
              error_message: data.error_message,
              sql_output_path: data.sql_output_path,
            };

            uploadsList.push(upload);
          });

          setRecentUploads(uploadsList);
          setIsLoading(false);
        },
        (err) => {
          console.error('Error getting recent uploads:', err);
          setError('Failed to load recent uploads: ' + err.message);
          setIsLoading(false);
        }
      );

      // Fetch total readings count
      fetchReadingsCount().then(({ totalReadings, flaggedReadings }) => {
        setStats((prevStats) => ({
          ...prevStats,
          totalReadings,
          flaggedReadings,
        }));
      });

      // Clean up subscriptions on unmount
      return () => {
        unsubscribeAll();
        unsubscribeRecent();
      };
    } catch (err) {
      console.error('Failed to set up Firestore listeners:', err);
      setError('Failed to set up real-time updates');
      setIsLoading(false);
    }
  }, []);

  // Fetch readings count from the backend
  const fetchReadingsCount = async (): Promise<{
    totalReadings: number;
    flaggedReadings: number;
  }> => {
    try {
      const apiUrl = `${process.env.NEXT_PUBLIC_API_URL}/readings/stats`;
      const response = await fetch(apiUrl);

      if (!response.ok) {
        throw new Error('Failed to fetch readings stats');
      }

      const data = await response.json();
      return {
        totalReadings: data.total_readings || 0,
        flaggedReadings: data.flagged_readings || 0,
      };
    } catch (error) {
      console.error('Error fetching readings stats:', error);
      return {
        totalReadings: 0,
        flaggedReadings: 0,
      };
    }
  };

  // Handle download SQL file request
  const handleDownloadSql = (upload: FileUpload) => {
    if (!upload.sql_output_path) {
      alert('SQL file not available yet');
      return;
    }

    // Open the SQL file URL in a new tab
    window.open(upload.sql_output_path, '_blank');
  };

  return (
    <Layout>
      <div className="mb-6">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">Dashboard</h1>
        <p className="text-gray-800">Monitor your meter data processing</p>
      </div>

      {isLoading ? (
        <LoadingSkeleton />
      ) : error ? (
        <div className="bg-red-100 text-red-700 p-4 rounded-lg mb-8">
          {error}
        </div>
      ) : (
        <>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
            <StatsCard
              title="Total Files"
              value={stats.totalFiles}
              icon={
                <svg
                  className="w-8 h-8"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path
                    fillRule="evenodd"
                    d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4z"
                    clipRule="evenodd"
                  />
                </svg>
              }
            />

            <StatsCard
              title="Processing Files"
              value={stats.processingFiles}
              valueColor="text-blue-600"
              icon={
                <svg
                  className="w-8 h-8"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path
                    fillRule="evenodd"
                    d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z"
                    clipRule="evenodd"
                  />
                </svg>
              }
            />

            <StatsCard
              title="Completed Files"
              value={stats.completedFiles}
              valueColor="text-green-600"
              icon={
                <svg
                  className="w-8 h-8"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path
                    fillRule="evenodd"
                    d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                    clipRule="evenodd"
                  />
                </svg>
              }
            />

            <StatsCard
              title="Failed Files"
              value={stats.failedFiles}
              valueColor="text-red-600"
              icon={
                <svg
                  className="w-8 h-8"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path
                    fillRule="evenodd"
                    d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 00-1.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                    clipRule="evenodd"
                  />
                </svg>
              }
            />

            <StatsCard
              title="Total Readings"
              value={stats.totalReadings}
              icon={
                <svg
                  className="w-8 h-8"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path d="M2 10a8 8 0 018-8v8h8a8 8 0 11-16 0z" />
                  <path d="M12 2.252A8.014 8.014 0 0117.748 8H12V2.252z" />
                </svg>
              }
            />

            <StatsCard
              title="Flagged Readings"
              value={stats.flaggedReadings}
              valueColor="text-yellow-600"
              icon={
                <svg
                  className="w-8 h-8"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path
                    fillRule="evenodd"
                    d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
                    clipRule="evenodd"
                  />
                </svg>
              }
            />
          </div>

          <RecentUploads
            uploads={recentUploads}
            onDownloadSql={handleDownloadSql}
          />
        </>
      )}
    </Layout>
  );
}
