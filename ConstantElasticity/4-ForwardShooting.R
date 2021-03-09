# Forward shooting
options(digits=22)
## Options

## Definitions
K_t = K_init
L_t = L_init
max = max(times_forward_shooting)
l =length(times_forward_shooting)

## Initialization
pb <- txtProgressBar(min = 1, max = l, style = 3)
K_array_forward_shooting <- vector(mode ="numeric", length=l)
L_array_forward_shooting <- vector(mode ="numeric", length=l)
k1_array_forward_shooting <- vector(mode ="numeric", length=l)
k2_array_forward_shooting <- vector(mode ="numeric", length=l)
l1_array_forward_shooting <- vector(mode ="numeric", length=l)
l2_array_forward_shooting <- vector(mode ="numeric", length=l)
wages_array_forward_shooting <- vector(mode ="numeric", length=l)

## Calculations
comienzo = Sys.time()
i=1
for(i in c(1:l)){
  t = times_forward_shooting[i]

  k1_t = k1(t)
  k2_t = k2(t)
  l1_t = l1(t, k1_t, L_t)
  l2_t = l2(t, k2_t, L_t)
  wages_t = wagesPaidOrEarned(L_t, t, l1_t, l2_t)
  L_t = L_t + dL(t,k2_t,L_t,l2_t)*stepsize
  K_t = K_t + dK(t,K_t,k1_t,k2_t,L_t,l1_t,l2_t)*stepsize
  
  ## print(c(k1_t, k2_t, l1_t, l2_t, L_t, K_t))
  ## if(i %% 100 == 0){
  ##  print(c(i, k2_t))
  ##  Sys.sleep(1)
  ## }
  k1_array_forward_shooting[i] <- k1_t 
  k2_array_forward_shooting[i] <- k2_t
  wages_array_forward_shooting[i] <- wages_t
  l1_array_forward_shooting[i] <- l1_t
  l2_array_forward_shooting[i] <- l2_t
  K_array_forward_shooting[i] <- K_t
  L_array_forward_shooting[i] <- L_t
  setTxtProgressBar(pb, i)
  # i = i+1
}
fin = Sys.time()
timetaken = fin-comienzo
timetaken

## Checking condition
### options(digits=22) 
### sink("/dev/null")

### Shouldn't be negative
K_array_forward_shooting[l]
K_growth = (K_array_forward_shooting[l]-K_array_forward_shooting[l-1])/K_array_forward_shooting[l-1]/(1*stepsize) 
K_growth
sum(K_array_forward_shooting<0)

L_array_forward_shooting[l]
L_growth = (L_array_forward_shooting[l]-L_array_forward_shooting[l-1])/L_array_forward_shooting[l-1]/(1*stepsize)
L_growth
sum(L_array_forward_shooting<0)

### Should be similar growth as in the model
k1_growth = (k1_array_forward_shooting[l]-k1_array_forward_shooting[l-1])/k1_array_forward_shooting[l-1]/stepsize
k1_growth

k2_array_forward_shooting[l]
k2_growth = (k2_array_forward_shooting[l]-k2_array_forward_shooting[l-1])/k2_array_forward_shooting[l-1]/stepsize
k2_growth

k1_array_forward_shooting[l]
k1_array_forward_shooting[l]/K_array_forward_shooting[l]
plot((k1_array_forward_shooting/K_array_forward_shooting)[(l-100):l])
## sink()

l2_array_forward_shooting[l/2]

## Plotting (useful for back-and-forth plotting, but redundant with Plotting.R)
K_array_plotting <- K_array_forward_shooting
L_array_plotting <- L_array_forward_shooting
k1_array_plotting <- k1_array_forward_shooting
k2_array_plotting <- k2_array_forward_shooting
l1_array_plotting <- l1_array_forward_shooting
l2_array_plotting <- l2_array_forward_shooting
times <- times_forward_shooting 

## Knife edge study old

if(knife_edge_constant>0){
  knife_edge_constant_above = knife_edge_constant
  K_above_knife_edge <- K_array_forward_shooting
  L_above_knife_edge <- L_array_forward_shooting
  k1_above_knife_edge <- k1_array_forward_shooting
  k2_above_knife_edge <- k2_array_forward_shooting
  wages_above_knife_edge <- wages_array_forward_shooting
  l1_above_knife_edge <- l1_array_forward_shooting
  l2_above_knife_edge <- l2_array_forward_shooting
  l3_above_knife_edge <- 1- l1_array_forward_shooting - l2_array_forward_shooting
}

if(knife_edge_constant == 0){
  knife_edge_constant_0 = knife_edge_constant ## 0
  K_at_knife_edge <- K_array_forward_shooting
  L_at_knife_edge <- L_array_forward_shooting
  k1_at_knife_edge <- k1_array_forward_shooting
  k2_at_knife_edge <- k2_array_forward_shooting
  wages_at_knife_edge <- wages_array_forward_shooting
  l1_at_knife_edge <- l1_array_forward_shooting
  l2_at_knife_edge <- l2_array_forward_shooting
  l3_at_knife_edge <- 1- l1_array_forward_shooting - l2_array_forward_shooting
}

if(knife_edge_constant <0){
  knife_edge_constant_below = knife_edge_constant
  K_below_knife_edge <- K_array_forward_shooting
  L_below_knife_edge <- L_array_forward_shooting
  k1_below_knife_edge <- k1_array_forward_shooting
  k2_below_knife_edge <- k2_array_forward_shooting
  wages_below_knife_edge <- wages_array_forward_shooting
  l1_below_knife_edge <- l1_array_forward_shooting
  l2_below_knife_edge <- l2_array_forward_shooting
  l3_below_knife_edge <- 1- l1_array_forward_shooting - l2_array_forward_shooting
  
}

## knife edge study
times_array <- c(times_array,times)
knife_edge_constant_array <- c(knife_edge_constant_array, rep(knife_edge_constant, length(times)))
K_knife_edge <- c(K_knife_edge,K_array_forward_shooting)
L_knife_edge <- c(L_knife_edge,L_array_forward_shooting)
k1_knife_edge <- c(k1_knife_edge,k1_array_forward_shooting)
k2_knife_edge <- c(k2_knife_edge,k2_array_forward_shooting)
wages_knife_edge <- c(wages_knife_edge,wages_array_forward_shooting)
l1_knife_edge <- c(l1_knife_edge,l1_array_forward_shooting)
l2_knife_edge <- c(l2_knife_edge,l2_array_forward_shooting)
l3_knife_edge <- c(l3_knife_edge,1- l1_array_forward_shooting - l2_array_forward_shooting)

## For convenience
K_array_forward_shooting[l]
