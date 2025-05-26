library(ggplot2)
library(dplyr)
library(Redmonder)
library(ggseg)
library(ggpubr)


ALLMODELS=read.csv('supplementary-tables/asymmetry.trajectories.by.class.csv')
CLASSES=read.csv('supplementary-tables/asymmetry.classes.csv')

# Compute mean/median at each AgeTransformed per class
class_trajectories.GM.SUBC <- subset(ALLMODELS, (phenotype=='GM' | phenotype=='SUBC') & sex=='Male') %>%
  group_by(class, AgeTransformed) %>%
  summarise(
    mean_traj = mean(PRED.m500.pop, na.rm = TRUE),
    median_traj = median(PRED.m500.pop, na.rm = TRUE),
    .groups = "drop"
  )

p.GM.SUBC.traj = class_trajectories.GM.SUBC %>% 
  ggplot(aes(x = log2(exp(AgeTransformed)), y = mean_traj, colour = class)) +
  geom_hline(yintercept = 0,linetype='dashed',color='grey20')+
  geom_smooth(method = "loess", span = 0.3, size = 1.2) +
  ylab('Asymmetry')+
  scale_color_manual(values = redmonder.pal(name='qMSOPap', n=8)[5:8])+
  scale_x_continuous(expand=c(0,0),
                     breaks=log2(c(270,635,1000,6840,13055,29480)),
                     labels=as.character(c('40PCW','1y','2y','18y','35y','80y')))+
  theme_minimal(base_family = 'Gill Sans')+
  theme(legend.position='bottom',text = element_text(size=12))+
  xlab('Age (years)')+labs(color='')

p.GM.SUBC.surf.cort =  unique(subset(CLASSES, phenotype == 'GM')) %>% 
  ggplot() +
  geom_brain(atlas = dk,aes(fill = class), size=0.4, hemi='left')+
  scale_fill_manual(values = redmonder.pal(name='qMSOPap', n=8)[5:8])+
  theme_void(base_family = 'Gill Sans')+
  theme(text = element_text(size=12))+
  labs()

p.GM.SUBC.surf.subc1 =  unique(subset(CLASSES, phenotype=='SUBC')) %>% 
  ggplot() +
  geom_brain(atlas = aseg,aes(fill = class), size=0.4,hemi='left')+
  scale_fill_manual(values = redmonder.pal(name='qMSOPap', n=8)[5:8], guide=F)+
  theme_void(base_family = 'Gill Sans')+
  theme(text = element_text(size=12))+
  labs()

p.GM.SUBC.surf.subc2 =  unique(subset(CLASSES, phenotype=='SUBC')) %>% 
  ggplot() +
  geom_brain(atlas = aseg,aes(fill = class), hemi='midline')+
  scale_fill_manual(values = redmonder.pal(name='qMSOPap', n=8)[5:8], guide=F)+
  theme(text = element_text(size=12))+
  theme_void(base_family = 'Gill Sans')

ggsave(ggarrange(p.GM.SUBC.surf.cort,
                 p.GM.SUBC.traj,
                 ggarrange(p.GM.SUBC.surf.subc1, p.GM.SUBC.surf.subc2, nrow=1), 
                 heights=c(1,2.5,1.5),ncol=1, common.legend = T, legend='bottom'),
       filename = 'OUT/asym.class.GM.SUBC.png', bg='white',height=6,width =4)