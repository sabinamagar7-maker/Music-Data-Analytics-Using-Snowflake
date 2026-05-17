#  Snowflake ELT Pipeline — From Normalized Data to Star Schema

##  Project Overview

This project demonstrates a complete ELT workflow implemented in Snowflake, focusing on transforming an already normalized relational dataset into a star schema optimized for analytical querying and reporting.

The project showcases modern data warehousing concepts such as:
- Snowflake staging and loading
- ELT architecture
- Dimensional modeling
- Star schema transformation
- Fact and dimension table design
- Analytical SQL querying

The primary objective was to reshape normalized relational tables into an analytics-friendly warehouse model that improves query simplicity and reporting performance.

---

#  Architecture

This project follows a simplified ELT architecture.

The source data was already provided in a normalized relational structure. The workflow therefore focuses on loading normalized datasets into Snowflake and transforming them into a star schema optimized for analytics.

```text
Normalized Source Data
        ↓
Snowflake Stage / File Format
        ↓
Normalized Tables in Snowflake
        ↓
Star Schema Transformation
        ↓
Fact & Dimension Tables
        ↓
Analytical SQL Queries
```

---

#  Extraction

The extraction layer prepares normalized source datasets for loading into Snowflake.

Main tasks:
- Create Snowflake stages
- Define file formats
- Validate source file structure
- Prepare CSV/JSON datasets for ingestion

### Features

- Uses Snowflake staging architecture
- Supports structured source files
- Validates schema consistency before loading

---

#  Loading

The loading phase ingests normalized relational datasets into Snowflake tables.

Main tasks:
- Load staged data into Snowflake tables
- Apply type casting
- Perform basic integrity checks
- Validate schema consistency

This layer establishes the relational foundation used for dimensional transformation.

---

#  Transformation

The transformation layer converts normalized relational tables into a star schema optimized for analytical workloads.

## Transformation Goals

- Simplify analytical querying
- Improve reporting performance
- Reduce join complexity
- Create BI-friendly structures
- Support scalable dimensional analysis

---

#  Star Schema Design

The project includes:

## Fact Table

### `fact_music`

Stores track-level analytical records.

Examples:
- track duration
- popularity metrics
- playback-related measures

---

## Dimension Tables

Dimension tables provide descriptive analytical context.

Examples:
- dim_artist
- dim_album
- dim_genre
- dim_playlist

---

## Bridge Table

A bridge table was introduced to manage many-to-many relationships between:
- playlists
- tracks

This structure preserves relational flexibility while supporting dimensional analysis.

---

#  Analysis

Analytical SQL queries were executed against the star schema to generate insights and support business-oriented analysis.

The star schema enables:
- efficient aggregations
- filtering
- dimensional analysis
- reporting-ready querying

---

#  Analytical Use Cases

Examples of analysis supported by the warehouse:

- Track duration analysis
- Genre distribution analysis
- Artist comparisons
- Album comparisons
- Playlist composition analysis
- Music catalog exploration
- Aggregated reporting

---

# 🛠️ Tools & Technologies

| Category | Tools / Technologies |
|---|---|
| Data Warehouse | Snowflake |
| Querying & Transformation | SQL |
| Modeling Approach | Dimensional Modeling |
| Architecture | ELT |
| Data Validation | Integrity & Consistency Checks |

---

#  Repository Structure

```text
snowflake-music-etl/
│
├── 01_create_stage
├── 02_build_star_schema
├── 03_analysis_queries
└── README.md
```

---

#  Data Quality & Validation

Basic validation steps include:
- schema consistency checks
- null handling
- integrity validation
- type consistency checks

These validations help ensure reliable transformations and trustworthy analytical outputs.

---

#  How to Run

## 1. Create Snowflake Environment

Create:
- Snowflake database
- warehouse
- schemas

---

## 2. Execute SQL Scripts

Run SQL scripts in numerical order:

```text
01_create_stage.sql
02_build_star_schema.sql
03_analysis_queries.sql

```

---

## 3. Validate Star Schema Relationships

Review:
- fact-to-dimension relationships
- bridge table relationships
- dimensional modeling structure

---

## 4. Execute Analytical Queries

Run analytical SQL queries to generate insights and validate warehouse functionality.

---

# Key Concepts Demonstrated

This project demonstrates understanding of:

- Snowflake ELT workflows
- Snowflake staging and loading
- Dimensional modeling
- Star schema design
- Fact and dimension modeling
- Bridge table implementation
- Analytical query optimization
- Relational-to-dimensional transformation

---

#  Future Improvements

Potential future enhancements include:

- dbt integration
- CI/CD implementation
- Incremental loading strategies
- Automated testing
- Dashboard integration
- Advanced data quality checks
- Query performance optimization

---

#  Author

Sabina Thapa Magar

- Snowflake
- SQL
- Data Warehousing
- ELT
- Dimensional Modeling
- Analytics Engineering Concepts
