/* eslint-disable */
'use client';
/* eslint-enable */

import { useState, useEffect } from 'react';
import Layout from '../../components/Layout';
import ReadingTable from '../../components/ReadingTable';
import FilterForm from '../../components/FilterForm';
import MeterMetadata from '../../components/MeterMetadata';
import StatusInfo from '../../components/StatusInfo';
import Pagination from '../../components/Pagination';

interface Reading {
  nmi: string;
  timestamp: string;
  consumption: number;
  is_flagged: boolean;
  quality_method?: string;
}

interface MeterMetadata {
  nmi: string;
  interval_length: number;
  start_date: string;
}

interface ReadingsResponse {
  readings: Reading[];
  count: number;
  metadata?: MeterMetadata;
}

export default function ReadingsPage() {
  const [readings, setReadings] = useState<Reading[]>([]);
  const [metadata, setMetadata] = useState<MeterMetadata | null>(null);
  const [totalCount, setTotalCount] = useState(0);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Filter states
  const [nmiFilter, setNmiFilter] = useState('');
  const [startDateFilter, setStartDateFilter] = useState('');
  const [endDateFilter, setEndDateFilter] = useState('');
  const [includeFlagged, setIncludeFlagged] = useState(true);
  const [page, setPage] = useState(1);
  const pageSize = 50;

  useEffect(() => {
    const fetchReadings = async () => {
      setIsLoading(true);
      setError(null);

      try {
        const offset = (page - 1) * pageSize;
        const params = new URLSearchParams({
          limit: pageSize.toString(),
          offset: offset.toString(),
          ...(nmiFilter && { nmi: nmiFilter }),
          ...(startDateFilter && {
            start_date: new Date(startDateFilter).toISOString(),
          }),
          ...(endDateFilter && {
            end_date: new Date(endDateFilter).toISOString(),
          }),
          include_flagged: includeFlagged.toString(),
        });

        const apiUrl = `${
          process.env.NEXT_PUBLIC_API_URL
        }/readings/readings?${params.toString()}`;

        const response = await fetch(apiUrl);

        if (!response.ok) {
          throw new Error(`Failed to fetch readings: ${response.statusText}`);
        }

        const data: ReadingsResponse = await response.json();
        setReadings(data.readings || []);
        setTotalCount(data.count || 0);
        setMetadata(data.metadata || null);
      } catch (err) {
        console.error('Failed to fetch readings:', err);
        setError(
          `Failed to load readings: ${
            err instanceof Error ? err.message : 'Unknown error'
          }`
        );
        setReadings([]);
      } finally {
        setIsLoading(false);
      }
    };

    fetchReadings();
  }, [nmiFilter, startDateFilter, endDateFilter, includeFlagged, page]);

  const handleFilterSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setPage(1);
  };

  const totalPages = Math.ceil(totalCount / pageSize);

  return (
    <Layout>
      <div className="mb-6">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">
          Meter Readings
        </h1>
        <p className="text-gray-800">View and filter meter readings data</p>
      </div>

      <FilterForm
        nmiFilter={nmiFilter}
        setNmiFilter={setNmiFilter}
        startDateFilter={startDateFilter}
        setStartDateFilter={setStartDateFilter}
        endDateFilter={endDateFilter}
        setEndDateFilter={setEndDateFilter}
        includeFlagged={includeFlagged}
        setIncludeFlagged={setIncludeFlagged}
        onSubmit={handleFilterSubmit}
      />

      {metadata && <MeterMetadata metadata={metadata} />}

      <StatusInfo
        isLoading={isLoading}
        error={error}
        readings={readings}
        totalCount={totalCount}
      />

      <ReadingTable readings={readings} isLoading={isLoading} />

      <Pagination
        page={page}
        totalPages={totalPages}
        totalCount={totalCount}
        onPageChange={setPage}
      />
    </Layout>
  );
}
