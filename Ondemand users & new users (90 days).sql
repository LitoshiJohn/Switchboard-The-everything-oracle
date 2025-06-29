-- First CTE to get initial user activity
WITH base_events AS (
    SELECT 
        DATE_TRUNC('week', block_timestamp) as week,
        signers[0] as user_address
    FROM solana.core.ez_events_decoded
    WHERE program_id = 'SBondMDrcV3K4kxZR1HNVT7osZxAHVHgYXL5Ze1oMUv'
    AND block_timestamp >= DATEADD('day', -90, CURRENT_DATE())
),

-- Second CTE to get first interaction date for each user
first_interaction AS (
    SELECT 
        user_address,
        MIN(week) as first_week
    FROM base_events
    GROUP BY 1
),

-- Third CTE to calculate weekly metrics
weekly_metrics AS (
    SELECT 
        b.week,
        COUNT(DISTINCT b.user_address) as weekly_users,
        COUNT(DISTINCT CASE 
            WHEN b.week = f.first_week THEN b.user_address 
            END) as new_users
    FROM base_events b
    LEFT JOIN first_interaction f
        ON b.user_address = f.user_address
    GROUP BY 1
)

-- Final select with cumulative users
SELECT 
    week,
    weekly_users,
    new_users,
    SUM(weekly_users) OVER (ORDER BY week) as cumulative_users
FROM weekly_metrics
ORDER BY week;