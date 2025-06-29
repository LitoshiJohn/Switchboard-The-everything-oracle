WITH hourly_stats AS (
  SELECT 
    EXTRACT(HOUR FROM block_timestamp) as hour_of_day,
    CASE EXTRACT(DOW FROM block_timestamp)
      WHEN 0 THEN 'Sunday'
      WHEN 1 THEN 'Monday'
      WHEN 2 THEN 'Tuesday'
      WHEN 3 THEN 'Wednesday'
      WHEN 4 THEN 'Thursday'
      WHEN 5 THEN 'Friday'
      WHEN 6 THEN 'Saturday'
    END as day_of_week,
    COUNT(DISTINCT tx_id) as transaction_count,
    COUNT(DISTINCT signers[0]) as unique_users
  FROM solana.core.ez_events_decoded
  WHERE program_id = 'SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv'
    AND block_timestamp >= DATEADD('day', -90, CURRENT_DATE())
  GROUP BY 1, 2
)
SELECT 
  hour_of_day,
  day_of_week,
  transaction_count,
  unique_users,
  ROUND(transaction_count/unique_users, 2) as tx_per_user
FROM hourly_stats
ORDER BY 
  CASE day_of_week
    WHEN 'Monday' THEN 1
    WHEN 'Tuesday' THEN 2
    WHEN 'Wednesday' THEN 3
    WHEN 'Thursday' THEN 4
    WHEN 'Friday' THEN 5
    WHEN 'Saturday' THEN 6
    WHEN 'Sunday' THEN 7
  END,
  hour_of_day;