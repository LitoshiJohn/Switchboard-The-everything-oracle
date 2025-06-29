
select
event_type,
COUNT(distinct tx_id) as events
from solana.core.ez_events_decoded
where program_id in ('SW1TCH7qEPTdLsDHRgPuMQjbQxKdH2aBStViMFnt64f', 'SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv')
and event_type ilike 'oracle%'
and succeeded = 'TRUE'
group by 1
order by 2 desc



