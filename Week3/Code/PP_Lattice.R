# # Script that draws and saves 3 lattice graphs
# # by feeding interaction type:
#     # Predator mass
#     # Prey mass
#     # Size ratio of prey mass over predator mass
# # Use logarithms of masses for all 3 plots
# # Script will also calculate mean and median
# # predator mass, prey mass, and predator-prey
# # size-ratios to a csv file 

MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

library(dplyr)
library(lattice)

### Lattices ###

# Predator mass lattice
pdf("../Results/Pred_Lattice.pdf", 11.7, 8.3)
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF,
    xlab = "Predator Mass (kg)")
graphics.off()

# Prey mass lattice
pdf("../Results/Prey_Lattice.pdf", 11.7, 8.3)
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=MyDF, 
    xlab = "Prey Mass (kg)")
graphics.off()

# Predator-prey size-ratios lattice
pdf("../Results/SizeRatio_Lattice.pdf", 11.7, 8.3)
pp_ratio <- MyDF$Predator.mass/MyDF$Prey.mass
densityplot(~log(pp_ratio) | Type.of.feeding.interaction, data=MyDF, 
    xlab = "Predator-prey Size-ratio")
graphics.off()


### Mean and Median Calculations ###

# Predator mean
pred_mean <- MyDF %>%
        group_by(Type.of.feeding.interaction) %>%
            summarise(
            Predator.mean = mean(log(Predator.mass))
        ) 

# Predator median
pred_median <- MyDF %>%
        group_by(Type.of.feeding.interaction) %>%
            summarise(
            Predator.median = median(log(Predator.mass))
        ) 

# Prey mean
prey_mean <- MyDF %>%
        group_by(Type.of.feeding.interaction) %>%
            summarise(
            Prey.mean = mean(log(Prey.mass))
        ) 

# Prey median
prey_median <- MyDF %>%
        group_by(Type.of.feeding.interaction) %>%
            summarise(
            Prey.median = median(log(Prey.mass))
        ) 

# Predator:prey mean
predprey_mean <- MyDF %>%
        group_by(Type.of.feeding.interaction) %>%
            summarise(
            Pred_prey.mean = mean(log(Predator.mass/Prey.mass))
        ) 

# Predator:prey median
predprey_median <- MyDF %>%
        group_by(Type.of.feeding.interaction) %>%
            summarise(
            Pred_prey.median = median(log(Predator.mass/Prey.mass))
        ) 

# Creating new dataframe
NewDF <- left_join(pred_mean, pred_median, by='Type.of.feeding.interaction') %>%
                left_join(., prey_mean, by='Type.of.feeding.interaction') %>%
                left_join(., prey_median, by='Type.of.feeding.interaction') %>%
                left_join(., predprey_mean, by='Type.of.feeding.interaction') %>%
                left_join(., predprey_median, by='Type.of.feeding.interaction')

write.csv(NewDF, "../Results/PP_Results.csv")

