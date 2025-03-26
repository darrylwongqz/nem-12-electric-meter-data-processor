import React from 'react';

interface PaginationProps {
  page: number;
  totalPages: number;
  totalCount: number;
  onPageChange: (page: number) => void;
}

export default function Pagination({
  page,
  totalPages,
  totalCount,
  onPageChange,
}: PaginationProps) {
  if (totalPages <= 1) return null;

  return (
    <div className="flex justify-between items-center mt-6">
      <div className="text-sm text-gray-800">
        Showing page {page} of {totalPages} ({totalCount} total readings)
      </div>
      <div className="flex space-x-2">
        <button
          onClick={() => onPageChange(Math.max(page - 1, 1))}
          disabled={page === 1}
          className="px-3 py-1 border border-gray-300 rounded-md text-sm font-medium text-gray-800 bg-white hover:bg-gray-50 disabled:opacity-50"
        >
          Previous
        </button>
        <button
          onClick={() => onPageChange(Math.min(page + 1, totalPages))}
          disabled={page === totalPages}
          className="px-3 py-1 border border-gray-300 rounded-md text-sm font-medium text-gray-800 bg-white hover:bg-gray-50 disabled:opacity-50"
        >
          Next
        </button>
      </div>
    </div>
  );
}
