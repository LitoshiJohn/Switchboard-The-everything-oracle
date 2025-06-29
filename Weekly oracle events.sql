select 
date_trunc('week',block_timestamp) as week,
event_type,
count(distinct tx_id) as events
from solana.core.ez_events_decoded
where program_id IN ('SW1TCH7qEPTdLsDHRgPuMQjbQxKdH2aBStViMFnt64f','SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv') --Switchboard Solana program id
and succeeded = 'TRUE'
and event_type ilike 'oracle%'
group by 1,2 
order by 1 desc