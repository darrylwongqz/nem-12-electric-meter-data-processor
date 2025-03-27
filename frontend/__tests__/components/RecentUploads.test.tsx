import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import RecentUploads from '../../components/RecentUploads';
import type { FileUpload } from '../../types/fileUpload';

// Mock data for testing
const mockUploads: FileUpload[] = [
  {
    id: 1,
    original_filename: 'test1.csv',
    status: 'completed',
    upload_time: '2023-01-01T12:00:00Z',
    sql_output_path: 'path/to/sql1.sql',
  },
  {
    id: 2,
    original_filename: 'test2.csv',
    status: 'pending',
    upload_time: '2023-01-02T12:00:00Z',
  },
  {
    id: 3,
    original_filename: 'test3.csv',
    status: 'failed',
    upload_time: '2023-01-03T12:00:00Z',
    error_message: 'Invalid file format',
  },
];

// Mock functions
const mockDownloadHandler = jest.fn();

describe('RecentUploads Component', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders the component title and view all link', () => {
    render(
      <RecentUploads
        uploads={mockUploads}
        onDownloadSql={mockDownloadHandler}
      />
    );

    expect(screen.getByText('Recent Uploads')).toBeInTheDocument();
    expect(screen.getByText('View All')).toBeInTheDocument();
  });

  it('renders a table with the correct headers', () => {
    render(
      <RecentUploads
        uploads={mockUploads}
        onDownloadSql={mockDownloadHandler}
      />
    );

    expect(screen.getByText('Filename')).toBeInTheDocument();
    expect(screen.getByText('Upload Time')).toBeInTheDocument();
    expect(screen.getByText('Status')).toBeInTheDocument();
    expect(screen.getByText('Actions')).toBeInTheDocument();
  });

  it('renders upload items with correct data', () => {
    render(
      <RecentUploads
        uploads={mockUploads}
        onDownloadSql={mockDownloadHandler}
      />
    );

    // Check filenames
    expect(screen.getByText('test1.csv')).toBeInTheDocument();
    expect(screen.getByText('test2.csv')).toBeInTheDocument();
    expect(screen.getByText('test3.csv')).toBeInTheDocument();

    // Check statuses (capitalized in the UI)
    expect(screen.getByText('Completed')).toBeInTheDocument();
    expect(screen.getByText('Pending')).toBeInTheDocument();
    expect(screen.getByText('Failed')).toBeInTheDocument();

    // Check error message
    expect(screen.getByText('Invalid file format')).toBeInTheDocument();
  });

  it('shows download button for completed uploads and triggers download', () => {
    render(
      <RecentUploads
        uploads={mockUploads}
        onDownloadSql={mockDownloadHandler}
      />
    );

    const downloadButton = screen.getByText('Download SQL');
    expect(downloadButton).toBeInTheDocument();

    // Click download button
    fireEvent.click(downloadButton);

    // Check if handler was called with the correct upload
    expect(mockDownloadHandler).toHaveBeenCalledTimes(1);
    expect(mockDownloadHandler).toHaveBeenCalledWith(mockUploads[0]);
  });

  it('handles empty uploads array', () => {
    render(<RecentUploads uploads={[]} onDownloadSql={mockDownloadHandler} />);

    // Check for empty state message
    expect(
      screen.getByText(
        'No files uploaded yet. Go to the Upload page to get started.'
      )
    ).toBeInTheDocument();

    // Make sure the table is not rendered
    const tableHeaders = screen.queryByText('Filename');
    expect(tableHeaders).not.toBeInTheDocument();
  });
});
