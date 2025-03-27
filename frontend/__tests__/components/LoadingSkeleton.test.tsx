import React from 'react';
import { render } from '@testing-library/react';
import LoadingSkeleton from '../../components/LoadingSkeleton';

describe('LoadingSkeleton Component', () => {
  it('renders the default number of skeleton items', () => {
    const { container } = render(<LoadingSkeleton />);

    // Default count is 6
    const skeletonItems = container.querySelectorAll('.animate-pulse');
    expect(skeletonItems.length).toBe(6);
  });

  it('renders the specified number of skeleton items', () => {
    const { container } = render(<LoadingSkeleton count={3} />);

    // Custom count is 3
    const skeletonItems = container.querySelectorAll('.animate-pulse');
    expect(skeletonItems.length).toBe(3);
  });

  it('renders skeleton items with the correct structure', () => {
    const { container } = render(<LoadingSkeleton count={1} />);

    // Get the skeleton item
    const skeletonItem = container.querySelector('.animate-pulse');

    // Check that it has the correct child elements
    expect(
      skeletonItem?.querySelector('.h-4.bg-gray-200.rounded')
    ).toBeTruthy();
    expect(
      skeletonItem?.querySelector('.h-8.bg-gray-200.rounded')
    ).toBeTruthy();
  });
});
