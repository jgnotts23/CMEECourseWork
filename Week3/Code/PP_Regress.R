

MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

require(ggplot2)
require(dplyr)
require(plyr)


pdf(file = "../Results/PP_Regress.pdf", 8, 15)
p <- ggplot(MyDF, aes(x = Predator.mass,
                y = Prey.mass,
                colour = Predator.lifestage,)) +
                geom_point(shape=3) +
                xlab("Prey Mass in grams") +
                ylab("Predator mass in grams") +
                facet_grid(Type.of.feeding.interaction ~ .) +
                coord_fixed(0.25) +
                guides(colour = guide_legend(nrow = 1)) +
                scale_y_continuous(trans='log10', limits=c(1e-09, 1e+07)) +
                scale_x_continuous(trans='log10', limits=c(1e-10, 1e+04)) +
                geom_smooth(method="lm", fullrange=T) +
                theme(legend.title = element_text(face="bold")) +
                theme_bw() +
                theme(legend.position="bottom")    
print(p)  
graphics.off()



lmfit <- dlply(MyDF, .(Type.of.feeding.interaction, Predator.lifestage), function(MyDF) lm(log(Predator.mass)~log(Prey.mass), data=MyDF))

stats_out <- ldply(lmfit, function(MyDF) {
    intercept <- summary(MyDF)$coefficients[1]
    slope <- summary(MyDF)$coefficients[2]
    p.value <- summary(MyDF)$coefficients[8]
    r2 <- summary(MyDF)$r.squared
    data.frame(r2, intercept, slope, p.value)
    })

F.statistic <- ldply(lmfit, function(MyDF) summary(MyDF)$fstatistic[1])

stats_out <- merge(stats_out, F.statistic, by = c("Type.of.feeding.interaction","Predator.lifestage"),all=T)

names(stats_out)[7] <- "F.statistic"
names(stats_out)[4] <- "Gradient"

write.csv(stats_out, "../Results/PP_Regress_Results.csv", row.names = FALSE, quote = FALSE)

print(stats_out)

