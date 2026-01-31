# Load necessary libraries
library(ggplot2)
library(ape)
library(tidyr)
library(ggtree)
library(dplyr)
library(ggrepel)

# Load your LTT data
ltt_data <- data.frame(
  Time = c(0, 10, 20, 30, 40, 50),  # time points
  Lineage_Count = c(1, 2, 4, 6, 8, 9)  # lineage count
)

# Define evolutionary events
events <- data.frame(
  time_mya = c(4500, 3800, 3500, 2400, 1800, 1200, 850, 541, 500, 475, 400, 250, 150, 65, 10, 0.01),
  description = c("Formation of Earth", "Origin of life (Prokaryotes)", "First photosynthesis",
                  "Great Oxygenation Event", "Emergence of eukaryotes", "Evolution of multicellularity",
                  "Evolution of Chlorophyta", "Cambrian Explosion", "First fungi", "Evolution of land plants",
                  "Radiation of rotifers", "Diversification of Chromista", "Evolution of angiosperms",
                  "Rise of mammals", "Modern coral reef development", "Rise of modern humans"),
  kingdoms = c("No life", "Archaea, Bacteria", "Bacteria", "Archaea, Bacteria, Protists", 
               "Protists, Fungi, Plantae, Animalia", "Fungi, Protists, Plantae, Animalia", 
               "Chlorophyta, Protists", "Animalia", "Fungi", "Plantae", "Rotifers", "Chromista", 
               "Plantae", "Animalia", "Chromista, Animalia", "Animalia"),
  # Event category 
  event_category = c("Formation", "Life", "Photosynthesis", "Oxygenation", "Eukaryotes",
                     "Multicellularity", "Chlorophyta", "Explosion", "Fungi", "Plants",
                     "Radiation", "Diversification", "Angiosperms", "Mammals", "Reef", "Humans")
)

# Create a custom color palette for event categories
event_colors <- c(
  "Formation" = "darkgrey",
  "Life" = "green",
  "Photosynthesis" = "blue",
  "Oxygenation" = "cyan",
  "Eukaryotes" = "purple",
  "Multicellularity" = "orange",
  "Chlorophyta" = "lightgreen",
  "Explosion" = "red",
  "Fungi" = "maroon",
  "Plants" = "forestgreen",
  "Radiation" = "darkorange",
  "Diversification" = "pink",
  "Angiosperms" = "lightblue",
  "Mammals" = "hotpink",
  "Reef" = "turquoise",
  "Humans" = "yellow"
)

# Create LTT plot with distinct colors
p1 <- ggplot(ltt_data, aes(x = Time, y = Lineage_Count)) +
  geom_line(size = 1.2, color = "steelblue") +  # Thicker line for lineage
  geom_point(size = 3, color = "darkblue") +    # Larger points for emphasis
  labs(title = "Lineage Through Time (LTT) Plot", x = "Time (Mya)", y = "Lineage Count") +
  theme_minimal() +
  expand_limits(y = max(ltt_data$Lineage_Count) + 15) 

# evolutionary events visualization with colors
p2 <- p1 +
  geom_vline(data = events, aes(xintercept = time_mya, color = event_category), 
             alpha = 0.7, linetype = "dashed", size = 0.8) +  # Color by event category
  geom_label_repel(
    data = events, 
    aes(x = time_mya, y = max(ltt_data$Lineage_Count) + 5, label = description, fill = event_category),
    size = 3,
    box.padding = 1.5,       # Adjust space around labels
    point.padding = 0.4,     # Adjust space between label and point
    segment.color = "grey50",
    segment.size = 0.4,      # Thinner line between point and label
    nudge_y = 2,             # Fine-tune vertical position
    nudge_x = 0,             # Fine-tune horizontal position
    direction = "y",         # Separate labels vertically
    angle = 90, 
    vjust = 0.9,
    max.overlaps = 100       # Increased to allow more overlapping labels
  ) +
  scale_color_manual(values = event_colors) +    # Use custom colors for lines
  scale_fill_manual(values = event_colors) +     # Use custom colors for labels
  labs(title = "LTT Plot with Evolutionary Events") +
  guides(color = "none", fill = "none")  # Remove the legend for color

# Save the plot to PDF
ggsave("LTT_with_evolutionary_events.pdf", plot = p2, width = 20, height = 8)
