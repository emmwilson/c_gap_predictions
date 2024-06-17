# c_gap_predictions
Reproducible code for analyses creating predictions of carbon stocks and gap locations in Terra Nova and Gros Morne National Parks on the island of Newfoundland, CA

The analysis creates models analogous to species distribution models, but with the abundance of carbon, or presence absence of gaps, as the response variables. 

Required data:
- c_m2_site.xlsx: average total carbon per meter squared at each plot, also delineates whether plot was mature forest or gap.
- env_sites_final.xlsx: value of environmental predictor variable at location of each plot
- GM(TN)_env_raster.tif: raster stack of environmental predictor variables across each study area.
- GM(TN)_predict_binary.tif: space in each study area where we have inference

Created data: folder where all files created by code are put

1) Environmental correlation:
  Assesses colinearity between predictor variables using pairwise complete observations.
  Requires: env_sites_final.xlsx
  
2) prep carbon data:
  Joins carbon data at each plot with environmental predictor data at that location. Then scales the predictor variables.
  Requires: c_m2_site.xlsx, env_sites_final.xlsx
  Creates: c_env_sites_scale_GM(TN).xlsx

3) prep gap data:
  Makes any plot that was in a gap a 0, and any plot in a mature stand a 1.
  Requires: c_env_sites_scale_GM(TN).xlsx
  Creates: c_env_sites_scale_GM(TN)_gap.xlsx
  
4) glm functions:
  glm functions that specify distribution, link, and method. With specifiable dataframe, list of predictor variables, and response variable. Most useful for running univariate models.

5) c glm:
  Runs and helps compare models of carbon in relation to:
    - no predictor variables (null model)
    - all predictor variables together (full model)
    - one predictor variable at a time (univariate models)
    - smaller combinations of predictor variables (reduced models)
    Requires: c_env_sites_scale_GM(TN).xlsx
    
6) gap glm:
  Runs and helps compare models of mature forest/gap in relation to:
    - no predictor variables (null model)
    - all predictor variables together (full model)
    - one predictor variable at a time (univariate models)
    - smaller combinations of predictor variables (reduced models)
    Requires: c_env_sites_scale_GM(TN)_gap.xlsx
    
7) cross validation functions:
  Functions that rerun cross validations on  randomly rearranged response variables 100 times.
  
8) c cross validation:
  Cross validates top set of carbon models. Calculates the number of times a model validates out of 100.
  Requires: c_env_sites_scale_GM(TN).xlsx
  
9) gap cross validation:
  Cross validates top set of mature forest/gap models. Calculates the number of times a model validates out of 100.
  Requires: c_env_sites_scale_GM(TN)_gap.xlsx
  
10) predictable space:
  Creates a raster stack of each environmental predictor variable for each study area, cutting out any waterbodies, un-treed areas (i.e., long range ecoregion in GM, and wetlands; identified by park staff), roads, and areas developed by humans (as identified by park staff) because we had no inference for these areas.
  Requires: GM(TN)_env_raster.tif, GM(TN)_predict_binary.tif, c_m2_site.xlsx, env_sites_final.xlsx
  Creates: GM(TN)_env_raster_masked_scaled.tif
  
11) c predictions:
  Projects top carbon model across the predictable space of each study area. Creates predictions for carbon stored across each study area at 30 m resolution.
  Requires: c_env_sites_scale_GM(TN).xlsx, GM(TN)_env_raster_masked_scaled.tif
  Creates: GM(TN)_predict_tot.tif
  
12) gap predictions:
  Projects top mature forest/gap model across the predictable space of each study area. Creates predictions for probability an area is considered mature forest or gap across each study area at 30 m resolution.
  Requires: c_env_sites_scale_GM(TN)_gap.xlsx, GM(TN)_env_raster_masked_scaled.tif
  Creates: GM(TN)_predict_gap.tif
  
Next steps: Propagating uncertainty:
  Currently in progress. Calculating uncertainty in predictions arising from uncertainty in parameter estimates and residual error of the models. Unfortunately, we do not have measures of error for the environmental predictor variables. 