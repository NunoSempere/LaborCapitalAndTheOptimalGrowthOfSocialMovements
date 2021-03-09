# Plotting
## install.packages("tidyverse") <- Not totally necessary.
## install.packages("ggplot2")

library(ggplot2)
library(ggsci) ## Used for scales

## General variables
saveplots=TRUE
### saveplots=FALSE
### shootingtype="reverse"

shootingtype="forward"
utilityfunction="ConstantElasticityOfSubstitution"
directory = paste("/home/nuno/Documents/core/srf/fresh/simulations/rcode/", utilityfunction, "/plots/", shootingtype, "shooting", last, "years", sep="")

directory
setwd(directory)
getwd()

height = 5
width = floor(height*(1+sqrt(5))/2)
imagenumbercounter = 1
saveplot = function(imagename){
  if(saveplots){
    ggsave(paste(imagenumbercounter,"_", imagename, "_",shootingtype, "shooting",".png", sep =""), units="in", width=width, height=height)  
    imagenumbercounter <<- imagenumbercounter+1
    ## https://stackoverflow.com/questions/1236620/global-variables-in-r
  }
}
options(digits=1) ## Just for display

## Data
if(shootingtype=="forward"){
  K_array_plotting <- K_array_forward_shooting
  L_array_plotting <- L_array_forward_shooting
  k1_array_plotting <- k1_array_forward_shooting
  k2_array_plotting <- k2_array_forward_shooting
  wages_array_plotting <- -wages_array_forward_shooting
  l1_array_plotting <- l1_array_forward_shooting
  l2_array_plotting <- l2_array_forward_shooting
} else if(shootingtype=="reverse"){
  K_array_plotting <- K_array_reverse_shooting
  L_array_plotting <- L_array_reverse_shooting
  k1_array_plotting <- k1_array_reverse_shooting
  k2_array_plotting <- k2_array_reverse_shooting
  l1_array_plotting <- l1_array_reverse_shooting
  l2_array_plotting <- l2_array_reverse_shooting
}

## K and L

xs <- list()
xs$values <- c(K_array_plotting, L_array_plotting)
xs$var <- c(rep("K", length(K_array_plotting)), rep("L", length(L_array_plotting)))
xs$times = rep(times,2)
xs <- as.data.frame(xs)
title_text = "Evolution of state variables"
(ggplot(data = xs, aes(x = times, y= values, color = var)) +
  geom_line(size = 0.5)
  + labs(
    title=title_text,
    x="Year since start", 
    y="Capital and labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.box="vertical"
  )
  + scale_color_lancet(
    breaks=c("K", "L"),
    labels=c("Capital", "Labor")
    
  )
  + scale_y_continuous(breaks = seq(min(K_array_plotting), max(K_array_plotting), length.out=5))
)
saveplot("StateVariablesKL")

## K and L: log plot
title_text = "Evolution of state variables"
(ggplot(data = xs, aes(x = times, y= values, color = var)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    subtitle="(logarithmic scale)",
    x="Year since start", 
    y="Capital and labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    legend.position="bottom",
    legend.box="vertical"
  )
  + scale_color_lancet(
    breaks=c("K", "L"),
    labels=c("Capital", "Labor")
    
  )
  + scale_y_continuous(trans = 'log2')
)
saveplot("StateVariablesKLlogplot")

## Only L
equil2 <- list()
equil2$values <- c(L_array_plotting)
equil2$times = times
equil2 <- as.data.frame(equil2)

title_text = "Evolution of movement size"
(ggplot(data = equil2, aes(x = times, y= values)) 
  +geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.box="vertical"
  )
)
saveplot("StateVariableL")


## l1, l2, s4
sigmas <- list()
s4_array_plotting=1-l1_array_plotting-l2_array_plotting
sigmas$values <- c(l1_array_plotting, l2_array_plotting,s4_array_plotting)
sigmas$fraction <- c(rep("l1", length(l1_array_plotting)), rep("l2", length(l2_array_plotting)),rep("s4", length(l2_array_plotting)))
sigmas$times = rep(times,3)
sigmas <- as.data.frame(sigmas)

title_text = "Evolution of labor fractions"
(ggplot(data = sigmas, aes(x = times, y= values, color = fraction)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Fraction of total labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("l1", "l2", "s4"),
    labels=c("Direct work", "Movement building", "Money-making")
  )
)
saveplot("MovementFractions")

## l1 and l2
sigmas <- list()
sigmas$values <- c(l1_array_plotting, l2_array_plotting)
sigmas$fraction <- c(rep("l1", length(l1_array_plotting)), rep("l2", length(l2_array_plotting)))
sigmas$times = rep(times,2)
sigmas <- as.data.frame(sigmas)

title_text = "Evolution of labor fractions"
subtitle_text = "(only direct work and movement building)"
(ggplot(data = sigmas, aes(x = times, y= values, color = fraction)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    subtitle=subtitle_text, 
    x="Year since start", 
    y="Fraction of total labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("l1", "l2"),
    labels=c("Direct work", "Movement building")
    
  )
)
saveplot("MovementFractionsl1l2")

## Just direct work.
sigma_1 <- list()
sigma_1$values <- c(l1_array_plotting)
sigma_1$times = times
sigma_1 <- as.data.frame(sigma_1)

title_text = "Evolution of direct work \nas a fraction of total labor"
(ggplot(data = sigma_1, aes(x = times, y= values)) 
  +geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Fraction of total labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.box="vertical"
  )
)
saveplot("MovementFractionsl1")


## Just movement building
sigma_2 <- list()
sigma_2$values <- c(l2_array_plotting)
sigma_2$times = times
sigma_2 <- as.data.frame(sigma_2)

title_text = "Evolution of movement building\nas a fraction of total labor"
(ggplot(data = sigma_2, aes(x = times, y= values)) 
  +geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Fraction of labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.box="vertical"
  )
)
saveplot("MovementFractionsl2")

## Just direct work - logplot
sigma_1 <- list()
sigma_1$values <- c(l1_array_plotting)
sigma_1$times = times
sigma_1 <- as.data.frame(sigma_1)

title_text = "Evolution of direct work \nas a fraction of labor"
(ggplot(data = sigma_1, aes(x = times, y= values)) 
  +geom_line(size = 0.5)
  +labs(
    title=title_text,
    subtitle="(logarithmic scale)", 
    x="Year since start", 
    y="Fraction of labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.box="vertical"
  )
  + scale_y_continuous(trans = 'log2')
)
saveplot("MovementFractionsl1logplot")

## Just movement building
sigma_2 <- list()
sigma_2$values <- c(l2_array_plotting)
sigma_2$times = times
sigma_2 <- as.data.frame(sigma_2)

title_text = "Evolution of movement building\nas a fraction of labor"
(ggplot(data = sigma_2, aes(x = times, y= values)) 
  +geom_line(size = 0.5)
  +labs(
    title=title_text,
    subtitle="(logarithmic scale)", 
    x="Year since start", 
    y="Fraction of total labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.subtitle = element_text(hjust = 0.5), 
    plot.title = element_text(hjust = 0.5),
    legend.position="bottom",
    legend.box="vertical"
  )
  + scale_y_continuous(trans = 'log2')
)
saveplot("MovementFractionsl2logplot")

## sigma_1*L and sigma_2*L, sigma_4*L, 
sigmaxs <- list()
sigmaxs$values <- c(l1_array_plotting*L_array_plotting, l2_array_plotting*L_array_plotting, s4_array_plotting*L_array_plotting)
sigmaxs$fraction <- c(rep("l1L", length(l1_array_plotting)), rep("l2L", length(l2_array_plotting)), rep("s4L", length(l2_array_plotting)))
sigmaxs$times = rep(times,3)
sigmaxs <- as.data.frame(sigmaxs)

title_text = "Evolution of labor\n in absolute terms"
(ggplot(data = sigmaxs, aes(x = times, y= values, color = fraction)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Absolute number\nof movement participants" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("l1L", "l2L", "s4L"),
    labels=c("Direct work", "Movement building", "Money-making")
    
  )
)
saveplot("MovementParticipantNumbersl1l2S4")

## sigma_1*L and sigma_2*L
sigmaxs <- list()
sigmaxs$values <- c(l1_array_plotting*L_array_plotting, l2_array_plotting*L_array_plotting)
sigmaxs$fraction <- c(rep("l1L", length(l1_array_plotting)), rep("l2L", length(l2_array_plotting)))
sigmaxs$times = rep(times,2)
sigmaxs <- as.data.frame(sigmaxs)

title_text = "Evolution of movement participants\nin absolute terms"
(ggplot(data = sigmaxs, aes(x = times, y= values, color = fraction)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    subtitle="(only direct workers and movement builders)", 
    x="Year since start", 
    y="Absolute number\nof movement participants" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("l1L", "l2L"),
    labels=c("Direct work", "Movement building")
    
  )
)
saveplot("MovementParticipantNumbersl1l2")

## sigma_1*L and sigma_2*L logplot
sigmaxs <- list()
sigmaxs$values <- c(l1_array_plotting*L_array_plotting, l2_array_plotting*L_array_plotting)
sigmaxs$fraction <- c(rep("l1L", length(l1_array_plotting)), rep("l2L", length(l2_array_plotting)))
sigmaxs$times = rep(times,2)
sigmaxs <- as.data.frame(sigmaxs)

title_text = "Evolution of movement participants\nin absolute terms \n(logarithmic scale)"
(ggplot(data = sigmaxs, aes(x = times, y= values, color = fraction)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    subtitle="(only direct workers and movement builders)", 
    x="Year since start", 
    y="Absolute number\nof movement participants" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("l1L", "l2L"),
    labels=c("Direct work", "Movement building")
    
  )
  + scale_y_continuous(trans = 'log2')
)
saveplot("MovementParticipantNumbersl1l2logplot")

## alpha1 and alpha2
alphas <- list()
alphas$values <- c(k1_array_plotting, k2_array_plotting)
alphas$fraction <- c(rep("k1", length(l1_array_plotting)), rep("k2", length(l2_array_plotting)))
alphas$times = rep(times,2)
alphas <- as.data.frame(alphas)

title_text = "Evolution of spending"
(ggplot(data = alphas, aes(x = times, y= values, color = fraction)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Spending" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("k1", "k2"),
    labels=c("Direct spending","Spending on movement building")
    
  )
)
saveplot("Spendingk1k2")

## alphk1 and alphk2: log plot

alphas <- list()
alphas$values <- c(k1_array_plotting, k2_array_plotting)
alphas$fraction <- c(rep("k1", length(l1_array_plotting)), rep("k2", length(l2_array_plotting)))
alphas$times = rep(times,2)
alphas <- as.data.frame(alphas)

title_text = "Evolution of spending"
(ggplot(data = alphas, aes(x = times, y= values, color = fraction)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    subtitle="(logarithmic scale)",
    x="Year since start", 
    y="Spending" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("k1", "k2"),
    labels=c("Direct spending","Spending on movement building")
  )
  + scale_y_continuous(trans = 'log2')
)
saveplot("Spendingk1k2logplot")

## alpha1 and alpha2 and wages
alphas <- list()
alphas$values <- c(k1_array_plotting, k2_array_plotting, wages_array_plotting)
alphas$fraction <- c(rep("k1", length(l1_array_plotting)), rep("k2", length(l2_array_plotting)), rep("wages", length(wages_array_plotting)))
alphas$times = rep(times,3)
alphas <- as.data.frame(alphas)

title_text = "Evolution of spending"
(ggplot(data = alphas, aes(x = times, y= values, color = fraction)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Spending" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("k1", "k2", "wages"),
    labels=c("Direct spending","Spending on movement building", "Spending on wages")
  )
)
saveplot("Spendingk1k2k3")


## alpha1 and alpha2 and wages: logplot
alphas <- list()
alphas$values <- c(k1_array_plotting, k2_array_plotting, wages_array_plotting)
alphas$fraction <- c(rep("k1", length(l1_array_plotting)), rep("k2", length(l2_array_plotting)), rep("wages", length(wages_array_plotting)))
alphas$times = rep(times,3)
alphas <- as.data.frame(alphas)

title_text = "Evolution of spending"
(ggplot(data = alphas, aes(x = times, y= values, color = fraction)) +
    geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Spending" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("k1", "k2", "wages"),
    labels=c("Direct spending","Spending on movement building", "Spending on wages")
  )
  + scale_y_continuous(trans = 'log2')
)
saveplot("Spendingk1k2k3_logplot")