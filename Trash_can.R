#p1$GSI <- (p1$Total.Egg.Mass.g./p1$Fish.Weight..g.) *100
#p1.clean <- na.omit(p1) %>% filter(Weird == "n", Otolith.results != "unknown")
#p1.GSI.mod <- aov(GSI ~ Otolith.results, data = p1.clean)
#summary(p1.GSI.mod) ##THIS ONE
#summary.lm(p1.GSI.mod)


FUCKED UP STUFF, dont use this block: from line 686 on coho sub
```{r}

#coho
#what's the min and max for hatchery and wild lengths?
hatch.temp <- coho.clean %>% filter(Wild.or.Hatch=="hatchery")
wild.temp <- coho.clean %>% filter(Wild.or.Hatch=="wild")

hmin.length <- min(hatch.temp$Length..mm.)
hmax.length <- max(hatch.temp$Length..mm.)
wmin.length <- min(wild.temp$Length..mm.)
wmax.length <- max(wild.temp$Length..mm.)

coho.egg.graph + 
  geom_ribbon(aes(ymin=Intervals$fixed[1,1], ymax=Intervals$fixed[1,3]), color="grey", alpha=0.3) + 
  geom_ribbon(aes(ymin= Intervals$fixed[2,1],  ymax=(Intervals$fixed[2,3]), xmin= wmin.length, xmax=wmax.length), color="grey", alpha=0.3)+ #wild
  geom_segment(y = cf.fix[1], yend = cf.fix[1], color="orange", size=1.5, x= hmin.length, xend = hmax.length ) + geom_segment(y = cf.fix[2], yend= cf.fix[2], color="blue", size=1.5, x= wmin.length, xend = wmax.length )+
  coord_cartesian(ylim=c(5,8.3)) +
  scale_y_continuous(breaks=c(5,6,7,8), expand=c(0,0)) 

#try geom_bar or #geom_polygon
coho.egg.graph + 
  geom_polygon(aes(y=c(Intervals$fixed[1,1], Intervals$fixed[1,3])), color="grey", alpha=0.3) + 
  geom_polygon(aes(y=c(Intervals$fixed[2,1],Intervals$fixed[2,3])), color="grey", alpha=0.3)+ #wild
  geom_segment(y = cf.fix[1], yend = cf.fix[1], color="orange", size=1.5, x= hmin.length, xend = hmax.length ) + geom_segment(y = cf.fix[2], yend= cf.fix[2], color="blue", size=1.5, x= wmin.length, xend = wmax.length )+
  coord_cartesian(ylim=c(5,8.3)) +
  scale_y_continuous(breaks=c(5,6,7,8), expand=c(0,0)) 


###
coho.egg.graph + 
  geom_ribbon(aes(ymin=Intervals$fixed[1,1], ymax=Intervals$fixed[1,3]), color="grey", alpha=0.3) + 
  geom_ribbon(aes(ymin= Intervals$fixed[2,1],  ymax=(Intervals$fixed[2,3]), x = coho.clean$Length..mm. ), color="grey", alpha=0.3)+ #wild
  geom_segment(y = cf.fix[1], yend = cf.fix[1], color="orange", size=1.5, x= hmin.length, xend = hmax.length ) + geom_segment(y = cf.fix[2], yend= cf.fix[2], color="blue", size=1.5, x= wmin.length, xend = wmax.length )+
  coord_cartesian(ylim=c(5,8.3)) +
  scale_y_continuous(breaks=c(5,6,7,8), expand=c(0,0)) 


coho.egg.graph + 
  geom_area(aes(ymin=Intervals$fixed[1,1], ymax=Intervals$fixed[1,3]), color="grey", alpha=0.3) + 
  geom_ribbon(aes(ymin= Intervals$fixed[2,1],  ymax=(Intervals$fixed[2,3])), color="grey", alpha=0.3)+ #wild
  geom_segment(y = cf.fix[1], yend = cf.fix[1], color="orange", size=1.5, x= hmin.length, xend = hmax.length ) + geom_segment(y = cf.fix[2], yend= cf.fix[2], color="blue", size=1.5, x= wmin.length, xend = wmax.length )+
  coord_cartesian(ylim=c(5,8.3)) +
  scale_y_continuous(breaks=c(5,6,7,8), expand=c(0,0)) 


##
coho.egg.graph + 
  geom_segment(y=Intervals$fixed[1,1], yend=Intervals$fixed[1,1], color="black", x=hmin.length, xend=hmax.length) +
  geom_segment(y=Intervals$fixed[1,3], yend=Intervals$fixed[1,3], color="black", x=hmin.length, xend=hmax.length) +
  #hatch
  geom_segment(y= Intervals$fixed[2,1],  yend=(Intervals$fixed[2,1]), x= wmin.length, xend=wmax.length, color="black")+ 
  geom_segment(y= Intervals$fixed[2,3],  yend=(Intervals$fixed[2,3]), x= wmin.length, xend=wmax.length, color="black")+ 
  #wild
  geom_segment(y = cf.fix[1], yend = cf.fix[1], color="orange", size=1.5, x= hmin.length, xend = hmax.length ) + geom_segment(y = cf.fix[2], yend= cf.fix[2], color="blue", size=1.5, x= wmin.length, xend = wmax.length )+
  coord_cartesian(ylim=c(5,8.3)) +
  scale_y_continuous(breaks=c(5,6,7,8), expand=c(0,0))

```