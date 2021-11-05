library(ggplot2)
library(dplyr)
library(car)
library(lubridate)

## Setup dataset for Shiny App
source("setup.R", local=TRUE)

library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict HomePrices from Features"),
  sidebarLayout(
    sidebarPanel(
      p("You can make feature(s) selection from each slider, each feature
		 is added to 'Living Area'. Default selections are in place, please
		 change to suit your needs. Check the model prediction(s) you are 
		 interested in to view only those plot"),
      br(),

      sliderInput("slidersqft", "Select Living Area of House?", 
		min=min(living), max=max(living), value = living[200], step=50),
      sliderInput("sliderbed", "Select Number of BedRooms?", 
		min=min(beds), max=max(beds), value = 3, step=0.5),
      sliderInput("sliderbath", "Select Number of Bathrooms?", 
		min=min(baths), max=max(baths), value = 2, step=0.5),

 	  radioButtons("showModel", "Plot Linear Model for:",
			c("Sqft-Only" = "sqft",
			  "Sqft+Bed" = "sqft_bed",
			  "Sqft+Bed+Bath" = "sqft_bed_bath")),
      submitButton("Submit")
    ),
    mainPanel(
      plotOutput("plot1"),
      tableOutput('table')
    )
  )

))
