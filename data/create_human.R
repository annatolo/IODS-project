# Name: Anna Tolonen
# Date: 20.11.2023
# Description: Script for data wrangling on the Human Development and Gender Inequality datasets. It includes reading and cleaning the data, renaming variables for clarity, creating new variables, and merging the datasets based on the 'Country' identifier.
# Data source: Human Development dataset (https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv) and Gender Inequality dataset (https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv)

# Loading required library
library(readr)
library(dplyr)

# Reading the human development dataset
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")

# Reading the gender inequality dataset
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Checking for parsing problems in the gender inequality dataset
problems(gii)

# Addressing the parsing problems...
# Reading the Gender Inequality dataset with ".." as NA indicators
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Removing rows where the first column (which should be a double) is NA
# Assuming the first column is 'GII Rank' and it should not have NA values
gii <- gii %>% filter(!is.na(`GII Rank`))

# Rechecking the problems after cleaning
problems(gii)

# Inspecting the first few rows of the cleaned dataset
head(gii)

# Exploring the datasets
str(hd)
str(gii)
summary(hd)
summary(gii)

# Checking current column names for the 'hd' dataset
print(names(hd))

# Check current column names for the 'gii' dataset
print(names(gii))

# Renaming variables to be more descriptive as per the meta file
hd <- hd %>%
  rename(
    Country = Country,
    GNI_per_Capita = `Gross National Income (GNI) per Capita`,
    Life_Expectancy = `Life Expectancy at Birth`,
    Expected_Years_of_Education = `Expected Years of Education`,
    Mean_Years_of_Education = `Mean Years of Education`
    # As far as I understand it, HDI Rank and GNI per Capita Rank Minus HDI Rank do not have corresponding names in the meta file provided aso I'm keeping them as is.
  )

gii <- gii %>%
  rename(
    Country = Country,
    Gender_Inequality_Index = `Gender Inequality Index (GII)`,
    Maternal_Mortality_Ratio = `Maternal Mortality Ratio`,
    Adolescent_Birth_Rate = `Adolescent Birth Rate`,
    Female_Representation_in_Parliament = `Percent Representation in Parliament`,
    Female_Secondary_Education = `Population with Secondary Education (Female)`,
    Male_Secondary_Education = `Population with Secondary Education (Male)`,
    Female_Labor_Force_Participation = `Labour Force Participation Rate (Female)`,
    Male_Labor_Force_Participation = `Labour Force Participation Rate (Male)`
    # With regard to the GII Rank, same situation as with the hd data set.
  )

# Printing out the updated names to confirm the changes
print(names(hd))
print(names(gii))

# Mutating the gender inequality dataset
gii <- gii %>%
  mutate(
    EducationRatio = Female_Secondary_Education / Male_Secondary_Education, 
    LaborForceRatio = Female_Labor_Force_Participation / Male_Labor_Force_Participation
  )

# Joining the datasets
human <- inner_join(hd, gii, by = "Country")

# Ensure the final dataset has 195 observations and 19 variables
print(dim(human))

# Save the joined dataset
write_csv(human, "data/human.csv")

