#####################################
###   Introduction to ggplot2   #####
##
####################################

#load ggplot
library(ggplot2)
library(lubridate)
library(dplyr)


# load data
borders_data <- readRDS("data/borders.rds")

#change date strings to actual dates and create age on admission variable
borders_data <- borders_data %>%
  mutate(Dateofbirth = paste0(substr(Dateofbirth,1,4), "-",substr(Dateofbirth,5,6), "-" ,substr(Dateofbirth,7,8) ))  %>%
  mutate(DateofAdmission = paste0(substr(DateofAdmission,1,4), "-",substr(DateofAdmission,5,6), "-" ,substr(DateofAdmission,7,8) ))  %>%
  mutate(ageonadmission = time_length(difftime(as.Date(DateofAdmission, "%Y-%m-%d"),as.Date(Dateofbirth, "%Y-%m-%d") ),"years"))


##Example 1 plot####
borders_data %>%
  ggplot(aes(x = ageonadmission, 
             y = LengthOfStay, 
             colour = Sex)) +
  geom_point(alpha = 0.5) +
  theme_minimal() +
  ylab("Length of Stay (days)") +
  xlab("Age on Admission (years)") +
  ggtitle("Length of Stay by Age on Admission")

# different graph types
# histogram
data <- data.frame(value=rnorm(100))
p <- ggplot(data, aes(x=value)) + 
  geom_histogram()
p

##bar
g <- ggplot(mpg, aes(class))
# Number of cars in each class:
g + geom_bar()  # default "stat" is count
g + geom_bar(stat = "count")  

#if your data is already aggregated into counts
df <- data.frame(x = rep(c("A", "B", "C"),2),
                 y= c(5, 10, 4,1,2,3), 
                 z = c(rep("test1",3), rep("test2", 3)))
g <- ggplot(df, aes(x=x, y=y)) +
  geom_bar(stat = "identity")  

ggplot(df, aes(x=x, y=y, fill=z)) +
  geom_bar(stat = "identity")  

ggplot(df, aes(x=x, y=y, fill=z)) +
  geom_bar(stat = "identity", position = "dodge")  

##point
# Keep 30 first rows in the mtcars natively available dataset
data=head(mtcars, 30)

# 1/ add text with geom_text, use nudge to nudge the text
ggplot(data, aes(x=wt, y=mpg)) +
  geom_point()+ # Show dots
  geom_text(
    label=rownames(data), 
    nudge_x = 0.4, nudge_y = 0.4, 
    check_overlap = T
  )

#add colours
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) 
# NOTE that the aesthetics can go inside goem point OR inside the ggplot command
# if you have just one main ploting layr (geom_point) in this case, it makes no difference
# if you wanted to plot some points then plot a line on top, with different aesthetics, you would 
ggplot(data = mpg, aes(x = displ, y = hwy, color = class)) + 
  geom_point() # NOTE that the aesthetics can go inside goem point OR inside the ggplot command

#line


#Aesthetics####
# a third aes - colour ####
borders_data %>%
  ggplot(aes(x = ageonadmission, 
             y = LengthOfStay, 
             colour = as.character(Sex))) +
  geom_point()

##positional options
#jitter points
borders_data %>%
  ggplot(aes(x = ageonadmission, 
             y = LengthOfStay, 
             colour = Sex)) +
  geom_point(position = position_jitter())


##scale options
borders_data %>%
  ggplot(aes(x = ageonadmission, 
             y = LengthOfStay, 
             colour = Sex)) +
  geom_point(position = position_jitter()) +
  scale_x_continuous(name = "Age on Admission (Years)") 

####Mapping####
#colour all points blue regardless of value
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(colour="blue" ) 

#Geometrey####
#multiple geoms
ggplot(data = car_data, mapping = 
         aes(x = displ, y = hwy)) + 
  geom_point(position = position_jitter(),alpha = 0.5) + 
  geom_smooth(colour = "#76B843") 


#themes####
#basic example of some built in themes
df <- data.frame(x = 1:3, y = 1:3)
base <- ggplot(df, aes(x, y)) + geom_point()
base + theme_grey() + ggtitle("theme_grey()")
base + theme_bw() + ggtitle("theme_bw()")
base + theme_linedraw() + ggtitle("theme_linedraw()")



##example modifying various theme elements 
p <- borders_data %>%
  ggplot(aes(x = ageonadmission, fill = Sex)) +
 geom_histogram(binwidth = 10, 
                 position = position_dodge()) +
  scale_fill_discrete(type = c("#88478B", "#3A3776")) +
  xlab("Age") +
  ylab("Count") +
 ggtitle("Age Distribution of Borders Hospital Admissions", subtitle = "") 

p 

p +  theme(plot.title = element_text(colour = "#3A3776", family = "sans"),
        axis.title = element_text(colour = "#88478B"),
        legend.title = element_text(colour = "#88478B"),
        panel.background = element_blank(),
        panel.grid.major.y = element_line(colour = "light grey"))

#additional examples####

##facets####
View(mpg)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~cyl)
