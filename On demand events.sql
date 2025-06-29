

SELECT 
  event_type,
  COUNT(DISTINCT tx_id) as unique_txns,
FROM solana.core.ez_events_decoded
WHERE program_id = 'SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv'
GROUP BY 1
ORDER BY 2 DESC
