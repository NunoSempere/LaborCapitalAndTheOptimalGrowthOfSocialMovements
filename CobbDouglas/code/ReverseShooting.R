# Reverse shooting
options(digits=22)

## Evolution
x1_array_reverse_shooting <- c()
x3_array_reverse_shooting <- c()
a1_array_reverse_shooting <- c()
a3_array_reverse_shooting <- c()
s1_array_reverse_shooting <- c()
s3_array_reverse_shooting <- c()
l = length(a1_array_forward_shooting)
x1_t = x1_array_forward_shooting[l] 
x3_t = x3_array_forward_shooting[l]

comienzo = Sys.time()
max = max(times_reverse_shooting)
t=times_reverse_shooting[1]
for(t in times_reverse_shooting){
  if((100*t/max) %in% seq(from=0, to=100, by=3)){
    print(paste(floor(100*t/max), "%", sep=""))
    #print("\n")
  }
  
  t_previous = t-stepsize
  a1_t = a1(t_previous)
  a3_t = a3(t_previous)
  s1_t = s1(t_previous)
  s3_t = s3(t_previous)
  guessmin =  0
  guessmax = x3_t
  x3_target = x3_t

  x3_t = dx3_reverse_shooting(t, guessmin, guessmax, x3_target, t_previous) 
  # x3_t = x3_t - dx3(t-stepsize)*stepsize #
  x1_t = (x1_t - dx1(t-stepsize)*stepsize)/(1+r1_stepsize)
  
  ## But then I can calulate s1, s3 again, and do another iteration.
  # for(i in c(1-10)){
  #   # using the new x3_t
  #   s3_t = s3(t_previous)
  #   x3_t = dx3_reverse_shooting(t, guessmin, guessmax, x3_target) 
  #   x3_t
  # }
  # s1_t = s1(t_previous) 
  # x1_t = (x1_t - dx1(t-stepsize)*stepsize)/(1+r_stepsize)
  
  a1_array_reverse_shooting <- c(a1_t, a1_array_reverse_shooting)
  a3_array_reverse_shooting <- c(a3_t, a3_array_reverse_shooting)
  s1_array_reverse_shooting <- c(s1_t, s1_array_reverse_shooting)
  s3_array_reverse_shooting <- c(s3_t, s3_array_reverse_shooting)
  x1_array_reverse_shooting <- c(x1_t, x1_array_reverse_shooting)
  x3_array_reverse_shooting <- c(x3_t, x3_array_reverse_shooting)
  
}
fin = Sys.time()
fin-comienzo
options(digits=7)
x1_array_reverse_shooting[1] ## 10^11
x3_array_reverse_shooting[1]


# View(x1_array_reverse_shooting)

