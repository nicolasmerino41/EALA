# Install and load required packages
# install.packages("bipartite")
library(bipartite)

# Load the Safariland dataset
data(Safariland)
network <- Safariland

# Visualize the pollination network
plotweb(network, method = "normal", text.rot = 90)

# Calculate initial network metrics
initial_metrics <- networklevel(network, index = c("connectance", "nestedness", "modularity"))
print(initial_metrics)

# Identify the most connected pollinator species
degree_pollinators <- colSums(network > 0)
key_pollinator <- names(sort(degree_pollinators, decreasing = TRUE))[1]

# Simulate targeted species loss (remove key pollinator)
network_targeted <- network
network_targeted[, key_pollinator] <- 0

# Recalculate network metrics after targeted removal
targeted_metrics <- networklevel(network_targeted, index = c("connectance", "nestedness", "modularity"))
print(targeted_metrics)

# Simulate random species loss
set.seed(42)
random_pollinators <- sample(colnames(network), 5)
network_random <- network
network_random[, random_pollinators] <- 0

# Recalculate network metrics after random removal
random_metrics <- networklevel(network_random, index = c("connectance", "nestedness", "modularity"))
print(random_metrics)

# Compare metrics
comparison <- rbind(
  Initial = initial_metrics,
  Targeted_Removal = targeted_metrics,
  Random_Removal = random_metrics
)
print(comparison)
