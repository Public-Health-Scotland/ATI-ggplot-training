##########################
##Exercises for ggplot###
###########################

##Load data first
borders_data <- readRDS("data/borders.rds")

#change date strings to actual dates and create age on admission variable
borders_data <- borders_data %>%
  mutate(Dateofbirth = paste0(substr(Dateofbirth,1,4), "-",substr(Dateofbirth,5,6), "-" ,substr(Dateofbirth,7,8) ))  %>%
  mutate(DateofAdmission = paste0(substr(DateofAdmission,1,4), "-",substr(DateofAdmission,5,6), "-" ,substr(DateofAdmission,7,8) ))  %>%
  mutate(ageonadmission = time_length(difftime(as.Date(DateofAdmission, "%Y-%m-%d"),as.Date(Dateofbirth, "%Y-%m-%d") ),"years"))

borders_data <-  borders_data %>%
  mutate(spec_1 =substr(Specialty,1,1) )

##Exercise 1####
#modify the code below to change the colour of points to be “dark green” for all points
borders_data %>%
  ggplot(aes(x = ageonadmission, 
             y = LengthOfStay, 
             colour = Sex)) +
  geom_point()

#nb - the plot legend (before modifying) 
###will look better if you change "Sex" to a factor - R has loaded it in as numeric

##Exercise 2####
#starting with the code below...
#1 Add a new dimension to map Sex to colour.
#2 Apply both jitter and dodge.
#3 Add an alpha attribute and set the value to ‘0.5’.
borders_data %>%
  ggplot(aes(x = spec_1, 
             y = LengthOfStay)) +
  geom_point(position = position_jitter())

##Exercise 3####
#1.  We need more readable variable names: pick new titles for the x and y axes.
#2. It could be said that the visualisation is misleading due to the y-axis limits. Fix this by specifying the lower limit to be 0. This needs a length-2 vector (i.e. c(x, y)), remember the upper limit.
#3. Let’s also use some PHS colours rather than the defaults. Set “Female” (the first value) to be “#76B843” and “Male” (the second value) to be “#3A3776”.
#4. give the plot a title using ggtitle().
#Let’s call it “Boxplot of Age on Admission for Specialty Grouping H & J \n in Borders General Hospital”. (The “\n” is a special character that forces a new line, something that may be necessary in longer titles as ggplot doesn’t automatically wrap the text).
borders_data %>%
  filter(HospitalCode == "B120H",
         spec_1 %in% c("H", "J")) %>%
  ggplot(aes(x = spec_1, 
             y = ageonadmission,
             colour = Sex)) +
  geom_boxplot()


## Excercise 4 ####
#themes####

