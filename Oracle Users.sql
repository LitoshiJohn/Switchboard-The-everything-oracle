SELECT 
    distinct signers[0]::string as users,
    count (*) as uses
FROM solana.core.ez_events_decoded
WHERE program_id in ('SW1TCH7qEPTdLsDHRgPuMQjbQxKdH2aBStViMFnt64f','SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv')
and event_type ilike 'oracle%'
and succeeded = true 
and signers[0] != '31Sof5r1xi7dfcaz4x9Kuwm8J9ueAdDduMcme59sP8gc'
group by 1 
order by 2 desc