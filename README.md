## Predicting home prices in King County Washington State
### Description
This presentation is related to predicting home prices in King County Washington State. Since the final assignment is related to Developing Data Products CourseRA course, to keep it simple, prediction is based only on:  
1. Sqft Living   
2. Number of Bedrooms  
3. Number of Bathrooms  
This reproducible pitch and Shiny App are presented to showcase the prediction model

[**Access Shiny App Here**](https://jyanamandala.shinyapps.io/Price_Prediction/)  
[**Location of GitHub repo**](https://github.com/jayc279/Predicting_Home_Prices_King_County_Washington.git)  
  
### King County Home Prices Dataset
The dataset was provided for one of the assignments in "Machine Learning Specialization" offered by Univ of Washington, and taught by:
-- Emily Fox, Amazon Professor of Machine Learning
-- Carlos Guestrin, Amazon Professor of Machine Learning

### Dataset Exploration and Setup for Analysis
Before defining Shiny ui.R inputs, we clean the dataset for simple presentation
* Remove columns that are not needed for the current analysis
* Convert integer to numeric
* Update columns that have value '0' with mean of previous five values
* Sort data for sliders in ui.R

### Define ui.R
In our ui.R file we define the following inputs
* `slidersqft` - Sqft of living space
* `sliderbed` - Number of Bed rooms
* `sliderbath` - Number of Bath rooms
* `showModel` - Radio button to select which 'lm' model to plot

### Define server.R
In our server.R we capture the input from ui.R and
* Plot a model - default plot is sqft_living + bedrooms + bathrooms
* Print a table of 3 models
    1. price -vs- sqft_living
    2. price -vs- sqft_living + bedrooms
    2. price -vs- sqft_living + bedrooms + bathrooms

### Build LM model
* House Price -vs- Sqft-Living, Number of Bedrooms, and Number of Bathrooms
* Predict Price
