WITH oracle_comparison AS (
  SELECT 
    CASE 
      WHEN program_id in ('SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv','SW1TCH7qEPTdLsDHRgPuMQjbQxKdH2aBStViMFnt64f') THEN 'Switchboard'
      WHEN program_id = 'FsJ3A3u2vn5cTVofAjvy6y5kwABJAqYWpe4975bi2epH' THEN 'Pyth'
      WHEN program_id in ('HEvSKofvBgfaexv23kMabbYqxasxU3mQ4ibBMEmJWHny','CH31Xns5z3M1cTAbKW34jcxPPciazARpijcHj9rxtemt') THEN 'Chainlink'
    END as oracle_name,
    tx_id,
    block_timestamp,
    succeeded
  FROM solana.core.fact_events
  WHERE program_id IN (
    'SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv',
    'SW1TCH7qEPTdLsDHRgPuMQjbQxKdH2aBStViMFnt64f',  
    'FsJ3A3u2vn5cTVofAjvy6y5kwABJAqYWpe4975bi2epH',
    'HEvSKofvBgfaexv23kMabbYqxasxU3mQ4ibBMEmJWHny',
    'CH31Xns5z3M1cTAbKW34jcxPPciazARpijcHj9rxtemt'
  )
  AND block_timestamp >= dateadd('day',-90,CURRENT_TIMESTAMP)
)

SELECT 
  oracle_name,
  COUNT(DISTINCT tx_id) as total_transactions,
  COUNT(DISTINCT CASE WHEN succeeded THEN tx_id END) as successful_transactions,
  COUNT(DISTINCT CASE WHEN succeeded THEN tx_id END)::FLOAT / NULLIF(COUNT(DISTINCT tx_id), 0) as success_rate
FROM oracle_comparison
GROUP BY 1
ORDER BY 2 DESC;