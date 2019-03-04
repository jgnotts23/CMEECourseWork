#Reading Dataset into R, making RSPO a factor column, Years an integer column and the rest numeric. Headers=True. 
library(readr)
Oil_2_0 <- read_csv("Oil 2.0.csv", col_types = cols(Average = col_number(), 
                                                    Conservation = col_number(), Palm = col_number(), 
                                                    RSPO = col_factor(levels = c("Yes", "No")), 
                                                    SPOTT = col_integer(), Same = col_factor(levels = c("1", "0")), 
                                                    Smallholder = col_number(), Total = col_number(), 
                                                    Unplanted = col_number(), Years = col_integer()))

View(Oil_2_0)

#to change Same factors from 1 and 0 to Yes and No 
levels(Oil_2_0$Same)[levels(Oil_2_0$Same)=="1"] <- "Same Country"
levels(Oil_2_0$Same)[levels(Oil_2_0$Same)=="0"] <- "Different or Multiple Countries"

#to change RSPO membership from yes and no to Member and Non-Member
levels(Oil_2_0$RSPO)[levels(Oil_2_0$RSPO)=="Yes"] <- "Member"
levels(Oil_2_0$RSPO)[levels(Oil_2_0$RSPO)=="No"] <- "Non-Member"

#to get basic decriptive statistics (mean, median, quartiles etc)
summary(Oil_2_0)

#RSPO:factor, is whether or not company is a member of this organisation
#Years:integer, is time spent as a member of RSPO
#SPOTT:integer, is number of assessments by SPOTT on company
#Same:factor, is whether headquarter and operational locations are the same country

#ALL THE BELOW IS FROM NOVEMBER 2018
#Total:numeric, is SPOTT score for all landholdings (incl timber/pulp) of a company
#Palm:numeric, is SPOTT score for palm oil landholdings of a company
#Smallholder:numeric, is SPOTT score for smallholdings of palm oil 
#Unplanted:numeric, is SPOTT score for landholding not yet planted by a company
#Conservation:numeric, is SPOTT score for landholdings set aside for conservation
#Average:numeric, is the mean of total, palm, smallholder, unplanted and conservation 
#data with NAs in 'years' changed to zeros

#Descriptive barplots 
table(Oil_2_0$RSPO)
table(Oil_2_0$Same)

barplot(table(Oil_2_0$RSPO), main="Companies with RSPO Membership", ylab="Number of Companies", ylim=c(0,50))
barplot(table(Oil_2_0$Same), main="Companies with Headquarters and Operations in the Same Country", ylab="Number of Companies")

#testing for normal distribution
hist(Oil_2_0$SPOTT)
hist(Oil_2_0$Years)
shapiro.test(Oil_2_0$SPOTT)
#p value of 2.48e-07 - not normal
shapiro.test(Oil_2_0$Years)
#p value of 1.007e-07 - not normal

wilcox.test(Oil_2_0$Years, Oil_2_0$SPOTT, paired = FALSE) 
#not sig
wilcox.test(Oil_2_0$RSPO ~ Oil_2_0$SPOTT, paired = FALSE) 
#doesn't work

