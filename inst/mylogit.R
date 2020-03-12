mylogit <- glm(Transition ~ GDP + IMR + PD + FT2Y + FT5Y, data = Test_Data, family = "binomial")

# Create formula to pass to glm() so we can iterate through column names
my_formula <- "Transition ~ GDP + IMR + PD + FT2Y + FT5Y"

# Coeffiecents of the model (Note: this is the optimization I was looking to avoid doing by hand)
fmla <- coef(mylogit)

# Log Likelihood of the current model
modelLLR <- logLik(mylogit)

# Loop through columns
for(i in names(Test_Data)) {
  my_formula = as.formula(paste(colnames(Test_Data[,2]), ))
  
}

# Test for duplicate colnames
indx <- grepl("GDP", colnames(Test_Data))
if (i == colnames(Test_Data_Small)[indx]) {}


# Loop through columns
# ___TEST VALUES___ this forumla has some PLACEHOLDER values for testing still in it.
#my_formula <- paste(colnames(Test_Data_Small)[1], " ~ GDP + IMR")
my_formula <- paste(colnames(Test_Data)[1], " ~ GDP + IMR")
mylogit <- glm(my_formula, data = Test_Data, family = "binomial")
modelLLR <- logLik(mylogit)[1]
output <- matrix(ncol=2, nrow=ncol(Test_Data))
# initiate secondary (numerical) iteration for the for loop.
j <- 1
for(i in names(Test_Data)) {
  # provides a True/False of if the colname is in my dataframe.
  indx <- grepl(i, colnames(Test_Data_Small))
  # isTrue evaluates a statement and if it's not True, outputs False.  When a colname is not in the dataframe, I'm getting a logical zero, so this overcomes the if error.
  # combining indx with the dataframe colname pulls out the colname that is True.
  if (isTRUE(i == colnames(Test_Data_Small)[indx])) {
    # ___PLACEHOLDER___ setting the gStat to zero as a PLACEHOLDER until I can figure out a better response.
    gStat <- 0
    output[j,1] <- i
    output[j,2] <- gStat
    j <- j+1
  }
  else {
    var_formula = paste(my_formula, " + ", i)
    varlogit <- glm(var_formula, data = Test_Data, family = "binomial")
    varLLR <- logLik(varlogit)[1]
    gStat <- -2 * (modelLLR - varLLR)
    output[j,1] <- i
    output[j,2] <- gStat
    j <- j+1
  }
}