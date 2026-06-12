# DSPG 2026 Database Template: Exporting Cleaned Data
# Packages required: install.packages(c("arrow"))
library(arrow)

# =========================================================================
# STEP 1: RUN YOUR GIT PULL
# =========================================================================
# Before running this script, open your terminal and run:
# git pull
# This ensures your local computer has the latest repository folders!

# =========================================================================
# STEP 2: LOAD YOUR ENTIRE CLEANED DATASET
# =========================================================================
# Replace the placeholder dataframe below with your actual, massive cleaned dataset.
# You do NOT need to filter or select specific rows—export the whole thing!

my_clean_dataframe <- read.csv("your_local_path_to_completed_dataset.csv")

# =========================================================================
# STEP 3: EXPORT TO THE LOCAL ANALYTICS FOLDER
# =========================================================================
# Change 'your_domain_filename.parquet' to match your topic (e.g., 'vdoe_special_education.parquet')
# DuckDB and Arrow will automatically shrink, compress, and optimize the entire file!

write_parquet(my_clean_dataframe, "data/analytics/your_domain_filename.parquet")

# =========================================================================
# STEP 4: PUSH TO GITHUB
# =========================================================================
# Open your terminal and run these commands to share your data with the cohort:
# git add data/analytics/your_domain_filename.parquet
# git commit -m "Added clean domain dataset for the cohort"
# git push
