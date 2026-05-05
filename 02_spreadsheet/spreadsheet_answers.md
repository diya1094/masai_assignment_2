# Data Cleaning and Transformation Summary

## 1. Data Cleaning

The raw transaction dataset was cleaned by removing duplicate records and handling inconsistent formatting. Text fields such as merchant names, status, and regions were trimmed to remove extra spaces and standardized for consistency. Missing and invalid values in numerical fields like risk scores were converted into proper numeric format.

---

## 2. Standardization

### Merchant Names

Merchant names were standardized by converting them to lowercase and removing extra spaces to ensure consistent matching across datasets.

### Status Values

All status values were normalized to lowercase.

### Risk Scores

Risk scores were converted into numeric values, and invalid entries were handled to ensure accurate calculations.

### Gateway Regions

Gateway regions were standardized into lower case.
---

## 3. Currency Conversion

Transaction amounts were converted into a single reporting currency (USD).
This was achieved by joining the transactions dataset with the exchange rates dataset using a composite key of `transaction_date` and `currency`. The USD amount was calculated by multiplying the raw amount with the corresponding exchange rate.

---

## 4. Data Enrichment

The transactions dataset was enriched using the merchant master dataset by matching standardized merchant names. This ensured consistency and allowed better aggregation at the merchant level.

---

## 5. Feature Engineering

### High Value Flag

A `high_value_flag` was created based on region-specific thresholds:

* APAC: amount_usd > 5000
* EU: amount_usd > 6000
* US: amount_usd > 7000

### High Risk Flag

A `high_risk_flag` was assigned when:

* risk_score ≥ 70, OR
* transaction status contains "chargeback"

---

## 6. Merchant Risk Summary

A summary dataset was created using aggregation at the merchant level. The following metrics were calculated:

* Total transaction amount in USD
* Total high value transactions
* Total high risk transactions

This summary provides insights into merchant performance and risk exposure.

---

## 7. Final Output

Two final output files were generated:

* `cleaned_transactions.csv` containing the cleaned and enriched transaction data
* `merchant_risk_summary.csv` containing aggregated merchant-level insights

All intermediate helper columns used during processing were removed to ensure the final dataset is clean, structured, and analysis-ready.
