#####################################
###   Introduction to ggplot2   #####
##
#
####################################

#load ggplot
library(ggplot2)


# load data


borders_data_plot %>%
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

# dataset:
data <- data.frame(value=rnorm(100))

# basic histogram
p <- ggplot(data, aes(x=value)) + 
  geom_histogram()


##bar

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


