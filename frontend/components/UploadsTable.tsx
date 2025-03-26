import React from 'react';
import { FileUpload } from '../types/fileUpload';

interface UploadsTableProps {
  uploads: FileUpload[];
  isLoading: boolean;
  error: string | null;
  onDownloadSql: (upload: FileUpload) => void;
}

export default function UploadsTable({
  uploads,
  isLoading,
  error,
  onDownloadSql,
}: UploadsTableProps) {
  const formatDate = (dateString: string): string => {
    if (!dateString) return 'N/A';

    try {
      const date = new Date(dateString);
      if (isNaN(date.getTime())) {
        return 'N/A';
      }
      return date.toLocaleString();
    } catch (error) {
      console.error('Error formatting date:', error);
      return 'N/A';
    }
  };

  const getStatusBadge = (status: string) => {
    const statusClasses = {
      pending: 'bg-yellow-100 text-yellow-800',
      processing: 'bg-blue-100 text-blue-800',
      completed: 'bg-green-100 text-green-800',
      failed: 'bg-red-100 text-red-800',
    };

    const className =
      statusClasses[status as keyof typeof statusClasses] ||
      'bg-gray-100 text-gray-800';

    return (
      <span
        className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${className}`}
      >
        {status.charAt(0).toUpperCase() + status.slice(1)}
      </span>
    );
  };

  if (isLoading) {
    return (
      <div className="p-6 animate-pulse">
        <div className="h-6 bg-gray-200 rounded w-1/4 mb-4"></div>
        {[...Array(3)].map((_, i) => (
          <div key={i} className="h-12 bg-gray-200 rounded mb-4"></div>
        ))}
      </div>
    );
  }

  if (error) {
    return <div className="p-6 text-red-700">{error}</div>;
  }

  if (uploads.length === 0) {
    return (
      <div className="p-6 text-center text-gray-500">
        No files uploaded yet. Use the form above to upload a NEM12 file.
      </div>
    );
  }

  return (
    <div className="overflow-x-auto">
      <table className="min-w-full divide-y divide-gray-200">
        <thead className="bg-gray-50">
          <tr>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-800 uppercase tracking-wider">
              File ID
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-800 uppercase tracking-wider">
              Filename
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-800 uppercase tracking-wider">
              Upload Time
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-800 uppercase tracking-wider">
              Status
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-800 uppercase tracking-wider">
              Actions
            </th>
          </tr>
        </thead>
        <tbody className="bg-white divide-y divide-gray-200">
          {uploads.map((upload) => (
            <tr key={upload.id}>
              <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                {upload.id}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                {upload.original_filename}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                {formatDate(upload.upload_time)}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                {getStatusBadge(upload.status)}
                {upload.error_message && (
                  <span className="block mt-1 text-xs text-red-600">
                    {upload.error_message}
                  </span>
                )}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                {upload.status === 'completed' && upload.sql_output_path && (
                  <button
                    onClick={() => onDownloadSql(upload)}
                    className="text-blue-600 hover:text-blue-900"
                  >
                    Download SQL
                  </button>
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
