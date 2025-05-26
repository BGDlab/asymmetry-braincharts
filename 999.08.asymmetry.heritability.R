

ALL.H2 = read.csv('supplementary-tables/asymmetry.heritability.csv')
p1=subset(ALL.H2, phenotype!='SUBC') %>% 
  group_by(phenotype)  %>% 
  ggplot() + 
  geom_brain(atlas=dk,aes(fill=h2*100), hemi='left')+
  facet_grid(. ~ phenotype)+
  scale_fill_gradientn(colours=rev(paletteer::paletteer_d("RColorBrewer::YlOrRd")),limits=c(0,10), breaks=c(0,10))+
  #scale_fill_gradientn(colours=rev(paletteer::paletteer_d("beyonce::X41")),limits=c(0,0.3), breaks=c(0,0.3))+
  theme_void()

p2=subset(ALL.H2, phenotype=='SUBC') %>% 
  group_by(phenotype)  %>% 
  ggplot() + 
  geom_brain(atlas=aseg,aes(fill=h2*100))+
  facet_grid(. ~ phenotype)+
  scale_fill_gradientn(colours=rev(paletteer::paletteer_d("RColorBrewer::YlOrRd")),limits=c(0,10), breaks=c(0,10))+
  # scale_fill_gradientn(colours=rev(paletteer::paletteer_d("beyonce::X41")),limits=c(0,0.3), breaks=c(0,0.3), oob=squish)+
  theme_void()

ggsave(ggarrange(p1,p2, widths=c(3,1), common.legend = T, legend = 'bottom'), 
       filename='OUT/heritability.v2.png', bg='white')


