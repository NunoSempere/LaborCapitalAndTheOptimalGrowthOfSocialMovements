# Plotting
## install.packages("tidyverse") <- Not totally necessary.
## install.packages("ggplot2")
## install.packages("ggsci")
library(ggplot2)
library(ggsci)

## General variables
saveplots=TRUE
times = times_forward_shooting 
  ## Also for reverse shooting plots; time in reverse shooting is inverted
shootingtype="reverse"#"forward"#
shootingtype="forward"#"reverse"#
# directory = "/home/nuno/Documents/core/SRF/BackShooting/RCode/plots/temp"

workingdir = "/home/<user>/Documents/<path>" # Write your own
# directory = paste(workingdir, shootingtype, "shooting", "/", last, "years", sep="")
# directory
setwd(workingdir)
# setwd(directory)

if(shootingtype=="forward"){
  x1_array_plotting <- x1_array_forward_shooting
  x3_array_plotting <- x3_array_forward_shooting
  a1_array_plotting <- a1_array_forward_shooting
  a3_array_plotting <- a3_array_forward_shooting
  s1_array_plotting <- s1_array_forward_shooting
  s3_array_plotting <- s3_array_forward_shooting
} else if(shootingtype=="reverse"){
  x1_array_plotting <- x1_array_reverse_shooting
  x3_array_plotting <- x3_array_reverse_shooting
  a1_array_plotting <- a1_array_reverse_shooting
  a3_array_plotting <- a3_array_reverse_shooting
  s1_array_plotting <- s1_array_reverse_shooting
  s3_array_plotting <- s3_array_reverse_shooting
}

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

## x1 and x3

xs <- list()
xs$values <- c(x1_array_plotting, x3_array_plotting)
xs$var <- c(rep("x1", length(x1_array_plotting)), rep("x3", length(x3_array_plotting)))
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
    legend.position="bottom",
    legend.box="vertical"
  )
  + scale_color_lancet(
    breaks=c("x1", "x3"),
    labels=c("Capital", "Labor")
    
  )
  + scale_y_continuous(breaks = seq(min(x1_array_plotting), max(x1_array_plotting), length.out=5)) ## Necessary for displaying very large numbers
)
saveplot("StateVariablesX1X3")

## x1 and x3: log plot
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
    breaks=c("x1", "x3"),
    labels=c("Capital", "Labor")
    
  )
  + scale_y_continuous(trans = 'log2')
)
saveplot("StateVariablesX1X3logplot")


## Only x3
equis3 <- list()
equis3$values <- c(x3_array_plotting)
equis3$times = times
equis3 <- as.data.frame(equis3)

title_text = "Evolution of movement size"
(ggplot(data = equis3, aes(x = times, y= values)) 
  +geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    legend.position="bottom",
    legend.box="vertical"
  )
)
saveplot("StateVariableX3")


## s1, s3, s4
sigmas <- list()
s4_array_plotting=1-s1_array_plotting-s3_array_plotting
sigmas$values <- c(s1_array_plotting, s3_array_plotting,s4_array_plotting)
sigmas$fraction <- c(rep("s1", length(s1_array_plotting)), rep("s3", length(s3_array_plotting)),rep("s4", length(s3_array_plotting)))
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
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("s1", "s3", "s4"),
    labels=c("Direct work", "Movement building", "Money-making")
    
  )
)
saveplot("MovementFractions")

## s1 and s3
sigmas <- list()
sigmas$values <- c(s1_array_plotting, s3_array_plotting)
sigmas$fraction <- c(rep("s1", length(s1_array_plotting)), rep("s3", length(s3_array_plotting)))
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
    plot.subtitle = element_text(hjust = 0.5), 
    plot.title = element_text(hjust = 0.5),
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("s1", "s3"),
    labels=c("Direct work", "Movement building")
    
  )
)
saveplot("MovementFractionsS1S3")

## Just direct work.
sigma1 <- list()
sigma1$values <- c(s1_array_plotting)
sigma1$times = times
sigma1 <- as.data.frame(sigma1)

title_text = "Evolution of direct work \nas a fraction of total labor"
(ggplot(data = sigma1, aes(x = times, y= values)) 
  +geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Fraction of total labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    legend.position="bottom",
    legend.box="vertical"
  )
)
saveplot("MovementFractionsS1")


## Just movement building
sigma3 <- list()
sigma3$values <- c(s3_array_plotting)
sigma3$times = times
sigma3 <- as.data.frame(sigma3)

title_text = "Evolution of movement building\nas a fraction of total labor"
(ggplot(data = sigma3, aes(x = times, y= values)) 
  +geom_line(size = 0.5)
  +labs(
    title=title_text,
    x="Year since start", 
    y="Fraction of labor" 
  )
  +theme(
    legend.title = element_blank(),
    plot.title = element_text(hjust = 0.5),
    legend.position="bottom",
    legend.box="vertical"
  )
)
saveplot("MovementFractionsS3")

## Just direct work - logplot
sigma1 <- list()
sigma1$values <- c(s1_array_plotting)
sigma1$times = times
sigma1 <- as.data.frame(sigma1)

title_text = "Evolution of direct work \nas a fraction of labor"
(ggplot(data = sigma1, aes(x = times, y= values)) 
  +geom_line(size = 0.5)
  +labs(
    title=title_text,
    subtitle="(logarithmic scale)", 
    x="Year since start", 
    y="Fraction of labor" 
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
saveplot("MovementFractionsS1logplot")

## Just movement building
sigma3 <- list()
sigma3$values <- c(s3_array_plotting)
sigma3$times = times
sigma3 <- as.data.frame(sigma3)

title_text = "Evolution of movement building\nas a fraction of labor"
(ggplot(data = sigma3, aes(x = times, y= values)) 
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
saveplot("MovementFractionsS3logplot")

## sigma_1*x3 and sigma3*x3, sigma_4*x3, 
sigmaxs <- list()
sigmaxs$values <- c(s1_array_plotting*x3_array_plotting, s3_array_plotting*x3_array_plotting, s4_array_plotting*x3_array_plotting)
sigmaxs$fraction <- c(rep("s1x3", length(s1_array_plotting)), rep("s3x3", length(s3_array_plotting)), rep("s4x3", length(s3_array_plotting)))
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
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("s1x3", "s3x3", "s4x3"),
    labels=c("Direct work", "Movement building", "Money-making")
    
  )
)
saveplot("MovementParticipantNumbersS1S3S4")

## sigma_1*x3 and sigma3*x3
sigmaxs <- list()
sigmaxs$values <- c(s1_array_plotting*x3_array_plotting, s3_array_plotting*x3_array_plotting)
sigmaxs$fraction <- c(rep("s1x3", length(s1_array_plotting)), rep("s3x3", length(s3_array_plotting)))
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
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("s1x3", "s3x3"),
    labels=c("Direct work", "Movement building")
    
  )
)
saveplot("MovementParticipantNumbersS1S3")

## sigma_1*x3 and sigma3*x3 logplot
sigmaxs <- list()
sigmaxs$values <- c(s1_array_plotting*x3_array_plotting, s3_array_plotting*x3_array_plotting)
sigmaxs$fraction <- c(rep("s1x3", length(s1_array_plotting)), rep("s3x3", length(s3_array_plotting)))
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
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("s1x3", "s3x3"),
    labels=c("Direct work", "Movement building")
    
  )
  + scale_y_continuous(trans = 'log2')
)
saveplot("MovementParticipantNumbersS1S3logplot")

## alpha1 and alpha3
alphas <- list()
alphas$values <- c(a1_array_plotting, a3_array_plotting)
alphas$fraction <- c(rep("a1", length(s1_array_plotting)), rep("a2", length(s3_array_plotting)))
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
    legend.position="bottom",
    legend.direction="vertical"
  )
  + scale_color_lancet(
    breaks=c("a1", "a2"),
    labels=c("Direct spending","Spending on movement building")
    
  )
)
saveplot("SpendingA1A3")

## alpha1 and alpha3: log plot

alphas <- list()
alphas$values <- c(a1_array_plotting, a3_array_plotting)
alphas$fraction <- c(rep("a1", length(s1_array_plotting)), rep("a2", length(s3_array_plotting)))
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
    breaks=c("a1", "a2"),
    labels=c("Direct spending","Spending on movement building")
  )
  + scale_y_continuous(trans = 'log2')
)
saveplot("SpendingA1A3logplot")

