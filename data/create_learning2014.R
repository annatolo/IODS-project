# Name: Anna Tolonen
# Date: 8.11.2023
# Description: Script to create and manage learning data for 2014

# Reading the data
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                           sep = "\t", 
                           header = TRUE)

# Exploring the data
## Displaying the structure of the dataset
str(learning2014)

## Displaying the dimensions of the dataset (number of rows and columns)
dim(learning2014)

# Creating combined variables and scaling them
## Deep Approach
learning2014$Deep <- rowMeans(learning2014[, c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")], na.rm = TRUE)

## Surface Approach
learning2014$Surf <- rowMeans(learning2014[, c("SU02", "SU10", "SU18", "SU26", "SU05", "SU13", "SU21", "SU29", "SU08", "SU16", "SU24", "SU32")], na.rm = TRUE)

## Strategic Approach
learning2014$Stra <- rowMeans(learning2014[, c("ST01", "ST09", "ST17", "ST25", "ST04", "ST12", "ST20", "ST28")], na.rm = TRUE)

# Reverse scoring for Df and Dh
learning2014$Df_rev <- 6 - learning2014$Df
learning2014$Dh_rev <- 6 - learning2014$Dh

# Creating the Attitude variable
learning2014$Attitude <- rowMeans(learning2014[, c("Da", "Db", "Dc", "Dd", "De", "Df_rev", "Dg", "Dh_rev", "Di", "Dj")], na.rm = TRUE)

# Excluding observations where exam points are zero
analysis_dataset <- subset(learning2014, Points != 0)

# Selecting only required variables
analysis_dataset <- analysis_dataset[, c("gender", "Age", "Attitude", "Deep", "Stra", "Surf", "Points")]

# Checking the final dimensions to ensure it has 166 observations and 7 variables
print(dim(analysis_dataset))

# Saving the dataset as a CSV file
readr::write_csv(analysis_dataset, "data/learning2014.csv")

# Reading the dataset back into R
learning2014_reloaded <- readr::read_csv("data/learning2014.csv")

# Checking the structure and the first few rows of the dataset
str(learning2014_reloaded)
head(learning2014_reloaded)
