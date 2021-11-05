library(shiny)
library(ggplot2)
library(dplyr)
library(car)
library(lubridate)

## Setup dataset for Shiny App
source("setup.R", local=TRUE)

ui <- fluidPage(
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
)

server <- function(input, output) {
  model1 <- lm(price ~ sqft_living, data = house)
  model2 <- lm(price ~ sqft_living + bedrooms, data = house)
  model3 <- lm(price ~ sqft_living + bedrooms + bathrooms, data = house)
  
  ## Prediction for price ~ sqft_living
  model1pred <- reactive({
    predict(model1, newdata = data.frame(sqft_living = input$slidersqft))
  })
  
  ## Prediction for price ~ sqft_living + bedrooms
  model2pred <- reactive({
    predict(model2, newdata = data.frame(sqft_living = input$slidersqft, bedrooms=input$sliderbed))
  })
  
  ## Prediction for price ~ sqft_living + bedrooms + bathrooms
  model3pred <- reactive({
    predict(model3, newdata = data.frame(sqft_living = input$slidersqft, bedrooms=input$sliderbed,
	bathrooms=input$sliderbath))
  })

  output$table <- renderTable({
    datf <- data.frame(c("Features", "SqFt-Living", "Beds","Beds"),
      c("Predict On", input$slidersqft, input$sliderbed, input$sliderbath),
      c("Home Price Prediction",round(model1pred(),0), round(model2pred(),0), round(model3pred(),0))
    )
  }, colnames=FALSE)

  output$plot1 <- renderPlot({

	### Plot Model1
    if(input$showModel == "sqft"){
       par(mfrow=c(2,2))
       plot(model1)
       par(mfrow=c(1,1))
    }
    
	### Plot Model2
    if(input$showModel == "sqft_bed"){
       par(mfrow=c(2,2))
       plot(model2)
       par(mfrow=c(1,1))
    }

	### Plot Model3
    if(input$showModel == "sqft_bed_bath"){
       par(mfrow=c(2,2))
       plot(model3)
    }

  })

}

## Run the Housing Application
shinyApp(ui = ui, server=server)
