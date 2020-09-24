# Transition dynamics
# install.packages("pracma")
library(pracma)

## For forward shooting
a1 <- function(t){
  term_a1 = λ_1 * 
    ((1- λ_1)/( λ_1 * w_3 * exp(γ_1 * t)))^((1-λ_1) * (1-η)) /
    (k1_forward_shooting * exp((ρ-r_1) * t))
  result_a1 = term_a1^(1/η)
  return(result_a1)
}

a3 <- function(t){
  first_term_a3 = w_3 * exp(γ_1 * t) * δ_3 * λ_3 *
    β_3 * exp(γ_3 * t) / (r_1 - γ_1 - r_3)
  second_term_a3 = (1-λ_3)/(λ_3 * w_3 * exp(γ_1 * t))
  subresult_a3 = first_term_a3 * (second_term_a3^(δ_3*(1-λ_3)))
  result_a3 = subresult_a3^(1/(1-δ_3))
  return(result_a3)
}

s1 <- function(t){
  result_s1 = ((1-λ_1)/ λ_1) * (a1_t / (x3_t * w_3 * exp(γ_1 * t)))
  return(result_s1)
}

s3 <- function(t){
  result_s3 = ((1-λ_3)/ λ_3) * (a3_t / (x3_t * w_3 * exp(γ_1 * t)))
  return(result_s3)
}

dx1 <- function(t){
  result_x1 = - a1_t - a3_t + x3_t * w_3 * exp(γ_1 * t) * (1-s1_t - s3_t)
  return(result_x1)
}
dx3 <- function(t){
  result_x3 = β_3 * exp(γ_3 * t) * (a3(t)^λ_3 * (s3_t*x3_t)^(1-λ_3))^δ_3
  return(result_x3)
}

dx3_reverse_shooting <- function(t, guessmin, guessmax, x3_target, t_previous){
  ## Inverting dx3 turns out to be a little bit involved. 
  check_hypothesis <- function(x3_hypothesis){
    dx3_hypothesis = β_3 * exp(γ_3 * t_previous) * (a3(t_previous)^λ_3 * (s3_t*x3_hypothesis)^(1-λ_3))^δ_3
    difference = x3_target - (x3_hypothesis + dx3_hypothesis*stepsize)
    return(difference)
  }
  x3_best_guess <- bisect(check_hypothesis, guessmin, guessmax)$root
  #uniroot(check_hypothesis, lower=guessmin, upper=guessmax, tol = 10^(-22))[[1]]
   # x3_best_guess <- uniroot(check_hypothesis, lower=(x3_target-2), upper=(x3_target), tol = 10^(-22), extendInt = "down")[[1]]
  ## x3_best_guess <- uniroot(check_hypothesis, c(0, x3_target), tol = 10^(-22), a = 0, extendInt = "upX")[[1]]
  return(x3_best_guess)
}

