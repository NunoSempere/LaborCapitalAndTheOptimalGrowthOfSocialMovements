library(ggplot2)
library(ggsci) ## Used for scales

## Directory
directory = paste("/home/nuno/Documents/core/srf/fresh/simulations/rcode/", utilityfunction, "/plots/", sep="")
directory
setwd(directory)

## Initializing elements
times_array <- c() ## times_array <- c(rep(times, length(K_knife_edge)/length(times)))
knife_edge_constant_array <- c() 
K_knife_edge <- c()
L_knife_edge <- c()
k1_knife_edge <- c()
k2_knife_edge <- c()
wages_knife_edge <- c()
l1_knife_edge <- c()
l2_knife_edge <- c()
l3_knife_edge <- c()

## Saving plots
height = 5
width = floor(height*(1+sqrt(5))/2)
imagenumbercounter = 1
saveplots=TRUE
saveplot = function(imagename){
  if(saveplots){
    ggsave(paste(imagenumbercounter,"_", imagename, "_knifeedge",".png", sep =""), units="in", width=width, height=height)  
    imagenumbercounter <<- imagenumbercounter+1
    ## https://stackoverflow.com/questions/1236620/global-variables-in-r
  }
}
options(digits=2) ## Just for display

## Capital
data = list()
data$capital = K_knife_edge
data$category = knife_edge_constant_array
data$times = times_array
data <- as.data.frame(data)

options(digits=2) ## Just for display
variable = "K"
meaning = "Capital"
title_text = paste("Evolution of ", tolower(meaning))
ggplot(data = data, aes(x=times, y=capital)) +
  geom_point(aes(color=category), size=0.05) +
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  ) # +
 #scale_y_continuous(trans = 'log2')

saveplot(meaning)

## Labor
data = list()
data$labor = L_knife_edge
data$category = knife_edge_constant_array
data$times = times_array
data <- as.data.frame(data)

variable = "L"
meaning = "Labor"
title_text = paste("Evolution of ", tolower(meaning))
ggplot(data = data, aes(x=times, y=labor))+
  geom_point(aes(color=category), size=0.05) +
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  )

saveplot(meaning)

## l1
data = list()
data$l1 = l1_knife_edge
data$category = knife_edge_constant_array
data$times = times_array
data <- as.data.frame(data)

variable = "l1"
meaning = "Direct work"
title_text = paste("Evolution of ", tolower(meaning))
ggplot(data = data, aes(x=times, y=l1))+
  geom_point(aes(color=category), size=0.05) +
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  )
saveplot(meaning)

## l2
data = list()
data$l2 = l2_knife_edge
data$category = knife_edge_constant_array
data$times = times_array
data <- as.data.frame(data)

variable = "l2"
meaning = "Movement building labor"
title_text = paste("Evolution of ", tolower(meaning))
ggplot(data = data, aes(x=times, y=l2))+
  geom_point(aes(color=category), size=0.05) +
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  )
saveplot(meaning)

## l3
data = list()
data$l3 = l3_knife_edge
data$category = knife_edge_constant_array
data$times = times_array
data <- as.data.frame(data)

variable = "l3"
meaning = "Money-making/hired labor"
title_text = paste("Evolution of ", tolower(meaning))
ggplot(data = data, aes(x=times, y=l3))+
  geom_point(aes(color=category), size=0.1)+
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  )
saveplot("Money-makingORhired labor")

## k1
data = list()
data$k1 = k1_knife_edge
data$category = knife_edge_constant_array
data$times = times_array
data <- as.data.frame(data)

variable = "k1"
meaning = "Direct spending"
title_text = paste("Evolution of ", tolower(meaning))
ggplot(data = data, aes(x=times, y=k1))+
  geom_point(aes(color=category), size=0.1)+
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  )
saveplot(meaning)

ggplot(data = data, aes(x=times, y=k1))+
  geom_point(aes(color=category), size=0.1)+
  scale_y_continuous(trans = 'log2')+
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  )
saveplot(paste(meaning,"logplot", sep="_"))

## k2
data = list()
data$k2 = k2_knife_edge
data$category = knife_edge_constant_array
data$times = times_array
data <- as.data.frame(data)

variable = "k2"
meaning = "Spending on movement building"
title_text = paste("Evolution of ", tolower(meaning))
ggplot(data = data, aes(x=times, y=k2))+
  geom_point(aes(color=category), size=0.1)+
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  )
saveplot(meaning)

ggplot(data = data, aes(x=times, y=k2))+
  geom_point(aes(color=category), size=0.1)+
  scale_y_continuous(trans = 'log2')+
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  )
saveplot(paste(meaning,"logplot", sep="_"))

## wages
data = list()
data$wages = wages_knife_edge
data$category = knife_edge_constant_array
data$times = times_array
data <- as.data.frame(data)

variable = "L(t)*w2*exp(γ1*t)*(1-l1-l2)"
meaning = "wages"
title_text = paste("Evolution of ", tolower(meaning))
ggplot(data = data, aes(x=times, y=wages))+
  geom_point(aes(color=category), size=0.1)+
  labs(
    title=title_text,
    subtitle=paste("(",variable,")",sep=""),
    color="Knife edge",
    x="Year since start", 
    y=meaning
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5), 
    legend.direction="vertical"
  )
saveplot(meaning)
