# Spreadsheet Answers

## Cleaning Steps

* Removed duplicate records from the raw dataset.
* Trimmed extra spaces from all text fields such as merchant_name, status, and gateway_region.
* Standardized text casing (converted to lowercase/uppercase where required).
* Converted date column into a consistent date format.
* Handled missing and invalid values in risk_score by converting them to numeric and replacing errors with 0.
* Ensured all columns were in correct data types for further processing.

---

## Standardization Rules

* **Merchant Name:** Converted to lowercase and trimmed spaces for consistency.
* **Status:** Standardized into consistent categories such as `captured`, `failed`, and `chargeback`.
* **Risk Score:** Converted to numeric values and cleaned invalid entries.
* **Gateway Region:** Standardized into `APAC`, `EU`, and `US`.
* **Date Format:** Converted into a consistent format for accurate analysis.

---

## Lookup and Enrichment Logic

* Used exchange_rates dataset to convert transaction amounts into USD using currency and date as keys.
* Created a composite key (date + currency) to accurately map exchange rates.
* Enriched transactions using merchant_master dataset based on standardized merchant names.
* Calculated `amount_usd` by multiplying raw_amount with exchange_rate.

---

## Final Answers

* **Total raw rows:** 25
* **Total cleaned rows:** 25
* **Invalid or missing rows handled:** 0 (no rows removed, only cleaned/transformed)
* **Top region by GMV:** APAC
* **Number of high value transactions:** 7
* **Number of high risk transactions:** 6
* **Top merchant by captured GMV:** Alpha Mart

---

## Formula Samples

* **Trim and clean text:**

  ```excel
  =LOWER(TRIM(A2))
  ```

* **Date conversion:**

  ```excel
  =DATEVALUE(A2)
  ```

* **Exchange rate lookup:**

  ```excel
  =XLOOKUP(key, exchange_rates!D:D, exchange_rates!C:C)
  ```

* **Amount in USD:**

  ```excel
  =raw_amount * exchange_rate
  ```

* **High Value Flag:**

  ```excel
  =IF(AND(region="APAC", amount_usd>5000),1,
   IF(AND(region="EU", amount_usd>6000),1,
   IF(AND(region="US", amount_usd>7000),1,0)))
  ```

* **High Risk Flag:**

  ```excel
  =IF(OR(risk_score>=70, ISNUMBER(SEARCH("chargeback", status))),1,0)
  ```
