# approval sla breached
{% docs approval_sla_breached %}
Boolean flag indicating if the days to approve exceeded the SLA threshold.
{% enddocs %}

# average stock
{% docs average_stock %}
The average stock level declared by the lead.
{% enddocs %}

# business segment
{% docs business_segment %}
The business segment classification for the closed deal.
{% enddocs %}

# business type
{% docs business_type %}
The type of business associated with the closed deal.
{% enddocs %}

# category
{% docs category %}
Broad, business-defined category used for grouping and rollup reporting (e.g., 'Home & Living', 'Electronics').
{% enddocs %}

# carrier sla breached
{% docs carrier_sla_breached %}
Boolean flag indicating if the days to carrier handoff exceeded the SLA threshold.
{% enddocs %}

# channel
{% docs channel %}
The grouped marketing channel associated with the origin, used for attribution and reporting (e.g., Direct, Paid, Organic, Social, Referral, Unknown, Other).
{% enddocs %}

# cumulative payment
{% docs cumulative_payment %}
The running total of payment values for an order up to and including the current payment.
Calculated as the sum of `payment_value` for each `order_id`, ordered by `payment_sequential`, using a window function. This represents the cumulative amount paid for an order at each payment installment.
{% enddocs %}

# customer city
{% docs customer_city %}
City in which the customer is located.
{% enddocs %}

# customerid foregin key
{% docs customer_id_fk %}
Foreign key referencing the customers table. Used to associate this record with a specific customer.
{% enddocs %}

# customer id (marts)
{% docs customer_id_marts %}
The unique identifier for a customer across all orders and tables in the marts layer.
This field is sourced from `customer_unique_id` in the raw data, but is renamed to `customer_id` in marts and dimension tables for clarity and consistency.
Use this field for customer-level analysis and joins.
{% enddocs %}

# customerid primary key
{% docs customer_id_pk %}
Primary key for the customers table. Used to uniquely identify each customer and join with related tables such as orders or reviews.
{% enddocs %}

# customer order id
{% docs customer_order_id %}
A surrogate key representing the customer for a specific order.
This field is unique per order, but not per customer—customers who place multiple orders will have multiple `customer_order_id` values.
It is sourced from `customer_id` in the raw data and is primarily used for joining order-level records.
For true customer-level analysis, use `customer_id` (which is sourced from `customer_unique_id`).
{% enddocs %}

# customer state
{% docs customer_state %}
Two-letter abbreviation of the state in which the customer is located.
{% enddocs %}

# customer unique id
{% docs customer_unique_id %}
Identifier representing an individual customer across multiple orders. This value may appear more than once in the table if the customer placed multiple orders.
{% enddocs %}

# customer zip code prefix
{% docs customer_zip_code_prefix %}
ZIP code prefix representing the customer’s general geographic location.
{% enddocs %}

# declared product catalog size
{% docs declared_product_catalog_size %}
The number of products declared in the lead's product catalog.
{% enddocs %}

# declared monthly revenue
{% docs declared_monthly_revenue %}
The monthly revenue declared by the lead.
{% enddocs %}

# dim_dates_date
{% docs dim_dates_date %}
The calendar date represented by this row. This is the primary key for the date dimension.
{% enddocs %}

# dim_dates_year
{% docs dim_dates_year %}
The four-digit year extracted from the date.
{% enddocs %}

# dim_dates_month
{% docs dim_dates_month %}
The month number (1–12) extracted from the date.
{% enddocs %}

# dim_dates_day
{% docs dim_dates_day %}
The day of the month (1–31) extracted from the date.
{% enddocs %}

# dim_dates_quarter
{% docs dim_dates_quarter %}
The quarter of the year (1–4) in which the date falls.
{% enddocs %}

# dim_dates_week
{% docs dim_dates_week %}
The ISO week number (1–53) extracted from the date.
{% enddocs %}

# dim_dates_day_of_week
{% docs dim_dates_day_of_week %}
The day of the week as an integer (0=Sunday, 6=Saturday).
{% enddocs %}

# dim_dates_is_weekend
{% docs dim_dates_is_weekend %}
Boolean flag indicating if the date falls on a weekend (Saturday or Sunday).
{% enddocs %}

# dim_dates_is_month_start
{% docs dim_dates_is_month_start %}
Boolean flag indicating if the date is the first day of the month.
{% enddocs %}

# dim_dates_is_month_end
{% docs dim_dates_is_month_end %}
Boolean flag indicating if the date is the last day of the month.
{% enddocs %}

# dim_dates_day_abbr
{% docs dim_dates_day_abbr %}
Three-letter abbreviation for the day of the week (e.g., MON, TUE).
{% enddocs %}

# dim_dates_month_abbr
{% docs dim_dates_month_abbr %}
Three-letter abbreviation for the month (e.g., JAN, FEB).
{% enddocs %}

# first contact date
{% docs first_contact_date %}
The date when the lead first made contact.
{% enddocs %}

# freight total
{% docs freight_total %}
The total freight value for all items in the order, calculated as the sum of the `freight_value` column for each item in the order.
{% enddocs %}

# freight value
{% docs freight_value %}
Freight cost charged to the customer for this item.
{% enddocs %}

# fulfilment delay summary
{% docs fulfillment_delay_summary %}
A summary field indicating the fulfillment outcome for the order.
Possible values:
- `'on time'`: The order was delivered on or before the estimated delivery date.
- `'canceled'`: The order was canceled before delivery.
- `'not delivered'`: The order was not delivered and the delivery window has passed.
- `'in progress'`: The order is not yet delivered, but the delivery window has not yet passed.
- `'approval'`, `'carrier'`, `'last mile'`: Indicates which SLA(s) were breached for delivered but late orders (may be a comma-separated list if multiple SLAs were breached).

This field provides a concise, business-friendly summary of fulfillment performance for each order.
{% enddocs %}

# geolocation
{% docs geolocation_city %}
Name of the city associated with the geographic location.
{% enddocs %}

{% docs geolocation_lat %}
Latitude coordinate for a given ZIP code prefix, representing a general geographic location.
{% enddocs %}

{% docs geolocation_lng %}
Longitude coordinate for a given ZIP code prefix, representing a general geographic location.
{% enddocs %}

{% docs geolocation_state %}
Two-letter abbreviation of the state associated with the geographic location.
{% enddocs %}

{% docs geolocation_zip_code_prefix %}
ZIP code prefix for the geographic location.
{% enddocs %}

# has company
{% docs has_company %}
Boolean flag indicating whether the lead is associated with a company (`true`) or not (`false`).
{% enddocs %}

# has gtin
{% docs has_gtin %}
Boolean flag indicating whether the lead has a Global Trade Item Number (GTIN) (`true`) or not (`false`).
{% enddocs %}

# is final payment
{% docs is_final_payment %}
A boolean flag indicating whether the current payment is the final installment for the order.
This is `true` if the `payment_sequential` value equals the `total_installments` for the order, and `false` otherwise.
{% enddocs %}

# is overpaid order
{% docs is_overpaid_order %}
A boolean flag indicating whether the total payments made for an order exceed the order total.
This is `true` if the minimum remaining balance for the order is less than zero, meaning the order has been overpaid; otherwise, it is `false`.
{% enddocs %}

# is_won
{% docs is_won %}
Boolean flag indicating whether the lead was converted to a won deal.
`1` (true) if the lead has a non-null `won_date`, otherwise `0` (false).
This enables conversion rate analysis and segmentation by lead attributes.
{% enddocs %}

# item total value
{% docs item_total_value %}
The total value of an order item, calculated as the sum of the product price and the freight value for that item.
Formula: `price + freight_value`
{% enddocs %}

# last mile sla breached
{% docs last_mile_sla_breached %}
Boolean flag indicating if the days to customer delivery exceeded the dynamic last mile threshold.
{% enddocs %}

# lead behaviour profile
{% docs lead_behaviour_profile %}
A profile describing the lead's behavior, such as 'cat', 'wolf', 'eagle', etc.
{% enddocs %}

# landing page id
{% docs landing_page_id %}
The identifier of the landing page where the lead was captured.
{% enddocs %}

# lead type
{% docs lead_type %}
The type of lead (e.g., online_big, online_medium, industry, etc.).
{% enddocs %}

# mql id
{% docs mql_id %}
A unique identifier for the marketing qualified lead (MQL) associated with this deal.
{% enddocs %}

# num_items
{% docs num_items %}
The total number of items included in the order.
Calculated as the count of order items associated with a single order_id.
This field is useful for analyzing order size and basket composition.
{% enddocs %}

# order approved at
{% docs order_approved_at %}
Timestamp when the order was approved by the system.
{% enddocs %}

# order delivered
{% docs order_delivered_on_time %}
Boolean flag indicating whether the order was delivered to the customer on or before the estimated delivery date.
`true` if the delivery was on time, `false` otherwise.
{% enddocs %}

{% docs order_delivered_carrier_date %}
Timestamp when the order was handed over to the carrier.
{% enddocs %}

{% docs order_delivered_customer_date %}
Timestamp when the customer received the order.
{% enddocs %}

# order days to approve
{% docs order_days_to_approve %}
The number of days between when the order was placed and when it was approved by the system.
Calculated as the difference between `order_purchase_timestamp` and `order_approved_at`.
{% enddocs %}

# order days to carrier
{% docs order_days_to_carrier %}
The number of days between when the order was approved and when it was handed off to the carrier.
Calculated as the difference between `order_approved_at` and `order_delivered_carrier_date`.
{% enddocs %}

# order days to customer
{% docs order_days_to_customer %}
The number of days between when the order was handed off to the carrier and when it was delivered to the customer.
Calculated as the difference between `order_delivered_carrier_date` and `order_delivered_customer_date`.
{% enddocs %}

# order delivery
{% docs order_delivery_days %}
The number of days between the order purchase and the actual delivery to the customer.
{% enddocs %}

{% docs order_delivery_window_days %}
The number of days between the order purchase and the estimated delivery date.
{% enddocs %}

# order estimated delivery date
{% docs order_estimated_delivery_date %}
Estimated delivery date at the time of purchase.
{% enddocs %}

# order id
{% docs order_id_fk %}
Foreign key referencing the orders table. Indicates which order this record is associated with.
{% enddocs %}

{% docs order_id_pk %}
Primary key of the orders table. Uniquely identifies a customer order.
{% enddocs %}

# order item key
{% docs order_item_key %}
Surrogate key uniquely identifying each item in an order. Generated by combining order_id and order_item_id to support reliable joins and primary key constraints in downstream models.
{% enddocs %}

# order item id
{% docs order_item_id %}
Position of the item within the order. Combined with order_id to form a unique key.
{% enddocs %}

# order payment key
{% docs order_payment_key %}
Surrogate key that uniquely identifies each payment transaction within an order. Generated by combining order_id and payment_sequential to ensure reliable joins and enforce uniqueness in downstream models.
{% enddocs %}

# order purchase timestamp
{% docs order_purchase_timestamp %}
Timestamp when the order was placed.
{% enddocs %}

# order status
{% docs order_status %}
Current status of the order (e.g., delivered, shipped, canceled).
{% enddocs %}

# order total
{% docs order_total %}
The total value of an order, calculated as the sum of the product price and freight value for all items in the order.
{% enddocs %}

# origin
{% docs origin %}
The original source or medium from which the marketing lead originated (e.g., direct_traffic, email, social, etc.).
{% enddocs %}

# overpaid_amount
{% docs overpaid_amount %}
The amount by which the total payments for an order exceed the order total.
A positive value indicates the order has been overpaid; zero means the order is fully paid or underpaid.
Calculated as the cumulative payments minus the order total, but only when this value is greater than zero.
{% enddocs %}

# payment
{% docs payment_installments %}
Number of payment installments selected for the order.
This represents the customer's chosen payment plan (e.g., 3 for a 3-installment plan).
**Note:** This value can change over time if the customer modifies their payment plan after the initial payment.
For some orders, you may see multiple values for `payment_installments` as the payment plan is updated during the order lifecycle.
{% enddocs %}

{% docs payment_method %}
Method of payment used, such as credit card, boleto, or voucher.
{% enddocs %}

{% docs payment_number %}
The sequential number of each payment event for an order, starting at 1.
This value is calculated in the model using a window function (`row_number()` over `order_id`), and indicates the order in which payments were made for each order, regardless of which installment they were applied to.
{% enddocs %}

{% docs payment_progress_pct %}
The percentage of the order total that has been paid up to the current payment installment.
Calculated as the cumulative payment divided by the order total, rounded to two decimal places. Values greater than 1 indicate overpayment.
{% enddocs %}

{% docs payment_sequential %}
The payment sequence number as provided by the source system.
Note: In some cases, this value does not start at 1 for each order due to source system inconsistencies.
For a reliable sequential count of payments per order, use `payment_number`.
{% enddocs %}

{% docs payment_status %}
A categorical status describing the payment state for the order at the current installment.
Possible values include 'unpaid', 'partial', 'paid', or 'overpaid', based on the relationship between cumulative payments and the order total.
{% enddocs %}

{% docs payment_type %}
Method of payment used, such as credit card, boleto, or voucher.
{% enddocs %}

{% docs payment_value %}
Total amount paid in BRL for this payment record.
{% enddocs %}

# price
{% docs price %}
Monetary value (in BRL) paid by the customer for the product item.
{% enddocs %}

# price total
{% docs price_total %}
The total price of all items in the order, calculated as the sum of the `price` column for each item in the order. Does not include freight.
{% enddocs %}

# product category
{% docs product_category_name %}
Original product category name in Portuguese. Joins to the 'products' table to enable translation.
{% enddocs %}

{% docs product_category_name_english %}
Translated version of the original Portuguese product_category_name, mapped to English for easier readability and standardized reporting. Not present in the raw source data.
{% enddocs %}

# product description length
{% docs product_description_length %}
Character length of the product description.
{% enddocs %}

# product id
{% docs product_id_fk %}
Foreign key to the product that was purchased.
{% enddocs %}

{% docs product_id_pk %}
Primary key for the products table. Used to uniquely identify each product and join with other tables such as order_items.
{% enddocs %}

# product height cm
{% docs product_height_cm %}
Product height in centimeters.
{% enddocs %}

# product length cm
{% docs product_length_cm %}
Product length in centimeters.
{% enddocs %}

# product width cm
{% docs product_width_cm %}
Product width in centimeters.
{% enddocs %}

# product name length
{% docs product_name_length %}
Character length of the product name field.
{% enddocs %}

# product photos qty
{% docs product_photos_qty %}
Number of photos uploaded for the product.
{% enddocs %}

# product weight g
{% docs product_weight_g %}
Product weight in grams.
{% enddocs %}

# remaining balance
{% docs remaining_balance %}
The outstanding amount left to be paid on an order after accounting for all payments up to the current installment.
Calculated as the difference between the order total and the cumulative payment amount for each order.
A positive value indicates an outstanding balance, zero means the order is fully paid, and a negative value indicates the order has been overpaid.
{% enddocs %}

# review
{% docs review_answer_timestamp %}
Timestamp when the review was responded to by the platform or processed internally.
{% enddocs %}

{% docs review_creation_date %}
Timestamp when the customer submitted the review.
{% enddocs %}

{% docs review_comment_message %}
Optional free-text message written by the customer describing their experience.
{% enddocs %}

{% docs review_comment_title %}
Optional title provided by the customer as a summary of their review message.
{% enddocs %}

{% docs review_id %}
Identifier for a customer review. While it resembles a primary key, it may be linked to multiple orders and is not a unique record.
{% enddocs %}

{% docs review_key %}
Surrogate key uniquely identifying each review record. Generated by combining review_id and order_id to resolve duplicate review_ids associated with multiple orders in the raw data, ensuring row-level uniqueness and referential integrity.
{% enddocs %}

{% docs review_score %}
Customer's rating of the order experience on a scale from 1 (worst) to 5 (best).
{% enddocs %}

# sdr id
{% docs sdr_id %}
A unique identifier for the Sales Development Representative (SDR) involved in the deal.
{% enddocs %}

# seller city
{% docs seller_city %}
The name of the city where the seller is located.
{% enddocs %}

# seller id
{% docs seller_id_fk %}
Foreign key referencing the sellers table. Indicates which seller this record is associated with.
{% enddocs %}

{% docs seller_id_pk %}
Primary key for the sellers table. Uniquely identifies each seller and is used to join with other tables such as order_items.
{% enddocs %}

# seller state
{% docs seller_state %}
The two-letter abbreviation of the state where the seller is located.
{% enddocs %}

# seller zip code prefix
{% docs seller_zip_code_prefix %}
The first digits of the seller’s ZIP code, representing their general geographic location.
{% enddocs %}

# shipping limit date
{% docs shipping_limit_date %}
Deadline for the seller to ship the product to the logistics partner.
{% enddocs %}

# sla days to approve
{% docs sla_days_to_approve %}
The SLA threshold (in days) for order approval.
This value is sourced from the SLA thresholds seed or dimension table, and represents the maximum allowed days from order placement to approval, as defined by business rules in effect at the time of the order.
{% enddocs %}

# sla days to carrier
{% docs sla_days_to_carrier %}
The SLA threshold (in days) for carrier handoff.
This value is sourced from the SLA thresholds seed or dimension table, and represents the maximum allowed days from order approval to carrier handoff, as defined by business rules in effect at the time of the order.
{% enddocs %}

# sr id
{% docs sr_id %}
A unique identifier for the Sales Representative (SR) involved in the deal.
{% enddocs %}

# subcategory
{% docs subcategory %}
Product subcategory name in English. Joins to the 'product_category_name_english' column in the 'category_translation' or 'products' table.
{% enddocs %}

# total installments
{% docs total_installments %}
The total number of scheduled payment installments for the order.
This is the maximum `payment_installments` value for each `order_id`, representing the highest number of installments the customer selected during the order lifecycle.
Note: This value may change if the customer modifies their payment plan after the initial payment.
{% enddocs %}

# sla days to last mile
{% docs sla_days_to_last_mile %}
A dynamic threshold for last mile delivery, calculated as the remaining days in the delivery window after accounting for the SLA days to approve and carrier handoff.
Formula: `delivery_window_days - sla_days_to_approve - sla_days_to_carrier`.
This value adapts to each order’s delivery window and the current SLA policy.
{% enddocs %}

# won date
{% docs won_date %}
The date when the deal was marked as won.
{% enddocs %}

# order created at
{% docs order_created_at %}
Timestamp when customer completed the purchase (UTC timezone).
Standardized naming from order_purchase_timestamp for consistency across models.
Used for trend analysis and operational reporting.
{% enddocs %}

# order status category
{% docs order_status_category %}
Simplified business-friendly grouping of order statuses.
Values: 'completed', 'in_progress', 'cancelled', 'created'
Used for high-level reporting and executive dashboards.
{% enddocs %}

# is order completed
{% docs is_order_completed %}
Boolean flag indicating if order reached delivered or shipped status.
True for delivered/shipped orders, false otherwise.
Used for conversion rate analysis and revenue recognition.
{% enddocs %}

# order shipped at
{% docs order_shipped_at %}
Date when order was delivered to carrier for shipping.
Standardized naming from order_delivered_carrier_date.
Null for orders not yet shipped or cancelled before shipping.
Used for logistics performance analysis.
{% enddocs %}

# order date
{% docs order_date %}
Date portion of order creation (YYYY-MM-DD format).
Used for daily aggregations and time-series analysis.
{% enddocs %}

# order year
{% docs order_year %}
Year when order was created (YYYY). Used for annual reporting.
{% enddocs %}

# order month
{% docs order_month %}
Month when order was created (1-12). Used for seasonal analysis.
{% enddocs %}

# order day
{% docs order_day %}
Day of month when order was created (1-31).
{% enddocs %}

# order day of week
{% docs order_day_of_week %}
Day of week when order was created (1=Sunday, 7=Saturday).
Used for weekly pattern analysis and staffing optimization.
{% enddocs %}

# delivery delay days
{% docs delivery_delay_days %}
Number of days between estimated and actual delivery date.
Positive values indicate late delivery, negative values indicate early delivery.
Null for orders not yet delivered. Used for delivery performance KPIs.
{% enddocs %}

# total delivery days
{% docs total_delivery_days %}
Total number of days from order creation to customer delivery.
Null for orders not yet delivered.
Used for end-to-end logistics performance analysis.
{% enddocs %}

# has missing ship date
{% docs has_missing_ship_date %}
Data quality flag indicating orders delivered without recorded ship date.
True indicates potential data quality issue in source system.
Used for data quality monitoring and alerting.
{% enddocs %}

# is severely delayed
{% docs is_severely_delayed %}
Business flag for orders delayed more than 30 days past estimate.
Used for customer service prioritization and logistics investigation.
False for orders delivered on time or not yet delivered.
{% enddocs %}
