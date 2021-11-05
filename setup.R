## Load Libraries
library(ggplot2)
library(dplyr)
library(car)
library(lubridate)

## Setup dataset and cleanup for model predictions
house <- read.csv2(file="data/home_data.csv", sep=",", na.strings = c ("","NA"))

## Remove unwanted columns from data frame
remove_cols <- c("waterfront", "view", "lat", "long", "mpgsp", "yr_renovated", "condition", "sqft_basement","sqft_living15","sqft_lot15")
house <- subset(house, select= !(names(house) %in% remove_cols))

## Convert integer to numeric
house <- house %>% mutate_if(is.integer, as.numeric)
house$floors <- as.numeric(house$floors)
house$bathrooms <- as.numeric(house$bathrooms)

## Convert date to as.Date
house <- house %>% mutate(date = ymd_hms(date))
house$date <- as.Date(house$date)

## Check class of 'house' features
## str(house)

## View house in Table format - Interactive
## View(house)


## Update columns other than "id", "date", "price" to values that are non-zero
## Get sum of previous five and divide by 5 to get a value and update dataset for the column
## COlumns affected are 'bathrooms' and 'bedrooms'
for(i in 1:ncol(house)) {
	cnt <- nrow(house[house[i] == 0,])
	if ( !grepl('id|date|price', names(house[i])) ) {
		## print(names(house[i]))
		if ( cnt ) {
			x <- which(house[i] == 0, arr.ind=TRUE)	
			x <- as.data.frame(x)
			for(ni in 1:nrow(x)) {
				rowVal <- x$row[ni]
				newVal <- round(sum(house[(rowVal-5):(rowVal-1),4]/5),0)
			    house[ rowVal, i] <- newVal
				## print(names(house[i]))
			}
		}
	}
}

## Check to see # of bathrooms and batromms are '0'
length(house[,house$bedrooms == 0])
length(house[,house$bathrooms == 0])

## Sort for Shiny
living <- sort(unique(house$sqft_living), decreasing = FALSE)
zipc <- sort(unique(house$zipcode), decreasing = FALSE)
beds <- sort(unique(house$bedrooms), decreasing = FALSE)
baths <- sort(unique(house$bathrooms), decreasing = FALSE)
yr_blt <- sort(unique(house$yr_built), decreasing = TRUE)

