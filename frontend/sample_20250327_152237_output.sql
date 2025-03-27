-- Generated SQL insert statements for NEM12 file
-- Original file: sample.txt
-- Generated at: 2025-03-27T15:22:37.436476


            INSERT INTO meter_metadata (nmi, interval_length, start_date) 
            VALUES ('NEM1201009', 30, '2005-06-10T00:00:00') 
            ON CONFLICT (nmi) DO UPDATE 
            SET interval_length = 30, start_date = '2005-06-10T00:00:00';
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T00:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T00:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T01:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T01:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T02:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T02:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T03:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T03:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T04:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T04:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T05:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T05:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T06:00:00', 0.461, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.461, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T06:30:00', 0.81, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.81, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T07:00:00', 0.568, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.568, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T07:30:00', 1.234, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.234, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T08:00:00', 1.353, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.353, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T08:30:00', 1.507, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.507, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T09:00:00', 1.344, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.344, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T09:30:00', 1.773, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.773, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T10:00:00', 0.848, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.848, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T10:30:00', 1.271, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.271, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T11:00:00', 0.895, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.895, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T11:30:00', 1.327, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.327, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T12:00:00', 1.013, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.013, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T12:30:00', 1.793, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.793, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T13:00:00', 0.988, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.988, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T13:30:00', 0.985, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.985, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T14:00:00', 0.876, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.876, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T14:30:00', 0.555, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.555, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T15:00:00', 0.76, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.76, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T15:30:00', 0.938, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.938, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T16:00:00', 0.566, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.566, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T16:30:00', 0.512, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.512, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T17:00:00', 0.97, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.97, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T17:30:00', 0.76, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.76, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T18:00:00', 0.7, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.7, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T00:00:00', 31.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 31.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T00:30:00', 0.615, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.615, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T01:00:00', 0.886, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.886, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T01:30:00', 0.531, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.531, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T02:00:00', 0.774, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.774, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T02:30:00', 0.712, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.712, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T03:00:00', 0.598, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.598, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T03:30:00', 0.67, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.67, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T04:00:00', 0.587, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.587, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T04:30:00', 0.657, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.657, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T05:00:00', 0.345, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.345, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T05:30:00', 0.231, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.231, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T00:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T00:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T01:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T01:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T02:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T02:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T03:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T03:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T04:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T04:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T05:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T05:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T06:00:00', 0.235, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.235, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T06:30:00', 0.567, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.567, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T07:00:00', 0.89, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.89, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T07:30:00', 1.123, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.123, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T08:00:00', 1.345, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.345, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T08:30:00', 1.567, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.567, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T09:00:00', 1.543, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.543, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T09:30:00', 1.234, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.234, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T10:00:00', 0.987, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.987, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T10:30:00', 1.123, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.123, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T11:00:00', 0.876, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.876, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T11:30:00', 1.345, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.345, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T12:00:00', 1.145, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.145, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T12:30:00', 1.173, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.173, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T13:00:00', 1.265, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.265, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T13:30:00', 0.987, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.987, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T14:00:00', 0.678, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.678, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T14:30:00', 0.998, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.998, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T15:00:00', 0.768, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.768, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T15:30:00', 0.954, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.954, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T16:00:00', 0.876, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.876, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T16:30:00', 0.845, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.845, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T17:00:00', 0.932, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.932, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T17:30:00', 0.786, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.786, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T18:00:00', 0.9, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.9, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T00:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T00:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T01:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T01:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T02:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T02:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T03:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T03:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T04:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T04:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T05:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T05:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T06:00:00', 0.261, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.261, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T06:30:00', 0.31, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.31, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T07:00:00', 0.678, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.678, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T07:30:00', 0.934, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.934, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T08:00:00', 1.211, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.211, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T08:30:00', 1.134, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.134, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T09:00:00', 1.423, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.423, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T09:30:00', 1.37, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.37, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T10:00:00', 0.988, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.988, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T10:30:00', 1.207, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.207, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T11:00:00', 0.89, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.89, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T11:30:00', 1.32, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.32, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T12:00:00', 1.13, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.13, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T12:30:00', 1.913, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.913, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T13:00:00', 1.18, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.18, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T13:30:00', 0.95, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.95, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T14:00:00', 0.746, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.746, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T14:30:00', 0.635, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.635, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T15:00:00', 0.956, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.956, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T15:30:00', 0.887, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.887, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T16:00:00', 0.56, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.56, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T16:30:00', 0.7, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.7, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T17:00:00', 0.788, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.788, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T17:30:00', 0.668, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.668, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T18:00:00', 0.5, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.5, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T00:00:00', 43.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 43.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T00:30:00', 0.738, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.738, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T01:00:00', 0.802, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.802, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T01:30:00', 0.49, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.49, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T02:00:00', 0.598, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.598, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T02:30:00', 0.809, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.809, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T03:00:00', 0.52, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.52, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T03:30:00', 0.67, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.67, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T04:00:00', 0.57, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.57, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T04:30:00', 0.6, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.6, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T05:00:00', 0.289, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.289, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T05:30:00', 0.321, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.321, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T00:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T00:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T01:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T01:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T02:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T02:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T03:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T03:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T04:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T04:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T05:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T05:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T06:00:00', 0.335, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.335, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T06:30:00', 0.667, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.667, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T07:00:00', 0.79, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.79, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T07:30:00', 1.023, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.023, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T08:00:00', 1.145, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.145, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T08:30:00', 1.777, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.777, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T09:00:00', 1.563, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.563, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T09:30:00', 1.344, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.344, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T10:00:00', 1.087, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.087, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T10:30:00', 1.453, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.453, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T11:00:00', 0.996, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.996, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T11:30:00', 1.125, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.125, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T12:00:00', 1.435, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.435, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T12:30:00', 1.263, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.263, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T13:00:00', 1.085, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.085, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T13:30:00', 1.487, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.487, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T14:00:00', 1.278, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.278, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T14:30:00', 0.768, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.768, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T15:00:00', 0.878, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.878, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T15:30:00', 0.754, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.754, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T16:00:00', 0.476, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.476, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T16:30:00', 1.045, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.045, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T17:00:00', 1.132, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.132, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T17:30:00', 0.896, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.896, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T18:00:00', 0.8, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.8, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T00:00:00', 79.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 79.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T00:30:00', 0.679, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.679, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T01:00:00', 0.887, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.887, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T01:30:00', 0.784, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.784, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T02:00:00', 0.954, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.954, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T02:30:00', 0.712, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.712, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T03:00:00', 0.599, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.599, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T03:30:00', 0.593, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.593, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T04:00:00', 0.674, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.674, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T04:30:00', 0.799, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.799, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T05:00:00', 0.232, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.232, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T05:30:00', 0.612, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.612, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T00:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T00:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T01:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T01:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T02:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T02:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T03:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T03:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T04:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T04:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T05:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T05:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T06:00:00', 0.154, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.154, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T06:30:00', 0.46, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.46, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T07:00:00', 0.77, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.77, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T07:30:00', 1.003, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.003, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T08:00:00', 1.059, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.059, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T08:30:00', 1.75, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.75, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T09:00:00', 1.423, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.423, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T09:30:00', 1.2, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.2, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T10:00:00', 0.98, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.98, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T10:30:00', 1.111, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.111, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T11:00:00', 0.8, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.8, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T11:30:00', 1.403, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.403, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T12:00:00', 1.145, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.145, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T12:30:00', 1.173, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.173, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T13:00:00', 1.065, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.065, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T13:30:00', 1.187, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.187, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T14:00:00', 0.9, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.9, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T14:30:00', 0.998, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.998, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T15:00:00', 0.768, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.768, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T15:30:00', 1.432, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.432, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T16:00:00', 0.899, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.899, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T16:30:00', 1.211, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.211, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T17:00:00', 0.873, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.873, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T17:30:00', 0.786, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.786, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T18:00:00', 1.504, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.504, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T18:30:00', 0.719, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.719, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T19:00:00', 0.817, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.817, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T19:30:00', 0.78, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.78, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T20:00:00', 0.709, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.709, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T20:30:00', 0.7, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.7, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T21:00:00', 0.565, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.565, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T21:30:00', 0.655, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.655, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T22:00:00', 0.543, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.543, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T22:30:00', 0.786, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.786, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T23:00:00', 0.43, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.43, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-01T23:30:00', 0.432, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.432, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T00:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T00:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T01:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T01:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T02:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T02:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T03:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T03:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T04:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T04:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T05:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T05:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T06:00:00', 0.461, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.461, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T06:30:00', 0.81, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.81, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T07:00:00', 0.776, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.776, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T07:30:00', 1.004, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.004, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T08:00:00', 1.034, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.034, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T08:30:00', 1.2, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.2, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T09:00:00', 1.31, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.31, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T09:30:00', 1.342, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.342, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T10:00:00', 0.998, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.998, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T10:30:00', 1.311, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.311, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T11:00:00', 1.095, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.095, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T11:30:00', 1.32, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.32, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T12:00:00', 1.115, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.115, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T12:30:00', 1.436, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.436, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T13:00:00', 0.89, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.89, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T13:30:00', 1.255, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.255, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T14:00:00', 0.916, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.916, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T14:30:00', 0.955, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.955, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T15:00:00', 0.711, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.711, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T15:30:00', 0.78, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.78, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T16:00:00', 0.606, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.606, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T16:30:00', 0.51, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.51, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T17:00:00', 0.905, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.905, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T17:30:00', 0.66, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.66, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-02T18:00:00', 0.8, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.8, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T00:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T00:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T01:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T01:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T02:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T02:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T03:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T03:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T04:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T04:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T05:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T05:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T06:00:00', 0.335, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.335, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T06:30:00', 0.667, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.667, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T07:00:00', 0.79, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.79, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T07:30:00', 1.023, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.023, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T08:00:00', 1.145, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.145, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T08:30:00', 1.777, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.777, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T09:00:00', 1.563, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.563, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T09:30:00', 1.344, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.344, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T10:00:00', 1.087, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.087, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T10:30:00', 1.453, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.453, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T11:00:00', 0.996, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.996, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T11:30:00', 1.125, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.125, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T12:00:00', 1.435, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.435, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T12:30:00', 1.263, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.263, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T13:00:00', 1.085, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.085, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T13:30:00', 1.487, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.487, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T14:00:00', 1.278, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.278, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T14:30:00', 0.768, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.768, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T15:00:00', 0.878, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.878, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T15:30:00', 0.754, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.754, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T16:00:00', 0.476, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.476, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T16:30:00', 1.045, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.045, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T17:00:00', 1.132, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.132, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T17:30:00', 0.896, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.896, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T18:00:00', 0.8, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.8, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T00:00:00', 79.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 79.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T00:30:00', 0.679, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.679, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T01:00:00', 0.887, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.887, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T01:30:00', 0.784, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.784, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T02:00:00', 0.954, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.954, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T02:30:00', 0.712, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.712, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T03:00:00', 0.599, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.599, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T03:30:00', 0.593, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.593, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T04:00:00', 0.674, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.674, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T04:30:00', 0.799, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.799, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T05:00:00', 0.232, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.232, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-03T05:30:00', 0.61, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.61, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T00:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T00:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T01:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T01:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T02:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T02:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T03:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T03:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T04:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T04:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T05:00:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T05:30:00', 0.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T06:00:00', 0.461, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.461, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T06:30:00', 0.415, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.415, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T07:00:00', 0.778, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.778, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T07:30:00', 0.94, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.94, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T08:00:00', 1.191, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.191, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T08:30:00', 1.345, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.345, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T09:00:00', 1.39, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.39, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T09:30:00', 1.222, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.222, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T10:00:00', 1.134, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.134, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T10:30:00', 1.207, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.207, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T11:00:00', 0.877, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.877, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T11:30:00', 1.655, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.655, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T12:00:00', 1.099, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.099, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T12:30:00', 1.625, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.625, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T13:00:00', 1.01, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.01, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T13:30:00', 0.95, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.95, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T14:00:00', 1.255, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 1.255, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T14:30:00', 0.635, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.635, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T15:00:00', 0.956, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.956, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T15:30:00', 0.88, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.88, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T16:00:00', 0.66, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.66, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T16:30:00', 0.81, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.81, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T17:00:00', 0.878, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.878, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T17:30:00', 0.778, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.778, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T18:00:00', 0.6, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.6, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T00:00:00', 43.0, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 43.0, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T00:30:00', 0.838, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.838, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T01:00:00', 0.812, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.812, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T01:30:00', 0.49, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.49, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T02:00:00', 0.598, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.598, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T02:30:00', 0.811, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.811, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T03:00:00', 0.572, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.572, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T03:30:00', 0.417, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.417, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T04:00:00', 0.707, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.707, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T04:30:00', 0.67, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.67, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T05:00:00', 0.29, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.29, is_flagged = FALSE;
        

            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('NEM1201009', '2005-03-04T05:30:00', 0.355, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = 0.355, is_flagged = FALSE;
        
