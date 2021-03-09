# ========================================================== #
#                      scenario1                             #
# ========================================================== #
# Description: 

## Variables
η = 1.1
ρ = -0.5
δ = 0.005
r_1 = 0.06
r_2 = -0.02
### r_1_paper = 0.06 ## yearly
### r_1 = 1+log(1+r_1_paper) ## instantaneous
### r_2_paper = -0.02 ## yearly
### r_2 = 1+log(1+r_2_paper) ## instantaneous
γ_1 = 0.03
γ_2 = 0.01
w_2 = 5000 
β_2 = 1 
λ_1 = 0.5
λ_2 = 0.5
δ_2 = 0.44
q=0.5

## Initial conditions. Correspond to "year 0". 
K_init = 10^13
L_init = 10^4 

## Integration constant
c1_forward_shooting = 10^(-8) # 10^10 ## 2*10^(-6)

## Stepsize
stepsize = 0.1
r1_stepsize = ((1+r_1)^stepsize)-1 
r2_stepsize = ((1+r_2)^stepsize)-1 

## Notes time it takes to run the simulations
### stepsize = 0.1 => seconds (7s). 
### stepsize = 0.01 => minutes (3 mins).

## Knife-edge constant
knife_edge_constant = (γ_1/(ρ-1)) + ((r_1 - δ)/η) + max(0,(γ_1*(1-η-ρ)/(η*(ρ-1)))) - max(r_2,(γ_2+γ_1*δ_2*λ_2)/(1-δ_2))

## Interval
first = 0
last = 1000
times_forward_shooting = seq(from=first, to=last, by=stepsize)
times_reverse_shooting = seq(from=last, to=first, by=-stepsize)

# ========================================================== #
#                      scenario2                             #
# ========================================================== #
# Description: Knife edge constant = 0

## Variables
η = 1.1
ρ = -0.5
### δ = 0.005
r_1 = 0.06
r_2 = -0.02
### r_1_paper = 0.06 ## yearly
### r_1 = 1+log(1+r_1_paper) ## instantaneous
### r_2_paper = -0.02 ## yearly
### r_2 = 1+log(1+r_2_paper) ## instantaneous
γ_1 = 0.03
γ_2 = 0.01
w_2 = 5000 
β_2 = 1 
λ_1 = 0.5
λ_2 = 0.5
δ_2 = 0.44
q=0.5
δ  = r_1 + η*( (γ_1/(ρ-1)) + max(0,(γ_1*(1-η-ρ)/(η*(ρ-1)))) - max(r_2,(γ_2+γ_1*δ_2*λ_2)/(1-δ_2)) )

## Initial conditions. Correspond to "year 0". 
K_init = 10^13 ## 10^13 to afford movement building. 10^14 to have a reasonable amount of direct investment as well. This is close to the net discounted value of US GDP.
L_init = 10^4 

## Integration constant
c1_forward_shooting = 10^(-8) # 10^10 ## 2*10^(-6)

## Stepsize
stepsize = 0.1
r1_stepsize = ((1+r_1)^stepsize)-1 
r2_stepsize = ((1+r_2)^stepsize)-1 

## Notes time it takes to run the simulations
### stepsize = 0.1 => seconds (7s). 
### stepsize = 0.01 => minutes (3 mins).

## Knife-edge constant
knife_edge_constant = (γ_1/(ρ-1)) + ((r_1 - δ)/η) + max(0,(γ_1*(1-η-ρ)/(η*(ρ-1)))) - max(r_2,(γ_2+γ_1*δ_2*λ_2)/(1-δ_2))

## Interval
first = 0
last = 1000
times_forward_shooting = seq(from=first, to=last, by=stepsize)
times_reverse_shooting = seq(from=last, to=first, by=-stepsize)


# ========================================================== #
#                      scenario3                             #
# ========================================================== #
# Description: Knife edge constant < 0

## Variables
η = 1.1
ρ = -0.5
δ = 0.00578572
r_1 = 0.06
r_2 = -0.02
### r_1_paper = 0.06 ## yearly
### r_1 = 1+log(1+r_1_paper) ## instantaneous
### r_2_paper = -0.02 ## yearly
### r_2 = 1+log(1+r_2_paper) ## instantaneous
γ_1 = 0.03
γ_2 = 0.01
w_2 = 5000 
β_2 = 1 
λ_1 = 0.5
λ_2 = 0.5
δ_2 = 0.44
q=0.5

## Initial conditions. Correspond to "year 0". 
K_init = 10^13 ## 10^13 to afford movement building. 10^14 to have a reasonable amount of direct investment as well. This is close to the net discounted value of US GDP.
L_init = 10^4 

## Integration constant
c1_forward_shooting = 10^(-8) # 10^10 ## 2*10^(-6)

## Stepsize
stepsize = 0.1
r1_stepsize = ((1+r_1)^stepsize)-1 
r2_stepsize = ((1+r_2)^stepsize)-1 

## Notes time it takes to run the simulations
### stepsize = 0.1 => seconds (7s). 
### stepsize = 0.01 => minutes (3 mins).

## Knife-edge constant
knife_edge_constant = (γ_1/(ρ-1)) + ((r_1 - δ)/η) + max(0,(γ_1*(1-η-ρ)/(η*(ρ-1)))) - max(r_2,(γ_2+γ_1*δ_2*λ_2)/(1-δ_2))
knife_edge_constant
## Interval
first = 0
last = 1000
times_forward_shooting = seq(from=first, to=last, by=stepsize)
times_reverse_shooting = seq(from=last, to=first, by=-stepsize)

# ========================================================== #
#                     scenarios 4 to 14                      #
# ========================================================== #

δ_array = seq(from=0.0044, to=0.0064, by=0.0002)
δ = δ_array[1]
δ = δ_array[2]
δ = δ_array[3]
δ = δ_array[4]
δ = δ_array[5]
δ = δ_array[6]
δ = δ_array[7]
δ = δ_array[8]
δ = δ_array[9]
δ = δ_array[10]
δ = δ_array[11]

knife_edge_constant = (γ_1/(ρ-1)) + ((r_1 - δ)/η) + max(0,(γ_1*(1-η-ρ)/(η*(ρ-1)))) - max(r_2,(γ_2+γ_1*δ_2*λ_2)/(1-δ_2))
