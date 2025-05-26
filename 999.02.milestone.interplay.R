library(ggplot2)
library(dplyr)
library(paletteer)
library(ggseg)

peakages = read.csv('supplementary-tables/milestones.csv')
cortical.regions = unique(gsub('rh_','',gsub('lh_','',subset(peakages, phenotype=='GM')$label)))
subccortical.regions = unique(gsub('Left-','',gsub('Right-','',subset(peakages, phenotype=='SUBC')$label)))

peakages.RGB = peakages %>% 
  group_by(phenotype) %>%
  mutate(peak.scaled = (pop.mean - min(pop.mean,na.rm=T)) / (max(pop.mean,na.rm=T) - min(pop.mean,na.rm=T)),
         growth.scaled = (peak.growth - min(peak.growth,na.rm=T)) / (max(peak.growth,na.rm=T) - min(peak.growth,na.rm=T)),
         decline.scaled = (peak.decline - min(peak.decline,na.rm=T)) / (max(peak.decline,na.rm=T) - min(peak.decline,na.rm=T)))

color_grid <- expand.grid(
  growth = seq(0, 1, length.out = 100),  # growth.scaled -> Cyan (C)
  decline = seq(0, 1, length.out = 100) # decline.scaled -> Magenta (M)
) %>%
  mutate(
    C = growth,            # Cyan from growth.scaled
    M = decline,           # Magenta from decline.scaled
    Y = 0,                 # Optional: Yellow not used here
    K = 0,                 # Optional: Black not used here
    R = (1 - C) * (1 - K), # Convert CMYK to RGB
    G = (1 - M) * (1 - K),
    B = (1 - Y) * (1 - K),
    color = rgb(R, G, B)
  )

# Prepare scatter data with CMYK
peakages.RGB <- peakages.RGB %>%
  mutate(
    C = growth.scaled,     # Cyan from growth.scaled
    M = decline.scaled,    # Magenta from decline.scaled
    Y = 0,                 # Optional: Yellow not used here
    K = 0,                 # Optional: Black not used here
    R = (1 - C) * (1 - K),
    G = (1 - M) * (1 - K),
    B = (1 - Y) * (1 - K),
    color = rgb(R, G, B)
  )

p4a = subset(peakages.RGB, phenotype=='GM') %>% ggplot() +
  geom_brain(atlas = dk, 
             aes(fill = color),
             position = position_brain(side ~ hemi ))+
  scale_fill_identity()+
  theme_void(base_family = 'Gill Sans')+
  theme(legend.position = 'bottom')+
  ggtitle('Grey matter volume')

p4b = subset(peakages.RGB, phenotype=='SUBC') %>% ggplot() +
  geom_brain(atlas = aseg, 
             aes(fill = color))+
  scale_fill_identity()+
  theme_void(base_family = 'Gill Sans')+
  theme(legend.position = 'bottom')+
  ggtitle('Grey matter volume')

# Plot the combined color grid and scatter points
p5 = ggplot() +
  # Add the 2D CMYK color grid
  geom_tile(data = color_grid, aes(x = growth, y = decline, fill = color)) +
  scale_fill_identity() + # Use the precomputed CMYK-based RGB colors
  
  # Overlay the scatter points
  geom_point(data = peakages.RGB, aes(x = growth.scaled, y = decline.scaled, shape=phenotype, color=pop.mean,group=label), size = 5) +
  scale_color_gradientn(colors=rev(paletteer_d("RColorBrewer::Greys")[c(3:8)]))+
  labs(
    title = "Interplay of Growth and Decline",
    x = "Growth Scaled",
    y = "Decline Scaled",
    color='Age at peak GM',
    shape='Phenotype'
  ) +
  theme_minimal()
