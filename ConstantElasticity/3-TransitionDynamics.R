# Transition dynamics

k1 <- function(t){
  numerator = c1_forward_shooting*exp((δ-r_1)*t)
  denom1 = ((q*w_2)/(1-q))^(ρ/(1-ρ))
  denom2=exp((γ_1*ρ/(1-ρ))*t)
  denomexponent = ((1-η)/ρ)-1
  denominator = q*((q+denom1*denom2*(1-q))^denomexponent)
  result_k1 = (numerator/denominator)^(-1/η)
  return(result_k1)
}

k1_prime <- function(t){
  
  numerator = c1_forward_shooting * exp((δ-r_1)*t)
  
  denominator_part1 = ((q*w_2)/(1-q))^(ρ/(1-ρ))
  denominator_part2 = exp( ( (γ_1*ρ)/(1-ρ) )*t )*(1-q)*denominator_part1
  denominator_part3 = (q+denominator_part2)
  denominator_part4 = denominator_part3^( ( (1-η)/ ρ ) - 1)
  denominator_part5 = q*denominator_part4
  denominator = denominator_part5

  exponent_total = (-1/η)
  result_k1 = (numerator/denominator)^exponent_total
  return(result_k1)
}


k2 <- function(t){
  constant1_k2 = (w_2 * λ_2 * δ_2)/(δ-r_2)
  constant2_k2 = ((1-λ_2)/λ_2)^(δ_2*(1-λ_2))
  constant_exponent = (1/(1-δ_2))
  constant_term_k2 = (constant1_k2*constant2_k2)^constant_exponent
  exponential_growth_term_k2 = (γ_2+γ_1*δ_2*λ_2)/(1-δ_2) + γ_1
  exponential_term_k2 = exp(exponential_growth_term_k2*t)
  result_k2 = constant_term_k2*exponential_term_k2
  return(result_k2)
}

l1 <- function(t, k1_t, L_t){
  constant_term_l1 = ((q*w_2)/(1-q))^(1/(ρ-1))
  exponential_term_l1 = exp((γ_1/(ρ-1))*t)
  result_l1 = (constant_term_l1*exponential_term_l1*k1_t)/L_t
  return(result_l1)
}

l2 <- function(t, k2_t, L_t){
  constant_term_l2 = (1-λ_2)/(w_2*λ_2)
  exponential_term_l2 = exp(γ_1*t)
  result_l2 = (constant_term_l2*k2_t) / (exponential_term_l2*L_t)
  return(result_l2)
}

dL <- function(t,k2_t,L_t,l2_t){
  dynamical_term_dL= ((k2_t^λ_2)*((L_t*l2_t)^(1-λ_2)))^(δ_2)
  result_dL = r_2*L_t + β_2*exp(γ_2*t)*dynamical_term_dL
  return(result_dL)
}

wagesPaidOrEarned <- function(L_t, t, l1_t, l2_t){
  result_wages = L_t*w_2*exp(γ_1*t)*(1-l1_t-l2_t)
  return(result_wages)
}

dK <- function(t,K_t,k1_t,k2_t,L_t,l1_t,l2_t){
  result_dK = r_1*K_t - k1_t - k2_t + L_t*w_2*exp(γ_1*t)*(1-l1_t-l2_t)
  return(result_dK)
}
