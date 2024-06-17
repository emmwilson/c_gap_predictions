# c_gap_predictions
Reproducible code for analyses creating predictions of carbon and gap locations in Terra Nova and Gros Morne National Parks in Newfoundland

The analysis creates models analogous to species distribution models, but with the abundance of carbon, or presence absence of gaps, as the response variables. 

1) Environmental correlation:
  Assesses colinearity between predictor variables using pairwise complete observations.
  
2) prep carbon data:
  Joins carbon data at each plot with environmental predictor data at that location. Then scales the predictor variables.

3) prep gap data:
  Makes any plot that was in a gap a 0, and any plot in a mature stand a 1.
  
4) glm functions:
  glm functions that specify distribution, link, and method. With specifiable dataframe, list of predictor variables, and response variable. Most useful for running univariate models.

5) c glm:
  Runs and helps compare models of carbon in relation to:
    - no predictor variables (null model)
    - all predictor variables together (full model)
    - one predictor variable at a time (univariate models)
    - smaller combinations of predictor variables (reduced models)
    
6) gap glm:
  Runs and helps compare models of mature forest/gap in relation to:
    - no predictor variables (null model)
    - all predictor variables together (full model)
    - one predictor variable at a time (univariate models)
    - smaller combinations of predictor variables (reduced models)
    
7) cross validation functions:
  Functions that rerun cross validations on  randomly rearranged response variables 100 times.
  
8) c cross validation:
  Cross validates top set of carbon models. Calculates the number of times a model validates out of 100.
  
9) gap cross validation:
  Cross validates top set of mature forest/gap models. Calculates the number of times a model validates out of 100.
  
10) predictable space:
  Creates a raster stack of each environmental predictor variable for each study area, cutting out any waterbodies, un-treed areas (i.e., long range ecoregion in GM, and wetlands; identified by park staff), roads, and areas developed by humans (as identified by park staff) because we had no inference for these areas.
  
11) c predictions:
  Projects top carbon model across the predictable space of each study area. 
  
12) gap predictions:
  Projects top mature forest/gap model across the predictable space of each study area. 
  
Next steps: Propagating uncertainty:
  Currently in progress. Calculating uncertainty in predictions arising from uncertainty in parameter estimates and residual error of the models. Unfortunately, we do not have measures of error for the environmental predictor variables. 