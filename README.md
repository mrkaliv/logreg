# logreg
#
# LOGREG is a shiny app program that allows the user to perform step-wise logistic regression.
#
# To run the shiny app, please use run_apps("logreg_gui")
#
# In it's current version, logreg only provides the g-statistic to inform the user which variable would add the most data to the model.
# For any statistics of the model, such as to obtain the coefficents of the model, please execute your desired variables within glm.  Example, glm(Transition ~ GDP , data = Test_Data, family = "binomial")
#
