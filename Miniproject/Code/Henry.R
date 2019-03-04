##Clear space and set working directory##
rm(list=ls())
#install.packages("ggpubr")
library(ggplot2)
library(lme4)

data <- read.csv("../Data/Jacob.csv")

##Subset data according to mode of transport##
Foot<-subset(Patrols_Complete,Patrols_Complete$MODE=="Foot")
VF<-subset(Patrols_Complete,Patrols_Complete$MODE=="VF")
Vehicle<-subset(Patrols_Complete,Patrols_Complete$MODE=="Vehicle")

##Create linear models per mode of transport##
model1<-lm(No_Obs~Total_Time_mins,data=Patrols_Complete)
model_Foot<-lm(No_Obs~Total_Time_mins,data=Foot)
model_VF<-lm(No_Obs~Total_Time_mins,data=VF)
model_Vehicle<-lm(No_Obs~Total_Time_mins,data=Vehicle)

##Look at each model##
summary(model1)
summary(model_Foot)
summary(model_Vehicle)
summary(model_Vf)

kruskal.test(No_Obs~Total_Time_mins,data=Patrols_Complete)
kruskal.test(No_Obs~Total_Time_mins,data=Foot)
kruskal.test(No_Obs~Total_Time_mins,data=VF)
kruskal.test(No_Obs~Total_Time_mins,data=Vehicle)

##Test for correlation, create lm, plot (linear analyses)##
cor(Patrol_Time_Obs_Total$Total_No_Obs,Patrol_Time_Obs_Total$Total_Patrol_Time)
model_summary<-lm(Total_No_Obs~Total_Patrol_Time,data=Patrol_Time_Obs_Total)
summary(model_summary)
plot(Patrol_Time_Obs_Total$Total_Patrol_Time,Patrol_Time_Obs_Total$Total_No_Obs,pch=16,cex=1.3,col="blue",xlab="Total Patrol Time (mins)",ylab="Total Number of Observations",main="Patrol Time and Number of Secretary Birds Seen
     2011-2017")
abline(model_summary)

cor(Foot_Summary$Total_No_Obs,Foot_Summary$Total_Patrol_Time)
model_foot<-lm(Total_No_Obs~Total_Patrol_Time,data=Foot_Summary)
summary(model_foot)
plot(Foot_Summary$Total_Patrol_Time,Foot_Summary$Total_No_Obs,
     pch=16,cex=1.3,col="blue",xlab="Total Patrol Time (mins)",ylab="Total Number of Observations",
     main="Patrol Time and Number of Secretary Birds Seen
     2011-2017 | Foot")
abline(model_foot)

cor(Vehicle_Summary$Total_No_Obs,Vehicle_Summary$Total_Patrol_Time)
model_vehicle<-lm(Total_No_Obs~Total_Patrol_Time,data=Vehicle_Summary)
summary(model_vehicle)
plot(Vehicle_Summary$Total_Patrol_Time,Vehicle_Summary$Total_No_Obs,
     pch=16,cex=1.3,col="blue",xlab="Total Patrol Time (mins)",ylab="Total Number of Observations",
     main="Patrol Time and Number of Secretary Birds Seen
     2011-2017 | Vehicle")
abline(model_vehicle)

cor(VF_Summary$Total_No_Obs,VF_Summary$Total_Patrol_Time)
model_VF<-lm(Total_No_Obs~Total_Patrol_Time,data=VF_Summary)
summary(model_VF)
plot(VF_Summary$Total_Patrol_Time,VF_Summary$Total_No_Obs,
     pch=16,cex=1.3,col="blue",xlab="Total Patrol Time (mins)",ylab="Total Number of Observations",
     main="Patrol Time and Number of Secretary Birds Seen
     2011-2017 | VF")
abline(model_VF)

##Test for significance##
glm1<-lm(No_Obs~Total_Time_mins+MODE,data=Patrols_Complete,na.action=na.exclude)
summary(glm1)

glm2<-lm(No_Obs~Total_Time_mins+RANCH,data=Patrols_Complete,na.action=na.exclude)
summary(glm2)

glm3<-lm(No_Obs~Total_Time_mins+Year,data=Patrols_Complete,na.action=na.exclude)
summary(glm3)

##Isolate year, no. obs. MODE##
Patrols_1<-select(Patrols_Complete,Year,No_Obs,MODE)
Patrols_1[is.na(Patrols_1)] <- 0
View(Patrols_1)
group_summary<-Patrols_1%>%group_by(Year)%>%summarise(total.obs=sum(No_Obs))
group_summary_2<-Patrols_1%>%group_by(Year,MODE)%>%summarise(total.obs=sum(No_Obs))
View(group_summary_2)

##Isolate year, no. obs. RANCH##
group_summary_3<-Patrols_Complete%>%group_by(Year,RANCH)%>%summarise(total.obs=sum(No_Obs))

##Data Visualisation##
scatter_1<-xyplot(total.obs~Year|MODE,data=group_summary_2,ylab="Total Number of Observations",xlab="Year",main="Number of Observations 2011-2017")
print(scatter_1)

group_summary_2%>%ggplot(aes(x=Year,y=total.obs))+geom_bar(stat="identity",fill="darkorchid2")+facet_wrap(~MODE,ncol=2)+labs(title="Number of Observations 2011-2017",y="Total Number of Observations",x="Year")+theme_bw(base_size=15)

Bar_1<-barchart(Year~total.obs,data=group_summary,fill="blue",
                xlab="Total Number of Observations",ylab="Year",
                main="Number of Observations per Year 2011-2017")

Bar_2<-barchart(Year~total.obs,data=group_summary_2,groups=MODE,
                stack=TRUE,auto.key=list(space="right"),
                xlab="Total Number of Observations",ylab="Year",main="Number of Observations per Year 2011-2017")

group_summary_2%>%ggplot(aes(x=Year,y=total.obs))+geom_bar(stat="identity",fill="darkorchid2")+facet_wrap(~MODE,ncol=2)+labs(title="Number of Observations 2011-2017",
                                                                                                                             subtitle="plotted by mode of transport",y="Total No. Observations",x="Year")+theme_bw(base_size=15)

group_summary%>%ggplot(aes(x=Year,y=total.obs))+geom_bar(stat="identity",fill="blue")+labs(title="Number of Observations 2011-2017",y="Total No. Observations",x="Year")+theme_bw(base_size=15)

group_summary_2%>%ggplot(aes(x=Year,y=total.obs,group=MODE))+geom_col(aes(fill=MODE), position=position_stack(reverse=TRUE))+labs(title="Number of Observations 2011-2017",y="Total No. Observations",x="Year")+theme_bw(base_size=15)

p<-group_summary_3%>%ggplot(aes(x=Year,y=total.obs,group=RANCH))+geom_col(aes(fill=RANCH), position=position_stack(reverse=TRUE))+labs(title="Number of Observations 2011-2017",y="Total No. Observations",x="Year")+theme_bw(base_size=15)
p+scale_fill_brewer(palette="Paired")

##Significance of Ranch on No. Observations##
model1_Ranch<-lm(No_Obs~RANCH,data=Patrols_Complete)
summary(model1_Ranch)
model2_Ranch<-lm(Total_Time_mins~RANCH,data=Patrols_Complete)
summary(model2_Ranch)
glm_Ranch<-lm(No_Obs~RANCH+Year,data=Patrols_Complete,na.action=na.exclude)
summary(glm_Ranch)


## Difference in observations between ranches ##
data <- data[!is.na(data$No_Obs),]
plot(data$RANCH, data$No_Obs)

ggplot(data, aes(factor(RANCH), No_Obs)) +  
  geom_bar(stat="identity", position = "dodge") + 
  scale_fill_brewer(palette = "Set1")

ggplot(data, aes(factor(RANCH), No_Obs, fill = MODE)) +  
  geom_bar(stat="identity", position = "dodge") + 
  scale_fill_brewer(palette = "Set1")


model1 <- glm(data$No_Obs ~ data$RANCH, poisson)

model2 <- glmer(data$No_Obs ~ (1 | data$RANCH), family=poisson)

model3 <- lmer(No_Obs ~ MODE + (1|RANCH), data=data)


## Numbers of days patrolled between ranches ##
## Difference in mode of transport between ranches ##






