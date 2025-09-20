# Netflix Data Engineering Pipeline (Airflow + DBT + Docker)

![Python](https://img.shields.io/badge/python-3.9-blue)
![Airflow](https://img.shields.io/badge/airflow-2.7-brightgreen)
![DBT](https://img.shields.io/badge/dbt-1.7-orange)
![Docker](https://img.shields.io/badge/docker-compose-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

📊 **End-to-end data engineering project** that demonstrates how to build a modern data pipeline using **Apache Airflow, PostgreSQL, DBT, AWS S3, and Docker**.  

This project leverages the [MovieLens dataset](https://grouplens.org/datasets/movielens/) and walks through the entire process of **data ingestion → storage → transformation → testing → analytics-ready tables**.

---

## 📑 Table of Contents
- [Project Overview](#-project-overview)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Tech Stack](#️-tech-stack)
- [Setup Instructions](#️-setup-instructions)
- [Data Modeling with DBT](#-data-modeling-with-dbt)
- [Example Outputs](#-example-outputs)
- [Key Learnings](#-key-learnings)
- [Future Enhancements](#-future-enhancements)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🚀 Project Overview  

- **Dataset Source:** [MovieLens](https://grouplens.org/datasets/movielens/)  
- **Data Lake:** AWS S3 (raw CSV files)  
- **Orchestration:** Apache Airflow (Dockerized)  
- **Data Warehouse:** PostgreSQL (Dockerized)  
- **Transformation:** DBT (with snapshots, tests, fact & dimension models)  
- **Visualization / Monitoring:** pgAdmin (Dockerized)  

The pipeline demonstrates **real-world data engineering practices** such as:  
- Running services with **Docker Compose**  
- **Ingesting raw data** from S3 into PostgreSQL using Airflow  
- **Data modeling with DBT** (dimension, fact, and mart layers)  
- Implementing **tests & macros** for data quality  
- **Slowly Changing Dimension (SCD) Type 2** handling with DBT snapshots  

## 🏗️ Architecture  

```text
           +-------------+
           |  MovieLens  |
           |   Dataset   |
           +------+------+   
                  | (CSV upload)
                  v
             +----+----+
             |   AWS   |
             |   S3    |
             +----+----+
                  |
        Ingestion with Airflow
                  |
                  v
        +---------+---------+
        |   PostgreSQL DB   |
        |   (Dockerized)    |
        +---------+---------+
                  |
        Transformation with DBT
                  |
       +----------+----------+
       |  Analytics Schemas  |
       |   (dev: staging,    |
       |   dim, fct, mart)   |
       +----------+----------+

## 📂 Project Structure

```text
.
├── Netflix_Data_Pipeline/      # Airflow DAGs for ingestion
├── dbt_project/
│   ├── models/
│   │   ├── dim/                # Dimension tables
│   │   ├── fct/                # Fact tables
│   │   ├── mart/               # Aggregated marts
│   │   └── staging/            # Staging models
│   ├── macros/                 # Custom macros for tests
│   ├── seeds/                  # CSV-based seed data
│   ├── snapshots/              # SCD Type 2 tracking
│   └── tests/                  # Data quality tests
├── docker-compose.yml          # Orchestration of all services
└── README.md                   # Project documentation


🛠️ Tech Stack

Apache Airflow → Orchestration (ETL from S3 → PostgreSQL)

PostgreSQL → Data warehouse (schemas: public, dev)

pgAdmin → GUI for exploring database tables

DBT → Transformation layer (staging, dim, fct, mart, tests, snapshots)

Docker Compose → Containerized environment for all services

AWS S3 → Raw data storage

Setup Instructions
1️⃣ Clone the repository
git clone https://github.com/Anirudh-004/dbt-netflix-pipeline.git
cd Netflix_Data_Eng_Pipeline

2️⃣ Spin up services with Docker Compose
docker-compose up -d

This will start:

Airflow webserver & scheduler

PostgreSQL database

pgAdmin

DBT environment

3️⃣ Access the services
- Airflow UI: http://localhost:8080
- pgAdmin: http://localhost:8888/
- Postgres DB: localhost:5432

4️⃣ Run the pipeline

Upload MovieLens CSV files to your AWS S3 bucket

Trigger the Airflow DAG → Data will be ingested into PostgreSQL (public schema)

Run DBT transformations to create staging, dimension, fact, and mart models in the dev schema

🧩 Data Modeling with DBT

Staging layer → Light transformations of raw S3 data (in dev.staging)

Dimension layer (dim/) → Descriptive attributes of entities (movies, tags, users, etc.)

Fact layer (fct/) → Transactional/quantitative events (ratings, genome scores, etc.)

Mart layer (mart/) → Aggregated tables for analytics (joins + seed-based enrichments)

Snapshots → Implements SCD Type 2 for tracking historical changes

Tests → Custom DBT macros ensure data quality (e.g., uniqueness, not null)

📸 Example Outputs

✅ Airflow DAG graph for ingestion

✅ pgAdmin view of Postgres tables

✅ DBT lineage graph for transformations

🌟 Key Learnings

How to orchestrate a modern data pipeline with Airflow + DBT

Using Docker Compose to spin up an entire data engineering stack

Best practices in data modeling (staging → dim/fct → mart)

Implementing data quality tests and SCD Type 2 snapshots in DBT

📌 Future Enhancements

Add CI/CD with GitHub Actions for DBT testing

Deploy DBT docs for auto-generated documentation

Integrate a BI tool (e.g., Metabase / Superset) for visualization




