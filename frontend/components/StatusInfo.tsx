import React from 'react';

interface StatusInfoProps {
  isLoading: boolean;
  error: string | null;
  readings: any[];
  totalCount: number;
}

export default function StatusInfo({
  isLoading,
  error,
  readings,
  totalCount,
}: StatusInfoProps) {
  return (
    <div className="bg-white shadow-md rounded-lg p-4 mb-6">
      <div className="flex justify-between items-center">
        <div>
          <h3 className="text-sm font-medium text-gray-800">
            {isLoading
              ? 'Loading readings...'
              : error
              ? 'Error loading readings'
              : readings.length === 0
              ? 'No readings found'
              : `Showing ${readings.length} of ${totalCount} readings`}
          </h3>
        </div>
        {error && <div className="text-sm text-red-600">{error}</div>}
      </div>
    </div>
  );
}
