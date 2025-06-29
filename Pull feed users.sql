SELECT 
    distinct signers[0]::string as users,
    l.label_type,
    l.label_subtype,
    l.label,
    l.address_name,
    count(*) as uses
FROM solana.core.ez_events_decoded e
LEFT JOIN solana.core.dim_labels l
    ON l.address = signers[0]::string
WHERE program_id = 'SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv'
    AND event_type in ('pull_feed_submit_response_consensus',
                      'pull_feed_submit_response_many',
                      'pull_feed_submit_response')
    AND succeeded = true 
    AND signers[0] != '31Sof5r1xi7dfcaz4x9Kuwm8J9ueAdDduMcme59sP8gc'
GROUP BY 1, 2, 3, 4, 5
ORDER BY uses DESC;