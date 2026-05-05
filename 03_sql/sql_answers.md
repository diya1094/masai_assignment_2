# SQL Analysis Report – Transaction Data

## 1. Transaction Distribution by Status

The dataset contains transactions categorized into different statuses such as completed, failed, and chargeback. The distribution highlights that the majority of transactions are successfully completed, while a smaller proportion consists of failed and chargeback transactions. This indicates a generally healthy transaction system with some failure and risk cases.

---

## 2. Total Captured GMV by Merchant

The Gross Merchandise Value (GMV) for completed transactions was calculated for each merchant.

* **Alpha Mart** generated the highest GMV (~465,432 USD), significantly outperforming others.
* **Beta Stores** contributed a moderate GMV (~33,482 USD).
* **Delta Travels** and **City Pharma** showed comparatively lower GMV.

This indicates that Alpha Mart is the dominant revenue contributor in the dataset.

---

## 3. Top Merchants by GMV

The top merchants based on captured GMV are:

1. Alpha Mart
2. Beta Stores
3. Delta Travels
4. City Pharma

Since the dataset contains a limited number of merchants, all merchants appear in the top list. Alpha Mart clearly leads by a large margin.

---

## 4. Daily GMV and Successful Transactions

Daily analysis of completed transactions shows:

* The highest GMV is observed on **06-03-2026**, indicating a spike in transaction value.
* Other days show relatively stable but lower GMV values.
* Successful transaction counts remain fairly consistent across days, suggesting steady transaction volume.

This indicates that while transaction volume is stable, value fluctuations are driven by high-value transactions.

---

## 5. Chargeback Ratio by Merchant

Chargeback ratio identifies the proportion of risky transactions per merchant:

* **Eco Home** has the highest ratio (50%), indicating very high risk.
* **Delta Travels** shows a ratio of 25%, also indicating elevated risk.
* **Alpha Mart** (~10%) and **Beta Stores** (~9%) have relatively lower but still notable risk levels.

This suggests that Eco Home and Delta Travels require immediate attention for fraud or operational issues.

---

## 6. Regional Risk Analysis

No region satisfied the condition of:

* Average risk score > 50
* AND more than 20 transactions

This is due to the limited size of the dataset. However, it indicates that no region currently meets both high risk and high volume thresholds simultaneously.

---

## 7. High-Risk User Behavior

Analysis of users with 3 or more failed or chargeback transactions on the same day revealed:

* **User U008** had 4 such transactions on **05-03-2026**

This indicates potential fraudulent or suspicious activity and highlights the need for monitoring such users.

---

## 8. Chargeback Impact by Merchant

Chargeback analysis shows:

* Each merchant experienced at least one chargeback transaction.
* Chargeback amounts vary significantly:

  * Eco Home (~6588 USD) has the highest financial impact
  * Alpha Mart (~5445 USD) also shows significant loss

Additionally, each chargeback is associated with a unique user, suggesting isolated incidents rather than repeated fraud by the same user.

---

## 9. Overall Insights

* Alpha Mart dominates revenue but also contributes to chargebacks.
* Eco Home and Delta Travels are high-risk merchants based on chargeback ratios.
* Transaction volume is stable across days, but GMV fluctuates due to high-value transactions.
* Certain users (e.g., U008) exhibit suspicious behavior patterns.
* Regional analysis is inconclusive due to limited data size.

---

## 10. Conclusion

The analysis highlights key business insights:

* Revenue concentration is skewed towards a few merchants.
* Risk is unevenly distributed, with some merchants showing significantly higher chargeback ratios.
* Monitoring high-risk users and merchants can help reduce financial losses.

Overall, the dataset demonstrates the importance of combining transaction volume, value, and risk metrics to make informed business decisions.
