#Snowflake ETL Pipeline — From Raw Data to Star Schema
This project demonstrates a complete ETL/ELT workflow in Snowflake, including data extraction, loading, transformation, and analytical querying.


#Project Overview
This project demonstrates a complete ETL and dimensional modeling workflow in Snowflake for analyzing musical tracks and their descriptive attributes.
The goal is to transform a normalized 3NF schema into a star schema optimized for analytical performance and clarity.

#Extraction
Creates a Snowflake stage to extract raw data files (CSV/JSON) from local or cloud storage.
Defines file formats and validates data structure before loading.

#Loading
Loads staged data into raw tables
Performs basic data validation, type casting, and integrity checks.
Establishes the foundation for the normalized 3NF schema.

#Transformation
Transforms normalized 3NF tables into a star schema optimized for analytical queries.
Applies dimensional modeling principles:
Creates fact_music table (one row per track).
Builds dimension tables for descriptive attributes.
Introduces a bridge table to handle many‑to‑many relationships between playlists and tracks.

#Analysis
Executes analytical SQL queries on the star schema.
Enables aggregation, filtering, and visualization of musical data (e.g., track duration, genre distribution, artist comparisons).


#Tools & Technologies
Snowflake — cloud data warehouse
SQL — ETL scripting and analytical queries
Dimensional Modeling — star schema design
Data Quality Validation — integrity and consistency checks

#Analytical Use Cases
Track‑level performance metrics
Genre‑based aggregation
Artist and album comparisons
Playlist composition analysis

#How to Run
Create a Snowflake database and warehouse.
Execute SQL scripts in numerical order.
Verify schema relationships using the star schema diagram.
Run analysis queries to generate insights.
