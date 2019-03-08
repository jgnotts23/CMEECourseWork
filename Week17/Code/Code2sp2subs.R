
rm(list=ls())
graphics.off()

##assign values to parameters, species 1 and species 2 
N0<-c(0.1,0.1)
S0<-c(5,3)
d<-0.01
kcat<-matrix(c(0.1,0.1,0.1,0.1),nrow=2) # the amount of substrate that a unit amount of enzyme can metabolise per unit time
Km<-matrix(c(0.5,0.5,0.5,0.5),nrow=2) #the Michaelis constant - concentration at which the reaction rate is 1/2 its maximum
c.conv<-matrix(c(1,1,1,1),nrow=2) #the conversion rate from substrate metabolised to density increase
pH0 <- 7
pH_optima <- matrix(c(6, 6, 8, 8), nrow=2)
S_max <- c(6, 8)
##set up so can have different parameter for each species X substrate
##column = species, row = substrate
E<-matrix(c(1,0,0,1),nrow=2,ncol=2) ##the amount of enzyme per cell

##choose time steps and total time
time.step<-0.1
times<-seq(0,100,time.step)

##set initial values of state variables
S<-S0
N<-N0
pH <- pH0

##store results
results<-matrix(NA,nrow=length(times)+1,ncol=6)

	##store time 0 values
	results[1,1]<-0 # Timestep counter
	results[1,2:3]<-S #Columns 2 and 3
	results[1,4:5]<-N #Columns 4 and 5
	results[1, 6] <- pH
	
E_adjust <- function(pH, pH_opt, c) {
  scale <- exp(-((pH - pH_opt)^2)/((2*c)^2))
  
  return(scale)
}

pH_adjust <- function(S1, S2, pH){
  S1_conc <- S1/(S2+S1)
  S2_conc <- S2/(S1+S2)
  
  S1_scale <- (exp(-(S_max[1] - S1))) # reduces pH
  S2_scale <- (exp(S_max[2] - S2)) # increases pH
  
  S1_scale_factor <- S1_scale * S1_conc
  S2_scale_factor <- S2_scale * S2_conc
  
  new_pH <- pH * S1_scale_factor * S2_scale_factor
  
  return(new_pH)
}


##loop through the times
for (i in (1:length(times))) {
  
  # Adjust E's based on pH
  E[1,1] <- E_adjust(pH, pH_optima[1,1], 1)
  E[1,2] <- E_adjust(pH, pH_optima[1,2], 1)
  E[2,1] <- E_adjust(pH, pH_optima[2,1], 1)
  E[2,2] <- E_adjust(pH, pH_optima[2,2], 1)
  
	
	##assign new values - now S1 might be used by both species, each species might grow on both substrates
	S[1] <- S[1]-(kcat[1,1]*E[1,1]*S[1]/(Km[1,1]+S[1]))*N[1]*time.step-(kcat[1,2]*E[1,2]*S[1]/(Km[1,2]+S[1]))*N[2]*time.step-d*S[1]*time.step+d*S0[1]*time.step
	S[2] <- S[2]-(kcat[2,1]*E[2,1]*S[2]/(Km[2,1]+S[2]))*N[1]*time.step-(kcat[2,2]*E[2,2]*S[2]/(Km[2,2]+S[2]))*N[2]*time.step-d*S[2]*time.step+d*S0[2]*time.step
	N[1] <- N[1]+(c.conv[1,1]*(kcat[1,1]*E[1,1]*S[1]/(Km[1,1]+S[1]))*N[1]*time.step)+(c.conv[2,1]*(kcat[2,1]*E[2,1]*S[2]/(Km[2,1]+S[2]))*N[1]*time.step)-d*N[1]*time.step
	N[2] <- N[2]+(c.conv[1,2]*(kcat[1,2]*E[1,2]*S[1]/(Km[1,2]+S[1]))*N[2]*time.step)+(c.conv[2,2]*(kcat[2,2]*E[2,2]*S[2]/(Km[2,2]+S[2]))*N[2]*time.step)-d*N[2]*time.step

	pH <- pH_adjust(S[1], S[2], pH)
	
	results[i+1,1]<-times[i]
	results[i+1,2:3]<-S
	results[i+1,4:5]<-N
	results[i+1, 6] <- pH
	
}

##plot the results
##a) Densities
matplot(results[,1], results[,2:5], type="l", xlab="Time", 
        ylab="Density/Concentration",col=c("black","red","black","red"),
        lty=c(1,1,2,2))
legend(x=80,y=2,legend=c("S1","S2","N1","N2"), col=c("black","red","black","red"),lty=c(1,1,2,2))
