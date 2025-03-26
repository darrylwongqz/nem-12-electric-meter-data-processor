/**
 * Represents a file upload in the system
 */
export interface FileUpload {
  id: number;
  original_filename: string;
  status: 'pending' | 'processing' | 'completed' | 'failed';
  upload_time: string;
  error_message?: string;
  raw_file_url?: string;
  sql_output_path?: string;
}

/**
 * Payload sent to the backend after a file is uploaded to Firebase Storage
 */
export interface FileUploadPayload {
  original_filename: string;
  storage_filename: string;
  raw_file_url: string;
}

/**
 * Response from the backend after a file upload notification
 */
export interface FileUploadResponse {
  file_id: number;
  original_filename: string;
  status: string;
  upload_time: string;
}

/**
 * Firestore Timestamp interface
 */
export interface FirestoreTimestamp {
  toDate(): Date;
  seconds: number;
  nanoseconds: number;
}

/**
 * Firestore document structure for file uploads
 */
export interface FirestoreFileUpload {
  id: number;
  original_filename: string;
  status: 'pending' | 'processing' | 'completed' | 'failed';
  upload_time: FirestoreTimestamp | string | Date;
  error_message?: string;
  raw_file_url?: string;
  sql_output_path?: string;
}
