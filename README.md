# gettingcleaningdata
final project coursera Getting and Cleaning Data

The script run_analysis.R  is separated in two parts
the first one proccess test data reading all the variables and renaming  them etc. It finish with the dataframe testdf
The same happens with the train data obtaining the traindf data.frame.

They are then merged in the totaldf dataframe.

Then extract columns related with variables containing mean or std measurements in the data frame meanstd

Obtain the aggregate data frame using aggregate function obtaining data frame finaldata

Proccess finaldata renaming the grouping variables to be "activity" and "subject"



