-- Overal churn rate
SELECT 
    ROUND(
        SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM churn;

-- Churn rate by plan
SELECT 
    s.plan_type,
    ROUND(
        SUM(CASE WHEN c.churned = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn c
JOIN subscriptions s ON c.customer_id = s.customer_id
GROUP BY s.plan_type;

-- Average revenue per user (ARPU)
SELECT 
    ROUND(AVG(monthly_revenue), 2) AS arpu
FROM payments;

-- Estimated customer lifetime value(LTV)
-- LTV = ARPU / churn rate
WITH churn_rate AS (
    SELECT 
        SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS rate
    FROM churn
)
SELECT 
    ROUND(AVG(p.monthly_revenue) / cr.rate, 2) AS estimated_ltv
FROM payments p, churn_rate cr;

-- High rist customers (Early signal)
SELECT 
    u.customer_id,
    u.usage_hours,
    s.ticket_count,
    c.churned
FROM usage u
JOIN support_tickets s ON u.customer_id = s.customer_id
JOIN churn c ON u.customer_id = c.customer_id
WHERE u.usage_hours < 5 AND s.ticket_count >= 3;

