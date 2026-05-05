# SQL Answers

> **Tool Used:** Queries were run using an online SQL tool (sqliteonline.com) by importing `clean_transaction.csv` as a table named `cleaned_transactions`.


## Q1
### Query
```sql
SELECT status, COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status;
```
### Result Summary
The 29 transactions are distributed across 3 statuses:

| Status | Count |
|---|---|
| captured | 18 |
| chargeback | 4 |
| failed | 7 |

Captured transactions form the majority (~62%), while chargebacks represent the smallest share (~14%).

---

## Q2
### Query
```sql
SELECT merchant_name, SUM(amount_usd) AS total_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name;
```
### Result Summary
Total captured GMV per merchant:

| Merchant | Total GMV (USD) |
|---|---|
| alpha mart | 465,432.50 |
| beta stores | 33,482.00 |
| city pharma | 8,720.00 |
| delta travels | 10,300.00 |

Eco Home had no captured transactions (both transactions were chargeback and failed). Alpha Mart dominates captured GMV, largely due to an anomalous exchange rate on T022 (2026-03-06).

---

## Q3
### Query
```sql
SELECT merchant_name, SUM(amount_usd) AS total_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name
ORDER BY total_gmv DESC
LIMIT 10;
```
### Result Summary
Ranking of merchants by captured GMV (all 4 active merchants shown):

1. alpha mart — 465,432.50 USD
2. beta stores — 33,482.00 USD
3. delta travels — 10,300.00 USD
4. city pharma — 8,720.00 USD

The dataset has only 5 distinct merchants, with alpha mart accounting for over 95% of captured GMV.

---

## Q4
### Query
```sql
SELECT
    transaction_date,
    SUM(amount_usd) AS daily_gmv,
    COUNT(*) AS successful_transactions
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY transaction_date
ORDER BY transaction_date;
```
### Result Summary
Daily captured GMV and transaction counts:

| Date | Daily GMV (USD) | Successful Txns |
|---|---|---|
| 01-03-2026 | 23,986.00 | 4 |
| 02-03-2026 | 11,080.00 | 3 |
| 03-03-2026 | 16,059.50 | 4 |
| 04-03-2026 | 13,894.00 | 4 |
| 05-03-2026 | 6,188.00 | 1 |
| 06-03-2026 | 446,727.00 | 2 |

The spike on 06-03-2026 is caused by T022 (Alpha Mart, INR) receiving an incorrect exchange rate of 1.08 instead of ~0.0119, inflating the USD amount to 442,800.

---

## Q5
### Query
```sql
SELECT
    merchant_name,
    SUM(CASE WHEN status = 'chargeback' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_name
HAVING chargeback_ratio > 0.01;
```
### Result Summary
All merchants except City Pharma exceed the 1% threshold:

| Merchant | Chargeback Ratio |
|---|---|
| alpha mart | 0.1 (10.00%) |
| beta stores | 0.0909090909090909091 (~9.09%) |
| delta travels | 0.25 (25.00%) |
| eco home | 0.5 (50.00%) |

Eco Home and Delta Travels carry the highest chargeback risk and warrant immediate review.

---

## Q6
### Query
```sql
SELECT
    gateway_region,
    AVG(risk_score) AS avg_risk,
    COUNT(*) AS total_txns
FROM cleaned_transactions
GROUP BY gateway_region
HAVING AVG(risk_score) > 50 AND COUNT(*) > 20;
```
### Result Summary
**No rows returned.**

The dataset contains only 29 transactions in total. No single region has more than 20 transactions, so the `COUNT(*) > 20` condition eliminates all groups. This query would yield meaningful results on a larger production dataset.

---

## Q7
### Query
```sql
SELECT
    user_id,
    transaction_date,
    COUNT(*) AS txn_count
FROM cleaned_transactions
WHERE status IN ('failed', 'chargeback')
GROUP BY user_id, transaction_date
HAVING COUNT(*) >= 3;
```
### Result Summary
| User ID | Date | Txn Count |
|---|---|---|
| U008 | 05-03-2026 | 4 |

User U008 had 4 failed/chargeback transactions on 05-03-2026 (T016, T017, T018, T019), indicating potentially suspicious or fraudulent behaviour requiring investigation.

---

## Q8
### Query
```sql
SELECT
    merchant_name,
    COUNT(*) AS chargeback_count,
    COUNT(DISTINCT user_id) AS unique_users,
    SUM(amount_usd) AS chargeback_amount
FROM cleaned_transactions
WHERE status = 'chargeback'
GROUP BY merchant_name;
```
### Result Summary
| Merchant | Chargeback Count | Unique Users | Chargeback Amount (USD) |
|---|---|---|---|
| alpha mart | 1 | 1 | 5,445.00 |
| beta stores | 1 | 1 | 1,711.00 |
| delta travels | 1 | 1 | 2,500.00 |
| eco home | 1 | 1 | 6,588.00 |

Each chargeback involves a distinct user, suggesting isolated incidents rather than repeated fraud by the same user. Eco Home carries the highest single chargeback financial exposure.