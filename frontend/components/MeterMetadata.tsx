import React from 'react';

interface MeterMetadataProps {
  metadata: {
    nmi: string;
    interval_length: number;
    start_date: string;
  };
}

export default function MeterMetadata({ metadata }: MeterMetadataProps) {
  return (
    <div className="bg-white shadow-md rounded-lg p-4 mb-6">
      <h3 className="text-sm font-medium text-gray-800 mb-2">
        Meter Information
      </h3>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <span className="block text-xs text-gray-700">NMI</span>
          <span className="block text-sm font-medium text-gray-900">
            {metadata.nmi}
          </span>
        </div>
        <div>
          <span className="block text-xs text-gray-700">Interval Length</span>
          <span className="block text-sm font-medium text-gray-900">
            {metadata.interval_length} minutes
          </span>
        </div>
        <div>
          <span className="block text-xs text-gray-700">Start Date</span>
          <span className="block text-sm font-medium text-gray-900">
            {new Date(metadata.start_date).toLocaleDateString()}
          </span>
        </div>
      </div>
    </div>
  );
}
