# Name: Anna Tolonen
# Date: 15.11.2023
# Description: Script for data wrangling of student performance data including alcohol consumption
# Data source: UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption)

#Reading the data
student_mat <- read.csv("data/student-mat.csv", sep = ";")
student_por <- read.csv("data/student-por.csv", sep = ";")

# Exploring the data
## Displaying the structure of the dataset
str(student_mat)
str(student_por)

## Displaying the dimensions of the dataset (number of rows and columns)
dim(student_mat)
dim(student_por)

## Looking at the first few rows of the datasets to understand their layout better
head(student_mat)
head(student_por)

## Summarizing the data
summary(student_mat)
summary(student_por)

# Defining the columns to join on (excluding the ones mentioned in the assignment)
join_columns <- setdiff(names(student_mat), c("failures", "paid", "absences", "G1", "G2", "G3"))

# Joining the datasets
joined_data <- merge(student_mat, student_por, by = join_columns, all = FALSE)

# 'Joined_data' is now the merged dataset and includes both .x and .y columns for the variables not included in the joining. Now I'll get rid of these duplicate records.

# Identifying the columns not used for joining. As stated above, these will have .x and .y suffixes
non_join_columns <- c("failures", "paid", "absences", "G1", "G2", "G3")

# Looping over the columns not used for joining and combining them
for(col_name in non_join_columns) {
  # Selecting two columns from 'joined_data' with the same original name
  two_cols <- joined_data[, c(paste0(col_name, ".x"), paste0(col_name, ".y"))]
  
  # Checking if the first column vector is numeric
  if(is.numeric(two_cols[[1]])) {
    # If so, taking a rounded average of each row of the two columns and adding it to 'joined_data'
    joined_data[col_name] <- round(rowMeans(two_cols, na.rm = TRUE))
  } else {
    # If the column is non-numeric, such as 'paid.x' and 'paid.y', I will create a combined 'paid' column
    # A student is considered to have paid if they have paid for either Math or Portuguese
    combined_paid <- ifelse(two_cols[[1]] == "yes" | two_cols[[2]] == "yes", "yes", "no")
    joined_data[col_name] <- combined_paid
  }
}

# Now the original .x and .y columns have been combined and the original ones can be removed
joined_data <- joined_data[, !grepl("\\.x|\\.y", names(joined_data))]

# Glimpse at the new combined data
str(joined_data)
dim(joined_data)

# Calculating 'alc_use' by taking the average of 'Dalc' and 'Walc' columns
joined_data$alc_use <- rowMeans(joined_data[, c("Dalc", "Walc")], na.rm = TRUE)

# Creating 'high_use' column based on 'alc_use'
# This will be TRUE if 'alc_use' is greater than 2, and FALSE otherwise
joined_data$high_use <- joined_data$alc_use > 2

# Loading the required package
library(tidyverse)

# Taking a glimpse at the data to make sure everything looks correct
glimpse(joined_data)

# Saving the data to the 'data' folder as 'joined_data.csv'
write_csv(joined_data, "data/joined_and_modified_data.csv")




