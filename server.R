library(shiny)
shinyServer(function(input, output) {
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
  
  output$pred1 <- renderText({ model1pred() })
  output$pred2 <- renderText({ model2pred() })
  output$pred3 <- renderText({ model3pred() })

})
