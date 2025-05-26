library(scales)
library(dplyr)
library(ggplot2)
library(ggseg)

LRComp = read.csv(file='supplementary-tables/LDSC-left-right-comparison.csv')
AAC.ALL = read.csv('supplementary-tables/asymmetry.lifespan.area.under.curve.csv')

p0a = subset(LRComp,  phenotype!='SUBC') %>% 
  group_by(phenotype) %>% 
  ggplot() + 
  geom_brain(atlas=dk,aes(fill=rg), hemi = 'left')+
  scale_fill_gradientn(colours=paletteer::paletteer_d("PNWColors::Lake"),limits=c(0.7,1), oob=squish)+
  #scale_fill_gradientn(colours=(rev(paletteer::paletteer_d("MoMAColors::Ernst"))), limits=c(0.7,1), oob=squish)+
  facet_grid(.~phenotype)+
  theme_void(base_family = 'Gill Sans')+
  theme(text = element_text(size = 12))

p0b = subset(LRComp,  phenotype=='SUBC') %>% 
  group_by(phenotype) %>% 
  ggplot() + 
  geom_brain(atlas=aseg,aes(fill=rg))+
  scale_fill_gradientn(colours=paletteer::paletteer_d("PNWColors::Lake"),limits=c(0.7,1), oob=squish)+
  #scale_fill_gradientn(colours=(rev(paletteer::paletteer_d("MoMAColors::Ernst"))), limits=c(0.7,1), oob=squish)+
  facet_grid(.~phenotype)+
  theme_void(base_family = 'Gill Sans')+
  theme(text = element_text(size = 12))

COMBINED = AAC.ALL[,c('label','phenotype','log.signed','log.absolute')] %>% 
  left_join(LRComp[,c('label','phenotype','rg','h2_obs')])

p1 = COMBINED %>% 
  group_by(phenotype) %>%
  ggplot(aes(x=rg,y=log.absolute))+
  geom_smooth(method='lm', color='darkgrey')+
  geom_point()+
  theme_minimal(base_family = 'Gill Sans')+
  xlab('Left-right genetic correlation')+
  ylab('Asymmetry AAC')+
  facet_wrap(.~phenotype, scales='free', nrow=1)+
  scale_color_gradientn(colours=c('white','darkred'))+
  theme(text = element_text(size = 12))

CORVAL = subset(COMBINED, phenotype!='SUBC') %>% 
  group_by(phenotype) %>% 
  summarize(Rho=cor.test(rg,log.absolute,na.rm=T, method='spearman')$estimate,
            P=cor.test(rg,log.absolute,na.rm=T, method='spearman')$p.value)

CORVAL$PFDR = p.adjust(CORVAL$P,method='fdr')

ggsave(ggarrange(ggarrange(p0a,p0b,nrow=1,widths=c(3,1), common.legend = T),p1,ncol=1, legend = 'bottom', heights=c(1,1.2)), 
       filename='OUT/lr.correlation.png', bg='white', width=11,height=5)


p2 = subset(COMBINED, phenotype=='SUBC' | phenotype=='GM') %>% 
  ggplot(aes(x=rg,y=log.absolute, color=phenotype))+
  geom_point(size=2.5)+
  geom_smooth(method='lm', color='darkgrey')+
  theme_minimal(base_family = 'Gill Sans')+
  xlab('Left-right genetic correlation')+
  ylab('Asymmetry AAC')+
  theme(text = element_text(size = 12), legend.position = 'bottom')+
  scale_color_manual(values = c('black','darkgrey'))+
  labs(color='')

ggsave(p2, filename='OUT/GM.SUBC.lr.correlation.png', bg='white', width=3,height=3)
