import React from 'react';
import Link from 'next/link';
import { FileUpload } from '../types/fileUpload';

interface RecentUploadsProps {
  uploads: FileUpload[];
  onDownloadSql: (upload: FileUpload) => void;
}

export default function RecentUploads({
  uploads,
  onDownloadSql,
}: RecentUploadsProps) {
  const formatDate = (dateString: string): string => {
    const date = new Date(dateString);
    return date.toLocaleString();
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

  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden mb-8">
      <div className="flex justify-between items-center px-6 py-4 border-b border-gray-200 bg-gray-50">
        <h2 className="text-lg font-semibold text-gray-800">Recent Uploads</h2>
        <Link
          href="/uploads"
          className="text-blue-600 hover:text-blue-800 text-sm"
        >
          View All
        </Link>
      </div>

      {uploads.length === 0 ? (
        <div className="p-6 text-center text-gray-500">
          No files uploaded yet. Go to the Upload page to get started.
        </div>
      ) : (
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
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
                    {upload.status === 'completed' &&
                      upload.sql_output_path && (
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
      )}
    </div>
  );
}
