import React from 'react';

interface StatsCardProps {
  title: string;
  value: number;
  icon: React.ReactNode;
  valueColor?: string;
  iconColor?: string;
}

export default function StatsCard({
  title,
  value,
  icon,
  valueColor = 'text-gray-900',
  iconColor = 'text-blue-600',
}: StatsCardProps) {
  return (
    <div className="bg-white p-6 rounded-lg shadow-md">
      <h3 className="text-gray-800 text-sm font-medium mb-2">{title}</h3>
      <div className="flex justify-between items-center">
        <p className={`text-3xl font-bold ${valueColor}`}>
          {value.toLocaleString()}
        </p>
        <span className={iconColor}>{icon}</span>
      </div>
    </div>
  );
}
