require("rjags")
cinco.sp  <- read.table("dados5sp.csv", header = T, sep = ',')
traits = list()
for (sp in 1:5){
    traits[[sp]]  <- cinco.sp[(60*(sp-1)):(60*sp), 1:4]
}
names(traits)  <- c("A", "B", "C", "D", "E")
n.traits = 4
n.sp = 5
n.ind = 60
data  <- list("traits" = traits, "n.traits" = n.traits, "n.sp" = n.sp, "n.ind" = n.ind)

inits <- function()
    list (theta = rnorm(J, 0, 100), mu.theta = rnorm(1, 0, 100),
          sigma.theta = runif(1, 0, 100))
parameters  <- c("theta", "mu.theta", "sigma.theta")
school.sim  <- jags.model("model.bug", data,
                    n.chains = 3, n.adapt = 10000)
update(school.sim, 10000)
samples  <- jags.samples(school.sim, parameters, 10000)
