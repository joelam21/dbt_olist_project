# SCD2 Snapshot Strategy for Sellers

## Purpose
This project uses dbt's SCD Type 2 (Slowly Changing Dimension) snapshotting to track changes to seller attributes over time. This enables full historical analysis and auditing of seller data.

## How It Works
- The `sellers_snapshot` snapshot records a new row whenever a tracked attribute (zip code, city, state) changes for a seller.
- Each row includes `dbt_valid_from` and `dbt_valid_to` timestamps to indicate the period during which the record was valid.
- The current version for each seller is identified by `dbt_valid_to IS NULL`.
- **Note:** The `check` strategy is used because the source data does not include a reliable updated timestamp. This strategy tracks changes by comparing the values of specified columns on each run.

## Key Models
- **snapshots/sellers_snapshot.sql**: The SCD2 snapshot definition using dbt's `check` strategy.
- **models/audit/current_sellers.sql**: Returns only the current (active) version of each seller.
- **models/audit/sellers_scd2_changes.sql**: Identifies all sellers with more than one SCD2 version (i.e., sellers whose tracked attributes have changed).

## Best Practices
- Always use `{{ ref('sellers_snapshot') }}` in downstream models for environment portability.
- Use audit models to monitor and report on changes.
- Add tests to ensure only one current version per seller and no overlapping validity windows.
- Document tracked columns and snapshot logic for maintainability.

## Example Use Cases
- Join `current_sellers` with fact tables for up-to-date seller attributes.
- Use `sellers_scd2_changes` to audit and investigate historical changes.

---

_Last updated: 2025-07-29_
