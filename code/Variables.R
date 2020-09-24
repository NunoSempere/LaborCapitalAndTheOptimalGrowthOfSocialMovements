# Variables
η = 0.9 ## 1.1
ρ = 0.005
r_1 = 0.06
r_3 = -0.02
γ_1 = 0.03
γ_3 = 0.01
w_3 = 5000 ## Mean on the EA Survey 2018: ~7000
β_3 = 1 ## 1 ## 0.5 Corresponds to roughly 5 people convincing 10 other people per year on a 50k year budget
  ## Dramatic if beta = 0.5, w_3 = 1000
λ_1 = 0.5
λ_3 = 0.5
δ_3 = 0.44

## k1_forward_shooting
k1_forward_shooting = 3*10^(-7) 
  ## 1*10^(-7) fails. 2*10^(-7) fails
  ## Artfully guessed.
k1_reverse_shooting = k1_forward_shooting


stepsize = 0.1
  ## stepsize = 0.1 => seconds (7s). 
  ## stepsize = 0.01 => minutes (3 mins).
r1_stepsize = ((1+r_1)^stepsize)-1
r3_stepsize = ((1+r_3)^stepsize)-1

first = 0
last = 1000
times_forward_shooting = seq(from=first, to=last, by=stepsize)
times_reverse_shooting = seq(from=last, to=first, by=-stepsize)

### Initial conditions. Correspond to "year 0". 
x1_init = 10^10
x3_init = 10^5

