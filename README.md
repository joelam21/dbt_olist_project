# dbt_olist_project

_A production-grade dbt portfolio project simulating the analytics engineering workflows and team practices found at leading data-driven organizations. Built for demonstration, learning, and as a plug-and-play example of best practices in the modern data stack._

---

## Overview

This project simulates a modern analytics engineering workflow using [dbt](https://www.getdbt.com/) and Snowflake, following production-grade standards. It demonstrates not only advanced technical implementation but also my growth as a data professional—connecting analytics theory with enterprise-ready, real-world execution.

---

## Why I Built This Project

Before dbt, I understood the importance of modularity, reproducibility, and scalability, but struggled to implement them consistently. dbt crystalized these concepts for me—providing the framework to build robust, team-ready analytics solutions. Working through this project has deepened and amplified my passion for data by transforming scattered, ad-hoc workflows into a maintainable, production-grade pipeline.

---

## Professional Value & Key Features

- **Layered Modeling:** Sources → staging → intermediate → marts, with DRY principles and business logic separation.
- **CI/CD & Orchestration:** GitHub Actions for orchestration, including linting, testing, seeding, deployment, and automated dbt docs.
- **Environment Management:** Dev and prod schema separation using secure environment variables.
- **Production Simulation:** Static Olist data treated as live, streaming data to mimic real-world pipelines.
- **Testing & Governance:** SQLFluff, dbt-checkpoint, automated tests, data contracts, and comprehensive documentation.
- **Team-Ready Workflows:** Git-based collaboration (feature → develop → main), PR templates, and onboarding docs.
- **Stakeholder Focus:** Models and documentation designed for downstream business value—enabling analytics, BI, and self-service insights.

---


## Advanced Roadmap & In-Progress Features

This project is being built and documented to the standards of a high-performing data team. Advanced implementation phases include:

- [x] **CI/CD Environment Promotion:** Automated flows from dev → staging → prod.
- [x] **Incremental Models & Snapshots:** Efficient updates for large tables and SCD Type 2 dimension tracking.
- [x] **Custom Macros:** Reusable business logic and advanced data quality checks.
- [x] **Exposures:** Documentation connecting models to downstream BI and stakeholder dashboards.
- [ ] **Monitoring & Observability:** Model run auditing (dbt post-hooks), pipeline monitoring, cost/performance tracking, and alerting.
- [x] **Comprehensive Testing:** Generic, custom, and contract tests
- [ ] **Team Collaboration & Governance:** Code review standards, data governance policies, issue/project templates, and contribution guidelines for team scaling.

---

## What I Learned

Building this project helped me connect the dots between analytics theory and real-world execution. I learned to implement concrete solutions for modularity, reproducibility, CI/CD, and data governance—skills essential for enterprise analytics engineering. Most importantly, dbt has further inspired my excitement for the craft of data, showing me how to deliver business value through reliable, scalable systems.

---

## How to Use This Repo

- **Hiring managers:** Review the pipeline, CI/CD workflow, and docs for evidence of production-grade skills and modern best practices.
- **Peers and learners:** Fork or clone for your own projects, or adapt the setup guides for team onboarding.
- **Feedback is welcome:** Open an issue or pull request to suggest improvements.

---

## Project Structure

- `models/` — dbt models (SQL transformations)
  - `staging/` — source cleaning and standardization
  - `intermediate/` — business logic, joins, and enrichment
  - `marts/` — final reporting and analytics tables
- `seeds/` — CSV files loaded as tables
- `macros/` — custom dbt macros
- `snapshots/` — slowly changing dimension tracking
- `tests/` — custom data tests
- `.github/workflows/dbt-ci-cd.yml` — CI/CD pipeline definition
- `full_setup.sh` — project bootstrap script
- `dbt_project.yml` — dbt project config
- `README.md` — project overview and documentation


---
## Resources

https://public.tableau.com/app/profile/joe.lam1433/vizzes
