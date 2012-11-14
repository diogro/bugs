require("rjags")
schools  <- read.table("schools.dat", header = T)
J  <- nrow(schools)
y  <- schools$estimate
sigma.y  <- schools$sd
data  <- list("J" = J, "y" = y, "sigma.y" = sigma.y)
inits <- function()
    list (theta = rnorm(J, 0, 100), mu.theta = rnorm(1, 0, 100),
          sigma.theta = runif(1, 0, 100))
parameters  <- c("theta", "mu.theta", "sigma.theta")
school.sim  <- jags.model("model.bug", data,
                    n.chains = 3, n.adapt = 10000)
update(school.sim, 10000)
samples  <- jags.samples(school.sim, parameters, 10000)
