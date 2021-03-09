library(ggplot2)
library(ggsci) ## Used for scales

## Directory
directory = paste("/home/nuno/Documents/core/srf/fresh/simulations/rcode/", utilityfunction, "/plots/", sep="")
directory
setwd(directory)
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
data$capital = c(K_above_knife_edge,K_at_knife_edge,K_below_knife_edge)
data$category = c(rep(knife_edge_constant_above, length(times)), rep(knife_edge_constant_0, length(times)), rep(knife_edge_constant_below, length(times)))
data$times = rep(times, 3)
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
  )
saveplot(meaning)

## Labor
data = list()
data$labor = c(L_above_knife_edge,L_at_knife_edge,L_below_knife_edge)
data$category = c(rep(knife_edge_constant_above, length(times)), rep(knife_edge_constant_0, length(times)), rep(knife_edge_constant_below, length(times)))
data$times = rep(times, 3)
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
data$l1 = c(l1_above_knife_edge,l1_at_knife_edge,l1_below_knife_edge)
data$category = c(rep(knife_edge_constant_above, length(times)), rep(knife_edge_constant_0, length(times)), rep(knife_edge_constant_below, length(times)))
data$times = rep(times, 3)
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
data$l2 = c(l2_above_knife_edge,l2_at_knife_edge,l2_below_knife_edge)
data$category = c(rep(knife_edge_constant_above, length(times)), rep(knife_edge_constant_0, length(times)), rep(knife_edge_constant_below, length(times)))
data$times = rep(times, 3)
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
data$l3 = c(l3_above_knife_edge,l3_at_knife_edge,l3_below_knife_edge)
data$category = c(rep(knife_edge_constant_above, length(times)), rep(knife_edge_constant_0, length(times)), rep(knife_edge_constant_below, length(times)))
data$times = rep(times, 3)
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
data$k1 = c(k1_above_knife_edge,k1_at_knife_edge,k1_below_knife_edge)
data$category = c(rep(knife_edge_constant_above, length(times)), rep(knife_edge_constant_0, length(times)), rep(knife_edge_constant_below, length(times)))
data$times = rep(times, 3)
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
saveplot(meaning)

## k2
data = list()
data$k2 = c(k2_above_knife_edge,k2_at_knife_edge,k2_below_knife_edge)
data$category = c(rep(knife_edge_constant_above, length(times)), rep(knife_edge_constant_0, length(times)), rep(knife_edge_constant_below, length(times)))
data$times = rep(times, 3)
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

## wages
data = list()
data$wages = c(wages_above_knife_edge,wages_at_knife_edge,wages_below_knife_edge)
data$category = c(rep(knife_edge_constant_above, length(times)), rep(knife_edge_constant_0, length(times)), rep(knife_edge_constant_below, length(times)))
data$times = rep(times, 3)
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
