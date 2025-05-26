library(cowplot)
library(dplyr)
library(ggplot2)
library(ggseg)
library(scales)
library(grid)
library(tidyr)
library(purrr)
library(patchwork)

ALL <- read.csv('supplementary-tables/asymmetry-epoch-area-under-curve.csv')

combined_plots <- list()
phenotypes <- c('GM', 'SA', 'CT', 'SUBC')
epochs <- unique(ALL$epoch)

plots=list()
for (pheno in phenotypes) {
  for (ep in epochs) {
    clim = max(abs(subset(ALL, phenotype==pheno)$asym_adjusted.log), na.rm=T)
    data_subset = subset(ALL, phenotype==pheno & epoch==ep)
    
    if(pheno =='SUBC'){
      p1 <- ggplot(data_subset) + 
        geom_brain(atlas = aseg, aes(fill=asym_adjusted.log), hemi='left') +
        scale_fill_gradientn(colours=c('darkblue','white','darkred'), lim=c(-clim,clim), oob=squish, guide=F) +
        theme_void(base_family='Gill Sans')
      
      p2 <- ggplot(data_subset) + 
        geom_brain(atlas = aseg, aes(fill=asym_adjusted.log), hemi='midline') +
        scale_fill_gradientn(colours=c('darkblue','white','darkred'), lim=c(-clim,clim), oob=squish, guide=F) +
        theme_void(base_family='Gill Sans')
      
      # Instead of p = p1 + p2, store p1 and p2 separately
      plots[[paste(pheno, ep, 'p1', sep='_')]] <- p1
      plots[[paste(pheno, ep, 'p2', sep='_')]] <- p2
      
    } else {
      p1 <- ggplot(data_subset) + 
        geom_brain(atlas = dk, aes(fill=asym_adjusted.log), hemi='left', side='lateral') +
        scale_fill_gradientn(colours=c('darkblue','white','darkred'), lim=c(-clim,clim), oob=squish, guide=F) +
        theme_void(base_family='Gill Sans')
      
      p2 <- ggplot(data_subset) + 
        geom_brain(atlas = dk, aes(fill=asym_adjusted.log), hemi='left', side='medial') +
        scale_fill_gradientn(colours=c('darkblue','white','darkred'), lim=c(-clim,clim), oob=squish, guide=F) +
        theme_void(base_family='Gill Sans')
      
      plots[[paste(pheno, ep, 'p1', sep='_')]] <- p1
      plots[[paste(pheno, ep, 'p2', sep='_')]] <- p2
    }
  }
}

final_plot <- plot_grid(plotlist=plots, ncol=length(epochs)*2)
ggsave(final_plot, filename ='OUT/asymmetry_AAC.png', bg='white', width = 10, height=3)


ALL.wide = ALL %>% select(asym_adjusted.log,epoch,label,phenotype) %>% tidyr::pivot_wider(names_from = epoch, values_from = asym_adjusted.log)
ALL.wide = ALL.wide[-grep('vessel',ALL.wide$label),]
ALL.wide = ALL.wide[-grep('White',ALL.wide$label),]
ALL.wide = ALL.wide[-grep('Ventricle',ALL.wide$label),]
ALL.wide = ALL.wide[-grep('Lat-Vent',ALL.wide$label),]
ALL.wide = ALL.wide[-grep('choroid',ALL.wide$label),]
ALL.wide = ALL.wide[-match('Right-Cerebellum',ALL.wide$label),]

epoch_cols <- colnames(ALL.wide)[3:ncol(ALL.wide)]  # put your actual column names here


# Step 1: Nest by phenotype
ALL.wide.nested <- ALL.wide %>%
  group_by(phenotype) %>%
  nest()

# Step 2: Compute correlation matrix for each phenotype
cor_matrices <- ALL.wide.nested %>%
  mutate(cor_matrix = map(data, ~ {
    data_mat <- .x %>%
      select(all_of(epoch_cols)) %>%
      as.data.frame()  # ensure it's not a tibble
    
    cor_mat <- cor(data_mat, use = "pairwise.complete.obs", method='spearman')
    
    # Assign proper dimnames in case they got stripped
    dimnames(cor_mat) <- list(colnames(data_mat), colnames(data_mat))
    
    cor_mat
  }))

# Step 3: Tidy the correlation matrix
cor_tidy <- cor_matrices %>%
  mutate(cor_df = map(cor_matrix, ~ {
    mat <- .x
    df_mat <- as.data.frame(as.table(mat))
    colnames(df_mat) <- c("Epoch1", "Epoch2", "Correlation")
    df_mat
  })) %>%
  select(phenotype, cor_df) %>%
  unnest(cor_df)

# Step 4: Plot using geom_tile
p5 = ggplot(cor_tidy, aes(x = Epoch1, y = Epoch2, fill = Correlation)) +
  geom_tile(color = "white") +
  scale_fill_gradientn(colors=paletteer::paletteer_d("rcartocolor::PurpOr")) +
  facet_wrap(~phenotype, nrow=1) +
  theme_minimal(base_family='Gill Sans') + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1,size = 12),
        axis.text.y = element_text(size = 12))

ggsave(filename = 'OUT/corplot.epochs.png', plot = p5,bg='white', width=15,height=5)

