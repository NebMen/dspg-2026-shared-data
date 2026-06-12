# =========================================================================
# QUICK START: 
# 1. Check the Shared Data Dashboard (Google Sheet) for the filename.
# 2. Update the filename in STEP 2 of this script.
# 3. Run the script!
# =========================================================================
# DSPG 2026 Database Template: Querying Shared Data
# Packages required: install.packages(c("duckdb", "dplyr"))
library(duckdb)
library(dplyr)

# =========================================================================
# STEP 1: CONNECT TO THE SERVERLESS DATABASE ENGINE
# =========================================================================
# Connect to a fast, temporary in-memory database instance
con <- dbConnect(duckdb())

# =========================================================================
# STEP 2: CREATE A VIRTUAL VIEW POINTING TO THE PARQUET TARGET
# =========================================================================
# (Look at the Data Availability Dashboard to find the exact parquet file path you need)
dbExecute(con, "CREATE VIEW cohort_view AS SELECT * FROM 'data/analytics/your_domain_filename.parquet'")

# Tie DuckDB directly to your standard dplyr piping syntax
shared_db_table <- tbl(con, "cohort_view")

# =========================================================================
# STEP 3: EXTRACT EXACTLY WHAT YOU NEED
# =========================================================================
# Example A: Pulling a tiny specific slice for just one county (e.g., Montgomery County)
montgomery_slice <- shared_db_table %>%
  filter(FIPS == "51121") %>%
  collect() # The collect() function pulls ONLY these filtered rows into memory

# Example B: Pulling specific columns for the ENTIRE state (No FIPS filtering)
# (Look at the Data Availability Dashboard to find the exact column names you want)
statewide_poverty_timeline <- shared_db_table %>%
  select(FIPS, year, youth_poverty_pct) %>%
  collect()

# =========================================================================
# STEP 4: DISCONNECT TO CLEAN UP YOUR RAM
# =========================================================================
print(montgomery_slice)
dbDisconnect(con, shutdown = TRUE)
