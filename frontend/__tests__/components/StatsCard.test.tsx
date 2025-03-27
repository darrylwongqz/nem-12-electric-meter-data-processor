import React from 'react';
import { render, screen } from '@testing-library/react';
import StatsCard from '../../components/StatsCard';

describe('StatsCard Component', () => {
  it('renders card with title and value', () => {
    const mockIcon = <span data-testid="mock-icon">Icon</span>;

    render(<StatsCard title="Total Readings" value={1234} icon={mockIcon} />);

    // Check if title is rendered
    expect(screen.getByText('Total Readings')).toBeInTheDocument();

    // Check if value is rendered and formatted
    expect(screen.getByText('1,234')).toBeInTheDocument();

    // Check if icon is rendered
    expect(screen.getByTestId('mock-icon')).toBeInTheDocument();
  });

  it('applies custom text colors when provided', () => {
    const mockIcon = <span data-testid="mock-icon">Icon</span>;

    render(
      <StatsCard
        title="Flagged Readings"
        value={500}
        icon={mockIcon}
        valueColor="text-red-600"
        iconColor="text-red-500"
      />
    );

    // Check if title is rendered
    expect(screen.getByText('Flagged Readings')).toBeInTheDocument();

    // Check if value has the custom color class
    const valueElement = screen.getByText('500');
    expect(valueElement).toHaveClass('text-red-600');

    // Check if icon has the custom color class
    const iconContainer = screen.getByTestId('mock-icon').parentElement;
    expect(iconContainer).toHaveClass('text-red-500');
  });
});
