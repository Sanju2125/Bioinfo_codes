# Load necessary libraries
library(ape)
library(ggplot2)

# Read your phylogenetic tree from a file
tree <- read.tree("D:/Documents/DUR3 Final/12. Edited_Trees/with BS/Tree.nwk")

# Fit the Birth-Death model
bd_model <- birthdeath(tree)

# Extract the speciation and extinction rates, and relative extinction rate
lambda <- bd_model$para[1]  # Speciation rate
mu <- bd_model$para[2]      # Extinction rate
relative_extinction_rate <- mu / lambda  # Relative extinction rate

# Print the results
cat("Speciation rate (lambda):", lambda, "\n")
cat("Extinction rate (mu):", mu, "\n")
cat("Relative extinction rate (mu / lambda):", relative_extinction_rate, "\n")

# Create a data frame with the calculated rates
rates_df <- data.frame(
  RateType = c("Speciation", "Extinction", "Relative Extinction"),
  Value = c(lambda, mu, relative_extinction_rate)
)

# Point plot with distinct colors and shapes for each rate type
ggplot(rates_df, aes(x = RateType, y = Value, color = RateType, shape = RateType)) +
  geom_point(size = 5) +
  theme_minimal() +
  labs(
    title = "Point Plot of Speciation, Extinction, and Relative Extinction Rates",
    x = "Rate Type",
    y = "Rate"
  ) +
  scale_color_manual(values = c("Speciation" = "steelblue", 
                                "Extinction" = "firebrick", 
                                "Relative Extinction" = "darkgreen")) +
  scale_shape_manual(values = c("Speciation" = 16,  
                                "Extinction" = 15, 
                                "Relative Extinction" = 17)) +
  theme(legend.position = "none")




