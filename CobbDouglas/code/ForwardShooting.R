# Forward shooting
options(digits=7) 

## Evolution
x1_array_forward_shooting <- c()
x3_array_forward_shooting <- c()
a1_array_forward_shooting <- c()
a3_array_forward_shooting <- c()
s1_array_forward_shooting <- c()
s3_array_forward_shooting <- c()
x1_t = x1_init
x3_t = x3_init
#stepsize
comienzo = Sys.time()
max = max(times_forward_shooting)

for(t in times_forward_shooting){
  if((100*t/max) %in% seq(from=0, to=100, by=1)){
    cat(paste(floor(100*t/max), "%", sep=""))
    cat("\n")
  }
  a1_t = a1(t)
  a3_t = a3(t)
  s1_t = s1(t)
  s3_t = s3(t)
  x1_t = x1_t*(1+r1_stepsize) + dx1(t)*stepsize
  x3_t = x3_t*(1+r3_stepsize) + dx3(t)*stepsize
  
  a1_array_forward_shooting <- c(a1_array_forward_shooting, a1_t)
  a3_array_forward_shooting <- c(a3_array_forward_shooting, a3_t)
  s1_array_forward_shooting <- c(s1_array_forward_shooting, s1_t)
  s3_array_forward_shooting <- c(s3_array_forward_shooting, s3_t)
  x1_array_forward_shooting <- c(x1_array_forward_shooting, x1_t)
  x3_array_forward_shooting <- c(x3_array_forward_shooting, x3_t)
  
}
fin = Sys.time()
fin-comienzo

## Checking conditions
options(digits=22) 

l = length(times_forward_shooting)
x1_array_forward_shooting[l]
x1_growth = (x1_array_forward_shooting[l]-x1_array_forward_shooting[l-1])/x1_array_forward_shooting[l-1]/(1*stepsize) 
x1_growth
sum(x1_array_forward_shooting<0)

x3_array_forward_shooting[l]
x3_growth = (x3_array_forward_shooting[l]-x3_array_forward_shooting[l-1])/x3_array_forward_shooting[l-1]/(1*stepsize) 
x3_growth
sum(x3_array_forward_shooting<0)


a1_growth = (a1_array_forward_shooting[l]-a1_array_forward_shooting[l-1])/a1_array_forward_shooting[l-1]/stepsize
a1_growth

a3_growth = (a3_array_forward_shooting[l]-a3_array_forward_shooting[l-1])/a3_array_forward_shooting[l-1]/stepsize
a3_growth

a1_array_forward_shooting[l]/x1_array_forward_shooting[l]
plot((a1_array_forward_shooting/x1_array_forward_shooting)[(l-100)-l])

