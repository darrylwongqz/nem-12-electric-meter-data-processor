import React from 'react';

interface FilterFormProps {
  nmiFilter: string;
  setNmiFilter: (value: string) => void;
  startDateFilter: string;
  setStartDateFilter: (value: string) => void;
  endDateFilter: string;
  setEndDateFilter: (value: string) => void;
  includeFlagged: boolean;
  setIncludeFlagged: (value: boolean) => void;
  onSubmit: (e: React.FormEvent) => void;
}

export default function FilterForm({
  nmiFilter,
  setNmiFilter,
  startDateFilter,
  setStartDateFilter,
  endDateFilter,
  setEndDateFilter,
  includeFlagged,
  setIncludeFlagged,
  onSubmit,
}: FilterFormProps) {
  return (
    <div className="bg-white shadow-md rounded-lg p-6 mb-6">
      <h2 className="text-lg font-semibold text-gray-800 mb-4">
        Filter Readings
      </h2>
      <form
        onSubmit={onSubmit}
        className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4"
      >
        <div>
          <label
            htmlFor="nmi"
            className="block text-sm font-medium text-gray-800 mb-1"
          >
            NMI
          </label>
          <input
            type="text"
            id="nmi"
            className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 text-gray-900"
            value={nmiFilter}
            onChange={(e) => setNmiFilter(e.target.value)}
            placeholder="Filter by NMI"
          />
        </div>

        <div>
          <label
            htmlFor="startDate"
            className="block text-sm font-medium text-gray-800 mb-1"
          >
            Start Date
          </label>
          <input
            type="date"
            id="startDate"
            className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 text-gray-900"
            value={startDateFilter}
            onChange={(e) => setStartDateFilter(e.target.value)}
          />
        </div>

        <div>
          <label
            htmlFor="endDate"
            className="block text-sm font-medium text-gray-800 mb-1"
          >
            End Date
          </label>
          <input
            type="date"
            id="endDate"
            className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 text-gray-900"
            value={endDateFilter}
            onChange={(e) => setEndDateFilter(e.target.value)}
          />
        </div>

        <div className="flex items-end">
          <div className="flex items-center h-10">
            <input
              type="checkbox"
              id="includeFlagged"
              className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
              checked={includeFlagged}
              onChange={(e) => setIncludeFlagged(e.target.checked)}
            />
            <label
              htmlFor="includeFlagged"
              className="ml-2 block text-sm text-gray-800"
            >
              Include Flagged Readings
            </label>
          </div>

          <button
            type="submit"
            className="ml-auto px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
          >
            Apply Filters
          </button>
        </div>
      </form>
    </div>
  );
}
