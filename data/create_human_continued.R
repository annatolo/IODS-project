# Name: Anna Tolonen
# Date: 3.12.2023
# Description: Script for further data wrangling on the 'human' dataset.
# Data source for the original script: Human Development dataset (https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv) and Gender Inequality dataset (https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv)

# Loading required libraries
library(readr)
library(dplyr)

# Loading the 'human' dataset
human <- read_csv("/Users/annatolonen/Desktop/IODS-project/data/human.csv")

# Exploring the dataset
str(human)
summary(human)
dim(human)
# The 'human' dataset is a structured table containing 188 rows and 19 columns. 
# Each row appears to represent a country, given the presence of a 'Country' character column. 
# The dataset encompasses a range of variables related to human development and gender inequality. 
# Key variables include the Human Development Index (HDI), life expectancy, education metrics (expected and mean years), Gross National Income (GNI) per capita, and several indices related to gender inequality such as the Gender Inequality Index (GII), maternal mortality ratio, adolescent birth rate, and female representation in parliament. Additionally, the dataset contains calculated ratios for education and labor force participation by gender.
# Numeric columns such as 'HDI Rank', 'Life Expectancy', 'GNI_per_Capita', and others provide quantitative measures, while the 'Country' column offers categorical data. 
# Missing values are noted in several columns, such as the Gender Inequality Index and education-related metrics. Therefore, cleaning seems to be needed.

# Checking current column names
print(names(human))

#It seems that the names given in the assingment match the current names as follows:
# "Female_Secondary_Education" corresponds to "Edu2.F"
# "Female_Labor_Force_Participation" corresponds to "Labo.F"
# "Expected_Years_of_Education" corresponds to "Edu.Exp"
# "Life_Expectancy" corresponds to "Life.Exp"
# "GNI_per_Capita" corresponds to "GNI"
# "Maternal_Mortality_Ratio" corresponds to "Mat.Mor"
# "Adolescent_Birth_Rate" corresponds to "Ado.Birth"
# "Female_Representation_in_Parliament" corresponds to "Parli.F"

# Keeping only specified columns
human <- human %>%
  select(Country, Female_Secondary_Education, Female_Labor_Force_Participation, 
         Expected_Years_of_Education, Life_Expectancy, GNI_per_Capita, 
         Maternal_Mortality_Ratio, Adolescent_Birth_Rate, 
         Female_Representation_in_Parliament)

# Removing rows with missing values
human <- na.omit(human)

# It seems that at this point, there is no regional data to remove.

# Checking final structure and save
print(dim(human)) 
# Seem to be 155 observations and 9 variables, as it should!

# Overwriting the existing 'human' data
write_csv(human, "/Users/annatolonen/Desktop/IODS-project/data/human.csv")
