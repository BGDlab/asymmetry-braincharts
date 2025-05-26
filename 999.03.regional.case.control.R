library(dplyr)
library(ggplot2)
library(paletteer)
library(tidyr)

ALL=read.csv('supplementary-tables/regional.case.control.csv')
conditions=c('ASD','SCZ','AD')
ALL = ALL[ALL$dx %in% conditions,]
ALL$dx = factor(ALL$dx, levels=conditions)

p1=subset(ALL, phenotype!='SUBC') %>% 
  group_by(phenotype,dx)  %>% 
  ggplot() + 
  geom_brain(atlas=dk,aes(fill=-cohensD))+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('darkblue','white','darkred'), limits=c(-0.5,0.5),breaks=c(-0.5,0.5), oob=squish)+
  theme_void()

p2=subset(ALL, phenotype=='SUBC') %>% 
  group_by(phenotype,dx)  %>% 
  ggplot() + 
  geom_brain(atlas=aseg,aes(fill=-cohensD))+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('darkblue','white','darkred'), limits=c(-0.5,0.5),breaks=c(-0.5,0.5), oob=squish)+
  theme_void()

ggsave(ggarrange(p1,p2, nrow=2, common.legend = T, legend = 'bottom'), 
       filename='OUT/all.regional.case.control.png', bg='white')



