library(dplyr)
library(ggseg)
library(tidyr)
library(ggpubr)
library(scales)

dx.All = read.csv(file = 'supplementary-tables/asymmetry.case.control.csv')

p1=na.omit(subset(dx.All, phenotype!='SUBC')[!is.na(match(dx.All$Group2,c('AD','ASD','SCZ','MCI'))),]) %>% 
  group_by(Group2,phenotype)  %>% 
  ggplot() + 
  geom_brain(atlas=dk,aes(fill=cohensD), hemi='left')+
  facet_grid(phenotype~Group2)+
  scale_fill_gradientn(colours=c('darkblue','white','darkred'),limits=c(-0.3,0.3), breaks=c(-0.3,0.3))+
  theme_void()

p2=na.omit(subset(dx.All, phenotype=='SUBC')[!is.na(match(dx.All$Group2,c('AD','ASD','SCZ','MCI'))),]) %>% 
  group_by(Group2,phenotype)  %>% 
  ggplot() + 
  geom_brain(atlas=aseg,aes(fill=cohensD))+
  facet_grid( phenotype ~ Group2)+
  scale_fill_gradientn(colours=c('darkblue','white','darkred'),limits=c(-0.3,0.3), breaks=c(-0.3,0.3))+
  theme_void()

ggsave(ggarrange(p1,p2, ncol=1, common.legend = T), file='OUT/all.asym.case.control.png', bg='white')

p3=na.omit(subset(dx.All, phenotype!='SUBC')[!is.na(match(dx.All$Group2,c('AD','ASD','SCZ','MCI'))),]) %>% 
  group_by(Group2,phenotype)  %>% 
  ggplot() + 
  geom_brain(atlas=dk,aes(fill=ifelse(pFDR.roi<0.05,cohensD,NA)), hemi='left')+
  facet_grid(phenotype~Group2)+
  scale_fill_gradientn(colours=c('darkblue','white','darkred'),limits=c(-0.3,0.3), breaks=c(-0.3,0.3))+
  theme_void()+labs(fill="Cohen's D")

p4=na.omit(subset(dx.All, phenotype=='SUBC')[!is.na(match(dx.All$Group2,c('AD','ASD','SCZ','MCI'))),]) %>% 
  group_by(Group2,phenotype)  %>% 
  ggplot() + 
  geom_brain(atlas=aseg,aes(fill=ifelse(pFDR.roi<0.05,cohensD,NA)))+
  facet_grid( phenotype ~ Group2)+
  scale_fill_gradientn(colours=c('darkblue','white','darkred'),limits=c(-0.3,0.3), breaks=c(-0.3,0.3))+
  theme_void()+labs(fill="Cohen's D")

ggsave(ggarrange(p3,p4, ncol=1, common.legend = T), file='OUT/all.asym.case.control.FDR.png', bg='white')

dx.All.SA = read.csv('supplementary-tables/asymmetry.case.control.distribution.changes.csv')

p0a = subset(dx.All.SA, phenotype!='SUBC')[!is.na(match(subset(dx.All.SA, phenotype!='SUBC')$dx,c('AD','ASD','SCZ','MCI'))),] %>%
  group_by(phenotype,dx) %>%
  ggplot() +
  geom_brain(atlas = dk,aes(fill = left),hemi = 'left')+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('white','darkred'), 
                       limits=c(min(dx.All.SA$left),max(dx.All.SA$left)), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='Percentage points')+
  ggtitle('More left; upper 10%')

p0b = subset(dx.All.SA, phenotype!='SUBC')[!is.na(match(subset(dx.All.SA, phenotype!='SUBC')$dx,c('AD','ASD','SCZ','MCI'))),] %>%
  group_by(phenotype,dx) %>%
  ggplot() +
  geom_brain(atlas = dk,aes(fill = right),hemi = 'left')+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('white','darkblue'), 
                       limits=c(min(dx.All.SA$left),max(dx.All.SA$left)), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='Percentage points')+
  ggtitle('More right; lower 10%')

ggsave(ggarrange(p0a,p0b,nrow=1, common.legend = F),
       file='OUT/psychopathology.extreme.perc.png',bg='white', width = 12,height=10)


p1a = subset(dx.All.SA, phenotype!='SUBC')[!is.na(match(subset(dx.All.SA, phenotype!='SUBC')$dx,
                                                        c('AD','ASD','SCZ','MCI'))),] %>%
  group_by(phenotype,dx) %>%
  ggplot() +
  geom_brain(atlas = dk,aes(fill = left-10),hemi = 'left')+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('darkblue','white','darkred'), limits=c(-10,10), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='Percentage points')+
  ggtitle('More left; upper 10%')

p1b = subset(dx.All.SA, phenotype!='SUBC')[!is.na(match(subset(dx.All.SA, phenotype!='SUBC')$dx,
                                                        c('AD','ASD','SCZ','MCI'))),] %>%
  group_by(phenotype,dx) %>%
  ggplot() +
  geom_brain(atlas = dk,aes(fill = right-10),hemi = 'left')+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('darkblue','white','darkred'), limits=c(-10,10), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='Percentage points')+
  ggtitle('More right; lower 10%')

p1c = subset(dx.All.SA, phenotype=='SUBC')[!is.na(match(subset(dx.All.SA, phenotype=='SUBC')$dx,
                                                        c('AD','ASD','SCZ','MCI'))),] %>%
  group_by(phenotype,dx) %>%
  ggplot() +
  geom_brain(atlas = aseg,aes(fill = left-10))+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('darkblue','white','darkred'), limits=c(-10,10), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='Percentage points')

p1d = subset(dx.All.SA, phenotype=='SUBC')[!is.na(match(subset(dx.All.SA, phenotype=='SUBC')$dx,
                                                        c('AD','ASD','SCZ','MCI'))),] %>%
  group_by(phenotype,dx) %>%
  ggplot() +
  geom_brain(atlas = aseg,aes(fill = right-10))+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('darkblue','white','darkred'), limits=c(-10,10), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='Percentage points')

ggsave(ggarrange(p1a,p1c,ncol=1, common.legend = F),
       file='OUT/psychopathology.extreme.left.png',bg='white', width = 12,height=10)

ggsave(ggarrange(p1b,p1d,ncol=1, common.legend = F),
       file='OUT/psychopathology.extreme.right.png',bg='white', width = 12,height=10)


p2a = subset(dx.All.SA, phenotype!='SUBC')[!is.na(match(subset(dx.All.SA, phenotype!='SUBC')$dx,
                                                        c('AD','ASD','SCZ','MCI'))),] %>%
  group_by(phenotype,dx) %>%
  ggplot() +
  geom_brain(atlas = dk,aes(fill = SD),hemi = 'left')+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('white','orange','darkred'), 
                       limits=c(min(subset(dx.All.SA, phenotype!='SUBC')$SD),
                                max(subset(dx.All.SA, phenotype!='SUBC')$SD)), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='')+
  ggtitle('Standard deviation')

p2b = subset(dx.All.SA, phenotype=='SUBC')[!is.na(match(subset(dx.All.SA, phenotype=='SUBC')$dx,
                                                        c('AD','ASD','SCZ','MCI'))),] %>%
  group_by(phenotype,dx) %>%
  ggplot() +
  geom_brain(atlas = aseg,aes(fill = SD))+
  facet_grid(phenotype ~ dx)+
  scale_fill_gradientn(colours = c('white','orange','darkred'), 
                       limits=c(min(subset(dx.All.SA, phenotype=='SUBC')$SD),
                                max(subset(dx.All.SA, phenotype=='SUBC')$SD)), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='')

ggsave(ggarrange(p2a,p2b,ncol=1, common.legend = T),
       file='OUT/psychopathology.SD.png',bg='white', width = 12,height=10)

