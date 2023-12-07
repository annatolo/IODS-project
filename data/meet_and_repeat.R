# Name: Anna Tolonen
# Date: 7.12.2023
# Description: Script for data wrangling on the BPRS and RATS datasets.
# Data source: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt and https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt

# Installing and load necessary packages
install.packages("tidyverse")
library(tidyverse)
install.packages("tidyr")
library(tidyr)

# Loading BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE)

# Loading RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE)

# Viewing the data
head(BPRS)
head(RATS)

# Summary of the wide form data
summary(BPRS)

# For Wide Form RATS Data Summary
# - Similar to BPRS, each row in wide form represents a single subject, with measurements at different days as separate columns.
summary(RATS)

#Converting the categorical variables in both datasets to factor types
# For BPRS
BPRS$treatment <- as.factor(BPRS$treatment)
BPRS$subject <- as.factor(BPRS$subject)

# For RATS
RATS$ID <- as.factor(RATS$ID)
RATS$Group <- as.factor(RATS$Group)

# Converting BPRS to long form and add 'week' variable
BPRS_long <- pivot_longer(BPRS, cols = -c(treatment, subject), names_to = "week", values_to = "value")

# Converting RATS to long form and add 'Time' variable
RATS_long <- pivot_longer(RATS, cols = -c(ID, Group), names_to = "Time", values_to = "value")

# Viewing the long form data
head(BPRS_long)
head(RATS_long)

# Summarizing the long form data
summary(BPRS_long)
summary(RATS_long)

# Comparing Wide and Long Form Data

# Wide Form BPRS Data Summary (again for comparison reasons)
# - Each row represents a single subject with multiple time points (week0 to week8) as separate columns.
# - This format is good for visualizing all measurements for a single subject at once.
summary(BPRS)

# Long Form BPRS Data Summary
# - Data is restructured: each row now represents one time point for a subject.
# - Columns 'week' and 'value' indicate the specific week and the measurement, respectively.
# - Useful for analyses where each time point needs to be treated as a distinct observation.
summary(BPRS_long)

# Repeating the same comparison for RATS dataset
# Wide Form RATS Data Summary
# - Similar to BPRS, each row in wide form represents a single subject, with measurements at different days as separate columns.
summary(RATS)

# Long Form RATS Data Summary
# - Transformed like BPRS: each row corresponds to a single measurement at a given time (denoted by 'Time') for a subject.
# - Facilitates analyses that focus on changes over time or repeated measures.
summary(RATS_long)

# Saving BPRS data in wide form to the 'data' folder as CSV
write.csv(BPRS, "data/BPRS_wide.csv", row.names = FALSE)

# Saving BPRS data in long form to the 'data' folder as CSV
write.csv(BPRS_long, "data/BPRS_long.csv", row.names = FALSE)

# Saving RATS data in wide form to the 'data' folder as CSV
write.csv(RATS, "data/RATS_wide.csv", row.names = FALSE)

# Saving RATS data in long form to the 'data' folder as CSV
write.csv(RATS_long, "data/RATS_long.csv", row.names = FALSE)
