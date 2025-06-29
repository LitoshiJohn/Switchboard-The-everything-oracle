WITH weekly_activity AS (
  SELECT
    DATE_TRUNC('week', block_timestamp) as week,
    COUNT(distinct tx_id) as unique_transactions
  FROM
    solana.core.ez_events_decoded
  WHERE program_id = 'SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv'
    AND event_type in ('pull_feed_submit_response_consensus',
                      'pull_feed_submit_response_many',
                      'pull_feed_submit_response')
AND succeeded = 'TRUE'
  GROUP BY 1
  ORDER BY 1 asc
)

SELECT
  week,
  unique_transactions,
  AVG(unique_transactions) OVER ( ORDER BY week ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) as rolling_4week_avg
FROM
  weekly_activity



