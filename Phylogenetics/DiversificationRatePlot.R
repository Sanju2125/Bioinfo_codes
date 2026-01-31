# Load necessary package
library(ape)

# Load your phylogenetic tree dataset from a Nexus file
tree <- read.nexus("D:/Documents/DUR3 Final/12. Edited_Trees/with BS/NewTree.nex")

# Check if the tree is of class 'phylo' or 'multiPhylo'
if (inherits(tree, "phylo") || inherits(tree, "multiPhylo")) {
  
  # For multiPhylo, process each tree in the list
  if (inherits(tree, "multiPhylo")) {
    branching_times <- lapply(tree, branching.times)
  } else {
    # For a single phylo object, directly calculate branching times
    branching_times <- branching.times(tree)
  }
  
  # Print branching times to verify
  print("Branching times for the tree:")
  print(branching_times)
  
  # Assuming 'branching_times' is a list, convert it to a numeric vector
  branching_times_vector <- unlist(branching_times)
  
  # Check the structure and class of the 'branching_times_vector' to ensure it's numeric
  str(branching_times_vector)
  class(branching_times_vector)
  
  # Run the diversi.time function to estimate diversification rates
  result <- tryCatch({
    diversi.time(branching_times_vector)
  }, error = function(e) {
    cat("Error in diversi.time function:", e$message, "\n")
    NULL
  })
  
  if (!is.null(result)) {
    # Plot the diversification rate over time
    plot(result, main = "Diversification Rate Over Time", xlab = "Time", ylab = "Diversification Rate")
  }
  
} else {
  stop("The tree is not of class 'phylo' or 'multiPhylo'. Please check your input tree.")
}

# Adjusting margins and opening a new graphical window if needed
par(mar = c(5, 5, 2, 2))  # Adjust plot margins

# Generate the time vector
time_vector <- seq(from = 0, to = max(branching_times_vector), by = 0.1)

# Calculate diversification rates for each model
rate_A <- rep(0.200774, length(time_vector))
rate_B <- 0.201237 * time_vector^(0.995412 - 1)
rate_C <- ifelse(time_vector <= 3, 0.215465, 0.188982)

# Plot the diversification rates
plot(time_vector, rate_A, type = "l", col = "red", xlab = "Time", ylab = "Diversification Rate", main = "Diversification Rate Models")
lines(time_vector, rate_B, col = "blue")
lines(time_vector, rate_C, col = "green")
legend("topright", legend = c("Model A", "Model B", "Model C"), col = c("red", "blue", "green"), lty = 1)

