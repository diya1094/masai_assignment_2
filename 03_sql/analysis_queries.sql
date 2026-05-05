-- Count transactions by status
SELECT status, COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status;

-- Calculate total captured GMV by merchant
SELECT merchant_name, SUM(amount_usd) AS total_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name;

-- Show top 10 merchants by captured GMV
SELECT merchant_name, SUM(amount_usd) AS total_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name
ORDER BY total_gmv DESC
LIMIT 10;

-- Show daily GMV and successful transaction count
SELECT 
    transaction_date,
    SUM(amount_usd) AS daily_gmv,
    COUNT(*) AS successful_transactions
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY transaction_date
ORDER BY transaction_date;

-- Find merchants with chargeback ratio above 1%
SELECT 
    merchant_name,
    SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_name
HAVING chargeback_ratio > 0.01;

-- Find regions with average risk score above 50 and more than 20 transactions
-- Count transactions by status
SELECT status, COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status;

-- Calculate total captured GMV by merchant
SELECT merchant_name, SUM(amount_usd) AS total_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name;

-- Show top 10 merchants by captured GMV
SELECT merchant_name, SUM(amount_usd) AS total_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name
ORDER BY total_gmv DESC
LIMIT 10;

-- Show daily GMV and successful transaction count
SELECT 
    transaction_date,
    SUM(amount_usd) AS daily_gmv,
    COUNT(*) AS successful_transactions
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY transaction_date
ORDER BY transaction_date;

-- Find merchants with chargeback ratio above 1%
SELECT 
    merchant_name,
    SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_name
HAVING chargeback_ratio > 0.01;

-- Find regions with average risk score above 50 and more than 20 transactions
SELECT 
    gateway_region,
    AVG(risk_score) AS avg_risk,
    COUNT(*) AS total_txns
FROM cleaned_transactions
GROUP BY gateway_region
HAVING AVG(risk_score) > 50 AND COUNT(*) > 20;

-- Find users with 3 or more failed or chargeback transactions on the same day
SELECT 
    user_id,
    transaction_date,
    COUNT(*) AS txn_count
FROM cleaned_transactions
WHERE status IN ('failed', 'chargeback')
GROUP BY user_id, transaction_date
HAVING COUNT(*) >= 3;

-- Show chargeback count, unique affected users, and chargeback amount by merchant
