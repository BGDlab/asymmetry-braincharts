library(dplyr)
library(ggseg)
library(ggpubr)

# Read in data
DIFF.MILESTONES=read.csv('SHARE/bootstrap.milestones.csv')

# Estimate 95% condifence intervals using bootstrap mean and standard deviation for each of three milestones
DIFF.MILESTONES$CI.low.rotpeak =  DIFF.MILESTONES$mu.diff.rotpeak-DIFF.MILESTONES$sd.diff.rotpeak*1.96
DIFF.MILESTONES$CI.high.rotpeak =  DIFF.MILESTONES$mu.diff.rotpeak+DIFF.MILESTONES$sd.diff.rotpeak*1.96
DIFF.MILESTONES = DIFF.MILESTONES %>% group_by(phenotype,label) %>% mutate(sign.rotpeak=ifelse( (((CI.low.rotpeak < 0) & (CI.high.rotpeak < 0)) || 
                                                                                                   ((CI.low.rotpeak > 0) & (CI.high.rotpeak > 0))), T,F))

DIFF.MILESTONES$CI.low.zeropeak =  DIFF.MILESTONES$mu.diff.zeropeak-DIFF.MILESTONES$sd.diff.zeropeak*1.96
DIFF.MILESTONES$CI.high.zeropeak =  DIFF.MILESTONES$mu.diff.zeropeak+DIFF.MILESTONES$sd.diff.zeropeak*1.96
DIFF.MILESTONES = DIFF.MILESTONES %>% group_by(phenotype,label) %>% mutate(sign.zeropeak=ifelse( (((CI.low.zeropeak < 0) & (CI.high.zeropeak < 0)) || 
                                                                                                    ((CI.low.zeropeak > 0) & (CI.high.zeropeak > 0))), T,F))

DIFF.MILESTONES$CI.low.declinepeak =  DIFF.MILESTONES$mu.diff.declinepeak-DIFF.MILESTONES$sd.diff.declinepeak*1.96
DIFF.MILESTONES$CI.high.declinepeak =  DIFF.MILESTONES$mu.diff.declinepeak+DIFF.MILESTONES$sd.diff.declinepeak*1.96
DIFF.MILESTONES = DIFF.MILESTONES %>% group_by(phenotype,label) %>% mutate(sign.declinepeak=ifelse( (((CI.low.declinepeak < 0) & (CI.high.declinepeak < 0)) || 
                                                                                                       ((CI.low.declinepeak > 0) & (CI.high.declinepeak > 0))), T,F))

# Included below is examplery code of how to plot the bootstrapped differences in milestones for a single phenotype
peakDiffBar = subset(DIFF.MILESTONES, phenotype =='GM')%>%
  ggplot(aes(x=diff.orig.zeropeak,y=reorder(label,diff.orig.zeropeak),color=sign.zeropeak))+
  geom_point()+
  geom_errorbarh(aes(xmin=CI.low.zeropeak, xmax=CI.high.zeropeak),shape = 21,size = 1,alpha = 0.7) +
  xlim(c(-10,10))+
  theme_minimal(base_family='Gill Sans')+
  ggtitle('Difference in peak')


growthDiffBar = subset(DIFF.MILESTONES, phenotype =='GM')%>%
  ggplot(aes(x=diff.orig.rotpeak, y=reorder(label,diff.orig.rotpeak),color=sign.rotpeak))+
  geom_point()+
  geom_errorbarh(aes(xmin=CI.low.rotpeak, xmax=CI.high.rotpeak),shape = 21,size = 1,alpha = 0.7) +
  xlim(c(-3,3))+
  theme_minimal(base_family='Gill Sans')+
  ggtitle('Difference in peak rate of growth')


delineDiffBar = subset(DIFF.MILESTONES, phenotype =='GM')%>%
  ggplot(aes(x=diff.orig.declinepeak,y=reorder(label,diff.orig.declinepeak),color=sign.declinepeak))+
  geom_point()+
  geom_errorbarh(aes(xmin=CI.low.declinepeak, xmax=CI.high.declinepeak),shape = 21,size = 1,alpha = 0.7) +
  theme_minimal(base_family='Gill Sans')+
  xlim(c(-70,70))+
  ggtitle('Difference in peak rate of decline')

ggsave(ggarrange(peakDiffBar,growthDiffBar,delineDiffBar,ncol=3),
       file='OUT/milestone.boot.png',bg='white',width=18,height=5)



peakDiffSurf = ungroup(subset(DIFF.MILESTONES, phenotype =='GM')) %>%
  ggplot() +
  geom_brain(atlas = dk, 
             aes(fill = ifelse(sign.zeropeak,mu.diff.zeropeak,NA)),
             hemi = 'left')+
  scale_fill_gradientn(colours = c('darkblue','white','darkred'), breaks = c(-2,0,2),limits=c(-2,2), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='Years')+
  ggtitle('Difference in Age at Peak')


growthDiffSurf = ungroup(subset(DIFF.MILESTONES, phenotype =='GM')) %>%
  ggplot() +
  geom_brain(atlas = dk, 
             aes(fill = ifelse(sign.rotpeak,mu.diff.rotpeak,NA)),
             hemi = 'left')+
  scale_fill_gradientn(colours = c('darkblue','white','darkred'), breaks = c(-0.5,0,0.5),limits=c(-0.5,0.5), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='Years')+
  ggtitle('Difference in Age at Peak Rate of Growth')


declineDiffSurf = ungroup(subset(DIFF.MILESTONES, phenotype =='GM')) %>%
  ggplot() +
  geom_brain(atlas = dk, 
             aes(fill = ifelse(sign.declinepeak,mu.diff.declinepeak,NA)),
             hemi = 'left')+
  scale_fill_gradientn(colours = c('darkblue','white','darkred'), breaks = c(-40,0,40),limits=c(-40,40), oob=squish)+
  theme_void(base_family = 'Gill Sans')+
  labs(fill='Years')+
  ggtitle('Difference in Age at Peak Rate of Decline')

ggsave(ggarrange(growthDiffSurf,peakDiffSurf,declineDiffSurf,ncol=1),
       file='OUT/sign.surface.diff.milestone.boot.Surf.png',bg='white',width=5,height=6)
