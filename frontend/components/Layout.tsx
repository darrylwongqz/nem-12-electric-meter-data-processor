import Link from 'next/link';
import { ReactNode } from 'react';

interface LayoutProps {
  children: ReactNode;
}

export default function Layout({ children }: LayoutProps) {
  return (
    <div className="min-h-screen bg-gray-100">
      <nav className="bg-blue-600 text-white shadow-md">
        <div className="container mx-auto px-4 py-3">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <svg className="h-8 w-8" viewBox="0 0 24 24" fill="currentColor">
                <path d="M13 5.5V2.2C13 1.54 12.46 1 11.8 1H8.2C7.54 1 7 1.54 7 2.2V5.5C7 6.16 7.54 6.7 8.2 6.7H11.8C12.46 6.7 13 6.16 13 5.5ZM21.59 11.24C21.22 10.44 20.68 9.75 20.04 9.2L18.12 7.64C17.58 7.21 16.78 7.33 16.38 7.8L13.5 11.47C13.12 12 13.34 12.72 13.9 13L16.9 14.7C17.45 14.99 18.16 14.81 18.5 14.23L21.26 9.72C21.59 9.16 21.74 8.54 21.59 11.24ZM8 13H4C3.45 13 3 13.45 3 14C3 14.55 3.45 15 4 15H8C8.55 15 9 14.55 9 14C9 13.45 8.55 13 8 13ZM7 17H4C3.45 17 3 17.45 3 18C3 18.55 3.45 19 4 19H7C7.55 19 8 18.55 8 18C8 17.45 7.55 17 7 17ZM20 13H10C9.45 13 9 13.45 9 14C9 14.55 9.45 15 10 15H20C20.55 15 21 14.55 21 14C21 13.45 20.55 13 20 13ZM19 17H10C9.45 17 9 17.45 9 18C9 18.55 9.45 19 10 19H19C19.55 19 20 18.55 20 18C20 17.45 19.55 17 19 17Z" />
              </svg>
              <span className="text-xl font-semibold">Flo-Energy</span>
            </div>
            <div className="flex space-x-4">
              <Link href="/" className="px-3 py-2 rounded hover:bg-blue-700">
                Dashboard
              </Link>
              <Link
                href="/readings"
                className="px-3 py-2 rounded hover:bg-blue-700"
              >
                Readings
              </Link>
              <Link
                href="/uploads"
                className="px-3 py-2 rounded hover:bg-blue-700"
              >
                Upload
              </Link>
            </div>
          </div>
        </div>
      </nav>

      <main className="container mx-auto px-4 py-6">{children}</main>

      <footer className="bg-gray-200 py-4 mt-8">
        <div className="container mx-auto px-4 text-center text-gray-600">
          <p>© 2023 Flo-Energy - Meter Data Management</p>
        </div>
      </footer>
    </div>
  );
}
