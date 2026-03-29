
-- =============================================
-- Credit Card Fraud Detection — SQL Analysis
-- =============================================

-- Query 1: Basic Fraud Summary
SELECT 
    Class,
    COUNT(*)                    AS total_transactions,
    ROUND(AVG(Amount), 2)       AS avg_amount,
    ROUND(MAX(Amount), 2)       AS max_amount,
    ROUND(MIN(Amount), 2)       AS min_amount
FROM transactions
GROUP BY Class;


-- Query 2: High Frequency Suspicious Transactions
SELECT
    Time,
    COUNT(*)                            AS transactions_same_second,
    SUM(Class)                          AS fraud_count,
    ROUND(SUM(Amount), 2)               AS total_amount,
    ROUND(AVG(Amount), 2)               AS avg_amount
FROM transactions
GROUP BY Time
HAVING COUNT(*) > 2
ORDER BY fraud_count DESC
LIMIT 15;


-- Query 3: Hourly Fraud Patterns
SELECT
    CAST(Time/3600 AS INT)                   AS hour_of_day,
    COUNT(*)                                 AS total_transactions,
    SUM(Class)                               AS fraud_count,
    ROUND(SUM(Class) * 100.0 / COUNT(*), 3) AS fraud_rate_pct
FROM transactions
GROUP BY hour_of_day
ORDER BY fraud_rate_pct DESC
LIMIT 10;
