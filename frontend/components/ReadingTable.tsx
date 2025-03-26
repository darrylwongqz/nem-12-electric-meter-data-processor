import React from 'react';

interface Reading {
  nmi: string;
  timestamp: string;
  consumption: number;
  is_flagged: boolean;
  quality_method?: string;
}

interface ReadingTableProps {
  readings: Reading[];
  isLoading: boolean;
}

export default function ReadingTable({
  readings,
  isLoading,
}: ReadingTableProps) {
  // Format timestamp to a readable format
  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleString();
  };

  if (isLoading) {
    return (
      <div className="w-full p-6 bg-white rounded-lg shadow-md">
        <div className="animate-pulse space-y-4">
          <div className="h-10 bg-gray-200 rounded w-1/4"></div>
          <div className="space-y-2">
            {[...Array(5)].map((_, i) => (
              <div key={i} className="h-12 bg-gray-200 rounded"></div>
            ))}
          </div>
        </div>
      </div>
    );
  }

  if (!readings || readings.length === 0) {
    return (
      <div className="w-full p-6 bg-white rounded-lg shadow-md text-center">
        <p className="text-gray-500">No readings available</p>
      </div>
    );
  }

  return (
    <div className="w-full overflow-x-auto rounded-lg shadow-md">
      <table className="min-w-full bg-white">
        <thead>
          <tr className="bg-blue-600 text-white">
            <th className="py-3 px-4 text-left">NMI</th>
            <th className="py-3 px-4 text-left">Timestamp</th>
            <th className="py-3 px-4 text-right">Consumption</th>
            <th className="py-3 px-4 text-center">Status</th>
          </tr>
        </thead>
        <tbody className="divide-y divide-gray-200">
          {readings.map((reading, index) => (
            <tr key={index} className={reading.is_flagged ? 'bg-red-50' : ''}>
              <td className="py-3 px-4 font-mono text-gray-900">
                {reading.nmi}
              </td>
              <td className="py-3 px-4 text-gray-900">
                {formatDate(reading.timestamp)}
              </td>
              <td className="py-3 px-4 text-right font-mono text-gray-900">
                {reading.consumption.toFixed(3)}
              </td>
              <td className="py-3 px-4 text-center">
                {reading.is_flagged ? (
                  <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                    Flagged
                    {reading.quality_method && ` (${reading.quality_method})`}
                  </span>
                ) : (
                  <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                    Valid
                  </span>
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
