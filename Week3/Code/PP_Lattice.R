# # Script that draws and saves 3 lattice graphs
# # by feeding interaction type:
#     # Predator mass
#     # Prey mass
#     # Size ratio of prey mass over predator mass
# # Use logarithms of masses for all 3 plots
# # Script will also calculate mean and median
# # predator mass, prey mass, and predator-prey
# # size-ratios to a csv file 

MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv", header=T)

library(dplyr)
library(lattice)

### Lattices ###

# Predator mass lattice
pdf("../Results/Pred_Lattice.pdf", 11.7, 8.3)
pred <- densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF,
    xlab = "Predator Mass (kg)")
print(pred)
graphics.off()

# Prey mass lattice
pdf("../Results/Prey_Lattice.pdf", 11.7, 8.3)
prey <- densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=MyDF, 
    xlab = "Prey Mass (kg)")
print(prey)
graphics.off()

# Predator-prey size-ratios lattice
pdf("../Results/SizeRatio_Lattice.pdf", 11.7, 8.3)
pp_ratio <- MyDF$Predator.mass/MyDF$Prey.mass
sizeratio <- densityplot(~log(pp_ratio) | Type.of.feeding.interaction, data=MyDF, 
    xlab = "Predator-prey Size-ratio")
print(sizeratio)
graphics.off()


### Mean and Median Calculations ###

# Predator mean & median
pred <- MyDF %>% group_by(Type.of.feeding.interaction) %>%
            summarise(
            mean = mean(log(Predator.mass)),
            median = median(log(Predator.mass))
        )


# Prey mean & median
prey <- MyDF %>%
        group_by(Type.of.feeding.interaction) %>%
            summarise(
            mean = mean(log(Prey.mass)),
            median = median(log(Prey.mass))
        ) 


# Predator:prey mean & median
predprey <- MyDF %>%
        group_by(Type.of.feeding.interaction) %>%
            summarise(
            mean = mean(log(Predator.mass/Prey.mass)),
            median = mean(log(Predator.mass/Prey.mass))
        ) 


# Creating new dataframe
NewDF <- rbind(pred, prey, predprey)

write.csv(NewDF, "../Results/PP_Results.csv")

