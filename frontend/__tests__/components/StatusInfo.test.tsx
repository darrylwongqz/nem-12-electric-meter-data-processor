import React from 'react';
import { render, screen } from '@testing-library/react';
import StatusInfo from '../../components/StatusInfo';

describe('StatusInfo Component', () => {
  it('shows loading state', () => {
    render(
      <StatusInfo isLoading={true} error={null} readings={[]} totalCount={0} />
    );

    expect(screen.getByText('Loading readings...')).toBeInTheDocument();
  });

  it('shows error state', () => {
    const errorMessage = 'Failed to fetch data';

    render(
      <StatusInfo
        isLoading={false}
        error={errorMessage}
        readings={[]}
        totalCount={0}
      />
    );

    expect(screen.getByText('Error loading readings')).toBeInTheDocument();
    expect(screen.getByText(errorMessage)).toBeInTheDocument();
  });

  it('shows empty state when no readings', () => {
    render(
      <StatusInfo isLoading={false} error={null} readings={[]} totalCount={0} />
    );

    expect(screen.getByText('No readings found')).toBeInTheDocument();
  });

  it('shows count information when readings are available', () => {
    const mockReadings = [
      { id: 1, nmi: 'NMI123', timestamp: '2023-01-01', consumption: 10.5 },
      { id: 2, nmi: 'NMI123', timestamp: '2023-01-02', consumption: 11.2 },
    ];
    const totalCount = 10;

    render(
      <StatusInfo
        isLoading={false}
        error={null}
        readings={mockReadings}
        totalCount={totalCount}
      />
    );

    expect(
      screen.getByText(
        `Showing ${mockReadings.length} of ${totalCount} readings`
      )
    ).toBeInTheDocument();
  });
});
