## README

## About 
This is some R code for the paper [Labor, Capital, and the Optimal Growth ofSocial Movements](https://nunosempere.github.io/ea/MovementBuildingForUtilityMaximizers.pdf)

## Structure of the code.

1. `Variables.R`: Contains variables
2. `Transition dynamics.R`: If we know our system at time t, generate an approximation of our system at time t+stepsize. 
3. `Forward Shooting.R`: Carries out the forward shooting. 
4. `ReverseShooting.R`: Nonfunctional. Ignore. 
5. `Plotting.R`: Generates graphs of the results

## How to run

Open files 1.,2.,3., and 5. in an IDE for R, like RStudio. Run them in order. For `Plotting.R`, add or create the directory in which you want the graphs to be generated, making sure it has suitable permissions. 

## Gotchas
Using a very small stepsize runs into floating point errors. Consider a stylized example:

```r
options(digits=22)

dx <- 10^43
numsteps <- 10^7
stepsize <- 10^(-3) 

## Example 1
x <- pi*1e+60
print(x)
for(i in c(1:numsteps)){
  x <- x+dx*stepsize
}
x == pi*1e+60
print(x)

## Example 2
x <- pi*1e+60 + numsteps*stepsize*dx
x == pi*1e+60
print(x)

```

The two examples should give the same results, but don't. 
