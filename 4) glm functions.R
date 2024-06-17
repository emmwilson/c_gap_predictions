# functions for running glms 

# for carbon: generalized linear model with gamma distribution and log link
lm_glm <- function(df, c, variables) {
  lm_glm <- glm(formula(paste0(quo_name(c)," ~ ", paste0(variables, collapse="+"))), data = df, family = Gamma(link = "log"))
  eval <- eval(lm_glm$call$formula)
  formula1<- eval(eval)
  lm_glm$call$formula <- formula1
  lm_glm
}

# for gaps: generalized linear model with binomial distribution and logit link, fit using firth's bias reduction because of quasi-complete seperation
firths_glm <- function(df, c, variables) {
  lm_glm <- glm(formula(paste0(quo_name(c)," ~ ", paste0(variables, collapse="+"))), data = df, family = binomial(link = "logit"), method = "brglmFit")
  eval <- eval(lm_glm$call$formula)
  formula1<- eval(eval)
  lm_glm$call$formula <- formula1
  lm_glm
}