#copied from the web:

#DECEMBER 2, 2015 BY GGGARNER121
#Easy labels for multi-panel plots in R
#There are a number of ways to make multi-panel figures in R.  Probably the easiest and most commonly used method is to set par(mfrow=c(r,c)) to the  number of rows (r) and columns (c) you would like to use for your figure panels (Note: par(mfcol=c(r,c)) produces the same thing, only it renders the figures by column rather than by row).  Other methods include par(fig=c(x1,x2,y1,y2), new=T) and layout(mat), but these will be for another post.

#What I found challenging was putting a label in a consistent location on each of the panels.  Using the text() function would be the go-to function for this, but the default coordinate system used in the text() is the plot’s coordinate system, and you’ll have to set an additional plotting option (par(xpd)) to plot outside of the figure region.

#Since I regularly make multi-panel figures, I decided to write a wrapper function around text() that can easily and consistently place a label on a generated plot without having to worry about plotting coordinates.  Below is the function (Note: You can find the code and an example of its usage on bitbucket https://bitbucket.org/ggg121/r_figure_letter.git)
  
  put.fig.letter <- function(label, location="topleft", x=NULL, y=NULL, 
                             offset=c(0, 0), ...) {
    if(length(label) > 1) {
      warning("length(label) > 1, using label[1]")
    }
    if(is.null(x) | is.null(y)) {
      coords <- switch(location,
                       topleft = c(0.015,0.98),
                       topcenter = c(0.5525,0.98),
                       topright = c(0.985, 0.98),
                       bottomleft = c(0.015, 0.02), 
                       bottomcenter = c(0.5525, 0.02), 
                       bottomright = c(0.985, 0.02),
                       c(0.015, 0.98) )
    } else {
      coords <- c(x,y)
    }
    this.x <- grconvertX(coords[1] + offset[1], from="nfc", to="user")
    this.y <- grconvertY(coords[2] + offset[2], from="nfc", to="user")
    text(labels=label[1], x=this.x, y=this.y, xpd=T, ...)
  }



##Simply graphing##
df.pink2 <- read.csv("Male morpho/df.pink2.csv")

###FIRST: the linear morpho graph:##
##fuck. we're going to want to go back and remove unusually long fish from analysis
######################################3
#pink 2020 graph base (logged)
##fuck. we're going to want to go back and remove unusually long fish from analysis
range(log(df.pink2$snout)) #1.18, 1.91
range(log(df.pink2$depth)) #4.6, 5.2
range(df.pink2$length) #371, 515

ggSnout_p1 <-ggplot(df.pink2) +geom_point(size=2, aes(y=log(snout), x=length, color=Wild.or.hatch) )+
  geom_smooth(method="lm", aes(y=log(snout), x=length, color=Wild.or.hatch), color="black")+
  scale_color_manual(breaks =c("W","H"), values=c("blue", "orange"), name=element_blank(), labels=c("Wild origin", "Hatchery origin")) + theme_cowplot() + labs(x="Length (mm)", y= "log(Snout (mm))")+
  guides(color="none") + 
  coord_cartesian(xlim=c(367, 520), ylim=c(1.15, 2.0))+
  scale_x_continuous(breaks=c(400, 440, 480, 520), expand=c(0,0)) + 
  scale_y_continuous(breaks= c(1.2, 1.4, 1.6, 1.8, 2.0), expand=c(0,0))
#looks decent

#log depth
ggDepth_p1 <- ggplot(df.pink2) +geom_point(size=2, aes(y=log(depth), x=length, color=Wild.or.hatch) )+ 
  geom_smooth(aes(y=log(depth), x=length), method="lm", color="black")+ 
  scale_color_manual(breaks =c("W","H"), values=c("blue", "orange"), name=element_blank(), labels=c("Wild origin", "Hatchery origin")) + theme_cowplot() + labs(x="Length (mm)", y= "log(Depth (mm))")+
  guides(color="none")+
  coord_cartesian(xlim = c(367, 520), ylim=c(4.55, 5.2))+
  scale_x_continuous(breaks=c(400, 440, 480, 520), expand=c(0,0)) +
  scale_y_continuous(breaks=c(4.6, 4.8, 5.0, 5.2), expand=c(0,0)) #might need to do somehting to protect the margins? We'll see how it looks in the compound plot




###############################
##PINK 2021!!
p2.males1 <- read.csv("Male morpho/p2.males1.csv")

range(p2.males1$Length.mm.) #345, 492
range(log(p2.males1$Body.depth.mm.)) #4.2, 5.0
range(log(p2.males1$Snout.length.mm.)) #3.6, 4.3

ggsnout_pinkodd <- ggplot(p2.males1) + aes(x=Length.mm., y=log(Snout.length.mm.), color=Otolith.reading) + geom_point(size=2) +
  scale_color_manual(values=c("blue","orange")) + theme_cowplot()+
  guides(color= "none") +
  geom_smooth(method = "lm") +
  labs(x= "Length (mm)", y= "log(Snout (mm))") +
  coord_cartesian(xlim = c(340, 500), ylim=c(3.57, 4.5)) +
  scale_x_continuous(breaks=c(350, 400, 450, 500), expand=c(0,0)) + 
  scale_y_continuous(breaks=c(3.75, 4.00, 4.25, 4.50), expand=c(0,0))

#logged p2 depth
ggdepth_pinkodd<- ggplot(p2.males1) + aes(x=Length.mm., y=log(Body.depth.mm.), color=Otolith.reading) + geom_point(size=2) +  scale_color_manual(values=c("blue","orange")) + theme_cowplot()+
  guides(color= "none")+
  geom_smooth(method = "lm") +
  labs(x= "Length (mm)", y= "log(Depth (mm))") + 
  coord_cartesian(xlim = c(340, 500), ylim=c(4.15, 5.1)) +
  scale_x_continuous(breaks=c(350, 400, 450, 500), expand=c(0,0)) + 
  scale_y_continuous(breaks=c(4.25, 4.50, 4.75, 5.00), expand=c(0,0))

#what would this look like without the snakey fish???


###################3
#coho long graph base
df.coho.long2 <- read.csv("Male morpho/df.coho.long2.csv")

df.coho.long2$snoutmm <- (df.coho.long2$snout)*10

range(df.coho.long2$length) #537, 631
range(df.coho.long2$snoutmm) #130, 194
range(df.coho.long2$depth) #147, 192
mycolors.coho <- c("orange", "blue")

ggsnout_coho <- ggplot(data=df.coho.long2) + aes(x=length, y=snoutmm, color=Wild.or.hatch) + 
  geom_point(size=2) + geom_smooth(method="lm")+ 
  scale_color_manual(values=mycolors.coho) + 
  theme_cowplot() + labs(y="Snout (mm)", x= "Length (mm)") +
  guides(color="none") + 
  coord_cartesian(xlim=c(535, 640), ylim=c(127, 200)) + 
  scale_x_continuous(expand=c(0,0), breaks = c(560, 600, 640)) +
  scale_y_continuous(expand=c(0,0), breaks =c (140, 160, 180, 200))


ggdepth_coho <-ggplot(df.coho.long2)+aes(y=depth, x=length, color=Wild.or.hatch) +geom_point(size=2) + 
  geom_smooth(method="lm", key_glyph= "blank") + scale_color_manual(values=mycolors.coho, labels=c("Hatchery", "Wild")) + 
  theme_cowplot()+labs(y="Depth (mm)", x= "Length (mm)") +
  #guides(color="none") + 
  coord_cartesian(xlim=c(535, 640), ylim=c(145, 200)) + 
  scale_x_continuous(expand=c(0,0), breaks = c(560, 600, 640)) +
  scale_y_continuous(expand=c(0,0), breaks =c (160, 180, 200)) +
  theme(legend.title=element_blank(), legend.position = c(0.55, 0.12))

ggdepth_coho <- ggdepth_coho + theme(
  legend.box.background = element_rect(),
  legend.box.margin = margin(0, 3, 2, 2) #yes, finally I made a box.
)

#WIP BELOWWW
#combine using plot_grid. OR, combine using patchwork. Patchwork might actually be better, in this case
##first we need to troubleshoot p1.
library(patchwork) #patchwork is one option...
#object <- (ggSnout_p1 +ggsnout_pinkodd + ggsnout_coho) / (ggDepth_p1 + ggdepth_pinkodd+ ggdepth_coho)

#ggdraw(object) + draw_label ("EP", x = 0.12, y = 0.94, fontfamily = "Arial", fontface="bold", size = 15) +
 # draw_label ("OP", x = 0.12, y = 0.94, fontfamily = "Arial", fontface="bold", size = 15)+
  #draw_label ("C", x = 0.12, y = 0.94, fontfamily = "Arial", fontface="bold", size = 15)
#but I want to add in titles I think


##############NOPE BELOW##################3

male_base <- plot_grid(ggSnout_p1, ggsnout_pinkodd, ggsnout_coho, ggDepth_p1, ggdepth_pinkodd,ggdepth_coho, nrow=2, ncol=3, scale=0.95) #megan suggests 2 x 3

male_base2 <- plot_grid(NULL, male_base, ncol = 1, rel_heights = c(0.6,9.4))

#now axes and labels... 
plot_linear_male <- ggdraw(male_base2) +
  draw_label("Even-year pink", x = 0.21, y = 0.965, fontfamily = "Arial", fontface="bold", size = 15)+
  draw_label("Odd-year pink", x=0.55, y=0.965, fontfamily = "Arial", fontface="bold", size = 15)+
  draw_label("Coho", x=0.85, y=0.965, fontfamily = "Arial", fontface="bold", size = 15)
plot_linear_male

#and then ggsave
#dims: 10 by 6.56
dev.new (width = 10, height =6.56, unit = "in", noRStudioGD = T); last_plot()
#ggsave ("Male_linear2.jpg", width = dev.size()[1], height = dev.size()[2]); dev.off()



##################
####geomorph graphing: RWA (PCA) graphs


#even pink (p1)
ggMorpho_pinkeven <- ggplot(data=df.pink2)+aes(x=Comp3, y=Comp1, color=Wild.or.hatch)+
  geom_point(size=2)+scale_color_manual(values=wildhatch) + stat_ellipse() + 
  theme_bw() + labs(x= "RW 3", y= "RW 1") +
  guides(color="none") +
  labs(x=NULL, y=NULL)
#RW 3 is hump. RW 1 is hump and snout. RW 2 is bendyness(not having to do with fish morphometrics, just having to do with how the fish was placed for photo)

#odd pink (p2)
ggMorpho_pinkodd<- ggplot(data=df.pink2021.orig)+
  aes(x=Comp3, y=Comp1, color=origin)+
  geom_point(size=2)+scale_color_manual(values=wildhatch) + 
  stat_ellipse() + theme_bw() + 
  labs(x= "RW 3", y= "RW 1")+
  guides(color="none")+
  labs(x=NULL, y=NULL)

#coho long
mycolors.coho=c("orange", "blue")
#coho long
ggMorpho_coho <- ggplot(df.coho.long) + aes(x=Comp3, y=Comp1, color=Wild.or.hatch) + 
  geom_point(size=2)+ scale_color_manual(values=mycolors.coho) + 
  stat_ellipse() + 
  labs(y= "RW 1", x= "RW 3") + 
  theme_bw()+
  guides(color="none")+
  labs(x=NULL, y=NULL)
#"RW 1 (snout, roughly)", "RW 3 (depth, roughly)"

#combine them in a way that works
#library(patchwork)
ggMorpho_pinkeven + ggMorpho_pinkodd + ggMorpho_coho
#I could leave like this... OR combine the plot_grid way

#yeah, let's do the plot_grid way.
morpho_base <- plot_grid(ggMorpho_pinkeven, ggMorpho_pinkodd, ggMorpho_coho, nrow=1, ncol=3, scale=0.95)

morpho_base2 <- plot_grid(NULL, morpho_base, ncol = 2, rel_widths= c(0.3,9.7))
morpho_base3 <- plot_grid(NULL, morpho_base2, NULL, nrow=3, rel_heights = c(0.5, 9.0, 0.5))

#now axes and labels... 
plot_morpho_male <- ggdraw(morpho_base3) +
  draw_label("Even-year pink", x = 0.21, y = 0.965, fontfamily = "Arial", fontface="bold", size = 15)+
  draw_label("Odd-year pink", x=0.53, y=0.965, fontfamily = "Arial", fontface="bold", size = 15)+
  draw_label("Coho", x=0.85, y=0.965, fontfamily = "Arial", fontface="bold", size = 15) +
  draw_label ("RW3", x = 0.56, y = 0.05, size = 15) + 
  draw_label (("RW1"), angle= 90, x = 0.03, y = 0.50, size = 15)
plot_morpho_male #hmm just need to add a legend.. where to put it?

#and then ggsave
#dims: 10 by 6.56
dev.new (width = 10, height =3.5, unit = "in", noRStudioGD = T); last_plot()
ggsave ("Male_morpho.jpg", width = dev.size()[1], height = dev.size()[2]); dev.off()




#and how to display the relative warps... deal with later?
###can describe RW1 and RW3
### can show mean hatchery fish to wild fish graph (or wild fish to hatch fish graph)
##I think that is the best option. Do as a combo with this graph?



#RW graphs: wild to hatchery

#set up the multi-panel plot... NOT WORKING
dev.off()
dev.new ()

par(mfrow = c(3, 1), mar=c(1,1,1,0), family  = "Arial")
#pink odd
#wild to hatch, hatch to wild examine
plotRefToTarget(ref.w.p, ref.h.p, method="vector", mag=5, mar=c(1,1,1,0))
#text(x=200, y=12, "EP" )
text(x=-0.685, y=0.00, "EP", font=2, pos=4, col="black", cex=2) 
#plotRefToTarget(ref.h.p, ref.w.p, method="vector", mag=5)
#pink even
 #plotRefToTarget(ref.h.p2, ref.w.p2, method="vector", mag=5) #hatchery dots, wild arrows
plotRefToTarget(ref.w.p2, ref.h.p2, method="vector", mag=5, mar=c(1,1,1,0)) #wild dot, hatchery arrows
text(x=-0.64, y=0.01, "OP", font=2, pos=4, col="black", cex=2) 
#coho long
plotRefToTarget(ref.w.cl, ref.h.cl, method="vector", mag=5, mar=c(1,1,1,0))  #THATS the means compared to each other
#plotRefToTarget(ref.h.cl, ref.w.cl, method="vector", mag=5)
#coho (don't use?)
#plotRefToTarget(ref.w.c, ref.h.c, method="vector", mag=5) #wild dots to hatchery arrows
#now... add labels
#mtext("EP", side=2, line=0, adj=4, cex=1, col="black")
#mtext("OP", side=2, line=0, adj=2, cex=1, col="black")
#mtext("Coho", side=2, line=0, adj=1, cex=1, col="black")
text(x=-0.60, y=0.01, "Coho", font=2, pos=4, col="black", cex=2) 
#put.fig.letter(label="EP", location="topleft", font=2)

#well that was a pain in the add. Now save the plot
#jpeg(filename="Morpho_mean_plot.jpeg", width=5.75, height=3.66, units="in", res=300)
dev.off()

######################
#Different approach ggplot mean consensus graph
#######################
#make the mean shapes dataframes

pinkeven_meanshape_hatch <- data.frame(ref.h.p)

pinkeven_meanshape_wild <-data.frame(ref.w.p)


ggplot(pinkeven_meanshape_hatch) + aes(x=X,y=Y) + geom_point() +geom_point(data=pinkeven_meanshape_wild, color="red")
ggplot(pinkeven_meanshape_hatch) + aes(x=X,y=Y) + geom_point() +geom_path()
#try geom_polygon?
ggplot(pinkeven_meanshape_hatch) + aes(x=X,y=Y) + geom_point() +geom_polygon()

#pinkodd_meanshape_hatch

#coho
cohoL_mean_w <- data.frame(ref.w.cl)
cohoL_mean_h <- data.frame(ref.h.cl)

ggplot(cohoL_mean_h) + aes(x=X,y=Y) + geom_point(color="orange") +geom_point(data=cohoL_mean_w, color="blue")
#could try geom_path but would need to rearrange dataframe order...
ggplot(cohoL_mean_h) + aes(x=X,y=Y) + geom_point(color="orange") +geom_point(data=cohoL_mean_w, color="blue")+
  geom_path() + geom_path(data=cohoL_mean_w)

####################################
#what the relative warps mean graph
###############################3

#OK need to set up different references

#RW1 PLOT##########
par(mfrow = c(3, 2), mar=c(1,1,1,0), family  = "Arial")
#even-year pink RW1 min
plotRefToTarget(pca.no56$shapes$shapes.comp1$min, ref_p1, method="TPS") 
#even-year pink RW1 max
plotRefToTarget(pca.no56$shapes$shapes.comp1$max, ref_p1, method="TPS") 
#odd-year pink RW1 min
plotRefToTarget(pca.p2.orig$shapes$shapes.comp1$min, ref_p2, method="TPS")
#odd-year pink RW1 max
plotRefToTarget(pca.p2.orig$shapes$shapes.comp1$max, ref_p2, method="TPS")
#Coho long RW1 min
plotRefToTarget(pca_coho_long_slide$shapes$shapes.comp1$min, ref_cl, method="TPS")
#coho long RW1 max
plotRefToTarget(pca_coho_long_slide$shapes$shapes.comp1$max, ref_cl, method="TPS")

#RW3 plot##############
par(mfrow = c(3, 2), mar=c(1,1,1,0), family  = "Arial")
#even-year pink RW3 min
plotRefToTarget(pca.no56$shapes$shapes.comp3$min, ref_p1, method="TPS")
#even-year pink RW3 max
plotRefToTarget(pca.no56$shapes$shapes.comp3$max, ref_p1, method="TPS") 
#odd-year pink RW3 min
plotRefToTarget(pca.p2.orig$shapes$shapes.comp3$min, ref_p2, method="TPS")
#odd-year pink RW3 max
plotRefToTarget(pca.p2.orig$shapes$shapes.comp3$max, ref_p2, method="TPS")
#Coho long RW3 min
plotRefToTarget(pca_coho_long_slide$shapes$shapes.comp3$min, ref_cl, method="TPS")
#coho long RW3 max
plotRefToTarget(pca_coho_long_slide$shapes$shapes.comp3$max, ref_cl, method="TPS")
#CONISDER DESCRIBING RW's and what they mean in the next manuscript draft

##consider re-making this graph for RW 2 as well

##############################3


###############################
#no snakes graphs:
ggplot(p2.males1_nosnakes) + aes(x=Length.mm., y=log(Snout.length.mm.), color=Otolith.reading) + geom_point(size=2) +
  scale_color_manual(values=c("blue","orange")) + theme_cowplot()+
  guides(color= "none") +
  geom_smooth(method = "lm") +
  labs(x= "Length (mm)", y= "log(Snout (mm))") +
  coord_cartesian(xlim = c(340, 500), ylim=c(3.57, 4.5)) +
  scale_x_continuous(breaks=c(350, 400, 450, 500), expand=c(0,0)) + 
  scale_y_continuous(breaks=c(3.75, 4.00, 4.25, 4.50), expand=c(0,0))

#logged p2 depth
ggplot(p2.males1_nosnakes) + aes(x=Length.mm., y=log(Body.depth.mm.), color=Otolith.reading) + geom_point(size=2) +  scale_color_manual(values=c("blue","orange")) + theme_cowplot()+
  guides(color= "none")+
  geom_smooth(method = "lm") +
  labs(x= "Length (mm)", y= "log(Depth (mm))") + 
  coord_cartesian(xlim = c(340, 500), ylim=c(4.15, 5.1)) +
  scale_x_continuous(breaks=c(350, 400, 450, 500), expand=c(0,0)) + 
  scale_y_continuous(breaks=c(4.25, 4.50, 4.75, 5.00), expand=c(0,0))


##Returning to graph for thesis draft 2
######################################
#megan wants me to combine this plot:
par(mfrow = c(3, 1), mar=c(1,1,1,0), family  = "Arial")
#pink odd
#wild to hatch, hatch to wild examine
plotRefToTarget(ref.w.p, ref.h.p, method="vector", mag=5, mar=c(1,1,1,0))
#text(x=200, y=12, "EP" )
text(x=-0.685, y=0.00, "EP", font=2, pos=4, col="black", cex=2) 
#plotRefToTarget(ref.h.p, ref.w.p, method="vector", mag=5)
#pink even
#plotRefToTarget(ref.h.p2, ref.w.p2, method="vector", mag=5) #hatchery dots, wild arrows
plotRefToTarget(ref.w.p2, ref.h.p2, method="vector", mag=5, mar=c(1,1,1,0)) #wild dot, hatchery arrows
text(x=-0.64, y=0.01, "OP", font=2, pos=4, col="black", cex=2) 
#coho long
plotRefToTarget(ref.w.cl, ref.h.cl, method="vector", mag=5, mar=c(1,1,1,0))  #THATS the means compared to each other
#plotRefToTarget(ref.h.cl, ref.w.cl, method="vector", mag=5)
#coho (don't use?)
#plotRefToTarget(ref.w.c, ref.h.c, method="vector", mag=5) #wild dots to hatchery arrows
#now... add labels
#tangent recording this plot
morpho_arrows_record <- recordPlot()

#mtext("EP", side=2, line=0, adj=4, cex=1, col="black")
#mtext("OP", side=2, line=0, adj=2, cex=1, col="black")
#mtext("Coho", side=2, line=0, adj=1, cex=1, col="black")
text(x=-0.60, y=0.01, "Coho", font=2, pos=4, col="black", cex=2) 


#with this plot:
plot_morpho_male


##################

##I think the best way will be to get all plots individually, using PAR

par(mfrow = c(3, 2), mar=c(1,1,1,0), family  = "Arial")
#ok I set up the grid. Now I'll have to place the graphs in order. But what order

#ey pink morpho
ggMorpho_pinkeven

#even year other plot

#odd year pink morpho
ggMorpho_pinkodd

#odd year other plot

#coho morpho
ggMorpho_coho

#coho other plot

##let's see how that fills the space

##well that did not work.... looks like ggplot graphs are incompatible with par(mfrow=...)
#instead, try the gridBase package
#library(gridBase)
#library(grid)

#plot.new()              
#vps <- baseViewports()
#pushViewport(vps$figure) ##   I am in the space of the autocorrelation plot
#vp1 <-plotViewport(c(1.8,1,0,1)) ## create new vp with margins, you play with this values 
#require(ggplot2)
#acz <- acf(y, plot=F)
#acd <- data.frame(lag=acz$lag, acf=acz$acf)
#p <- ggplot(acd, aes(lag, acf)) + geom_area(fill="grey") +
 # geom_hline(yintercept=c(0.05, -0.05), linetype="dashed") +
  #theme_bw()+labs(title= "Autocorrelation\n")+
  ## some setting in the title to get something near to the other plots
  #theme(plot.title = element_text(size = rel(1.4),face ='bold'))
#print(p,vp = vp1)   

#par(mfrow = c(3, 2), mar=c(1,1,1,0), family  = "Arial")



#the plots I want, hopefully in order.Might have to adjust labeling and such later
library(biwavelet)
library(ggplot2)
library(cowplot)
library(gridGraphics)

#ggMorpho_pinkeven

plotRefToTarget(ref.w.p, ref.h.p, method="vector", mag=5, mar=c(1,1,1,0))
podd<-recordPlot()

#ggMorpho_pinkodd

plotRefToTarget(ref.w.p2, ref.h.p2, method="vector", mag=5, mar=c(1,1,1,0)) 

#ggMorpho_coho

plotRefToTarget(ref.w.cl, ref.h.cl, method="vector", mag=5, mar=c(1,1,1,0)) 

#experiment
morpho_arrows_record #.... my desired plot is right here. This could save me some trouble? might have 
##to make it larger tho


##########
#now that I think of it, I kind of want to line the fish up and put UNDER the RW plot.
plot_morpho_male
#let's record a new morpho arrows plot, fish lined up in a line
##so I can do one on top, one on bottom


par(mfrow = c(1, 3), mar=c(1,1,1,0), family  = "Arial")
#pink odd
#wild to hatch, hatch to wild examine
plotRefToTarget(ref.w.p, ref.h.p, method="vector", mag=5, mar=c(1,1,1,0))
#text(x=200, y=12, "EP" )
#text(x=-0.685, y=0.00, "EP", font=2, pos=4, col="black", cex=2)# got rid of label
#plotRefToTarget(ref.h.p, ref.w.p, method="vector", mag=5)
#pink even
#plotRefToTarget(ref.h.p2, ref.w.p2, method="vector", mag=5) #hatchery dots, wild arrows
plotRefToTarget(ref.w.p2, ref.h.p2, method="vector", mag=5, mar=c(1,1,1,0)) #wild dot, hatchery arrows
#text(x=-0.64, y=0.01, "OP", font=2, pos=4, col="black", cex=2)  #got rid of label
#coho long
plotRefToTarget(ref.w.cl, ref.h.cl, method="vector", mag=5, mar=c(1,1,1,0))  #THATS the means compared to each other
#plotRefToTarget(ref.h.cl, ref.w.cl, method="vector", mag=5)
#coho (don't use?)
#plotRefToTarget(ref.w.c, ref.h.c, method="vector", mag=5) #wild dots to hatchery arrows
#now... add labels
#tangent recording this plot
morpho_arrows_record2 <- recordPlot()
#perfect?

#try to change ggplot object?
plot_morpho_male
plot_morpho_male_2 <-recordPlot()

#ok, my two similar objects:
class(plot_morpho_male_2)
class(morpho_arrows_record2)
#ok ok, these are both recorded plots
#plot_grid(plot_morpho_male_2, morpho_arrows_record2, ncol=1)



#try to combine, see how it goes. Margins might be weird
#plot_grid(plot_morpho_male_2, morpho_arrows_record2, nrow=2, ncol=1)
library(gridExtra)
plot2 <- grid::grid.grabExpr(plot_morpho_male_2)

#need to create a plot into a grob for a ggplot to work?
library(grid)
library(ggplotify)

grob_morph_1 <- as.grob(plot_morpho_male)



gridExtra::grid.arrange(plot_morpho_male, plot2, ncol=1)


#try again
#08/23/22
#two plots:
plot_morpho_male #a ggplot
grid.echo()
b <-morpho_arrows_record2 #a recorded plot

#recorded plot wont work for as.ggplot
#how to record a base plot as an object?
library(gridGraphics)


par(mfrow = c(1, 3), mar=c(1,1,1,0), family  = "Arial")
plotRefToTarget(ref.w.p, ref.h.p, method="vector", mag=5, mar=c(1,1,1,0))
plotRefToTarget(ref.w.p2, ref.h.p2, method="vector", mag=5, mar=c(1,1,1,0)) #wild dot, hatchery arrows
plotRefToTarget(ref.w.cl, ref.h.cl, method="vector", mag=5, mar=c(1,1,1,0))
grid.echo()
a<- grid.grab()
class(grid.draw(a))
class(a)
grid.draw(a) #yeah, this needs to be larger

#as.ggplot(
 # grid.draw(a)  #THATS the means compared to each other
#)

#BELOW WORKS. grid.arrange and patchwork both work
gridExtra::grid.arrange(plot_morpho_male, a, ncol=1) #woohoo! it works!! Obs need to adjust tho
?gridExtra::grid.arrange
gridExtra::grid.arrange(plot_morpho_male, a, ncol=1)

library(patchwork)
plot_morpho_male/a #this works too! #how to control margins tho...
#plot_layout()
plot_morpho_male/a +plot_layout(heights =c(1,1))

#that's not spectacular either
design <- "
111111
#2222#
"
#hmm. need to crop plot a to the essentials I think
plot_morpho_male/a + plot_layout(design=design)

#playing around with cropping options to crop plot a, via grid.arrange or patchwork methods
final <- gridExtra::arrangeGrob(a, plot_morpho_male, layout_matrix = rbind(c(2),c(1)),
                                widths=c(7,10), heights=c(4, 10), respect=T) #ok yes, go the right order
grid.draw(final)
#ack. https://stackoverflow.com/questions/45904230/is-it-possible-to-crop-a-plot-when-doing-arrangegrob

#maybe I need to crop plot a, and then use patchwork to combine
#alternatively, I could treat the morpho plots as individuals, but that sounds like a pain in the ass


############################3
###10/14/22
#let's ggsave plot morpho male
plot_morpho_male #the main fig #dims looks godd
dev.new (width = 10, height =3.5, unit = "in", noRStudioGD = T); last_plot()
ggsave ("Male_morpho_fig4_toppart.jpg", width = dev.size()[1], height = dev.size()[2]); dev.off()
dev.off()

par(mfrow = c(1, 3), mar=c(1,1,1,0), family  = "Arial")
plotRefToTarget(ref.w.p, ref.h.p, method="vector", mag=5, mar=c(1,1,1,0))
plotRefToTarget(ref.w.p2, ref.h.p2, method="vector", mag=5, mar=c(1,1,1,0)) #wild dot, hatchery arrows
plotRefToTarget(ref.w.cl, ref.h.cl, method="vector", mag=5, mar=c(1,1,1,0))
dev.new (width = 10, height =3.5, unit = "in", noRStudioGD = T); last_plot()
ggsave ("Male_morpho_fig4_bottompart.jpg", width = dev.size()[1], height = dev.size()[2]); dev.off()
#############################3

#################33
###LONG COHO
#long coho tangent
library(dplyr)
df.coho <- read.csv("Male morpho/df.coho.csv")
df.coho$snoutmm <- (df.coho$snoutL)*10

ggMorpho_coho_all <- ggplot(df.coho) + aes(x=Comp3, y=Comp1, color=Wild.or.hatch) + 
  geom_point(size=2)+ scale_color_manual(values=mycolors.coho) + 
  stat_ellipse() + 
  labs(y= "RW 1", x= "RW 3") + 
  theme_bw(base_size = 14)+
  #theme(font_size=14, font_family="")+
  guides(color="none")
   #add legend eventually.

ggsnout_coho_all <- ggplot(data=df.coho) + aes(x=length, y=snoutmm, color=Wild.or.hatch) + 
  geom_point(size=2) + geom_smooth(method="lm")+ 
  scale_color_manual(values=mycolors.coho) + 
  theme_cowplot() + labs(y="Snout (mm)", x= "Length (mm)") +
  guides(color="none") +
  coord_cartesian(xlim=c(400, 650), ylim=c(75, 200)) + 
  scale_x_continuous(expand=c(0,0), breaks = c(450, 500, 550, 600, 650)) +
  scale_y_continuous(expand=c(0,0), breaks =c(80, 120, 160, 200))


ggdepth_coho_all <-ggplot(df.coho)+aes(y=depth, x=length, color=Wild.or.hatch) +geom_point(size=2) + 
  geom_smooth(method="lm", key_glyph= "blank") + scale_color_manual(values=mycolors.coho, labels=c("Hatchery", "Wild")) + 
  theme_cowplot()+labs(y="Depth (mm)", x= "Length (mm)") +
  guides(color="none") + 
  coord_cartesian(xlim=c(400, 650), ylim=c(90, 200)) + 
  scale_x_continuous(expand=c(0,0), breaks = c(450, 500, 550, 600, 650)) +
  scale_y_continuous(expand=c(0,0), breaks =c (100, 150, 200)) +
  theme(legend.title=element_blank(), legend.position = c(0.55, 0.12))
#expand the margins a bit too


#stack these mf's
library(patchwork)
ggsnout_coho_all/ggdepth_coho_all/ggMorpho_coho_all


#11/08/22
#length comparison graph for coho_all dataset. Are these males or females?
#length
ggplot(coho.dat) + aes(x=Length..mm., y=Wild.or.Hatch, color=Wild.or.Hatch) +
  geom_boxplot(color="black", outlier.alpha = 0) +
  geom_jitter(size=3) +
  scale_color_manual(values =c("orange", "blue"))+
  theme_cowplot()+
  guides(color="none") +
  labs(x="Length (mm)", y=element_blank()) +
  coord_cartesian(xlim=c(535, 640)) + 
  scale_x_continuous(expand=c(0,0), breaks = c(560, 600, 640))
  #coord_cartesian(xlim=c(473,650))+
  #scale_x_continuous(breaks=c(500,550,600,650), expand=c(0,0)) +
  #theme(plot.margin = margin(t=7,r=12,l=5,b=5))
#+
#scale_y_discrete(breaks=c("Hatchery", "Wild"), expand=c(0,0)) #+
#theme(plot.margin = margin(t=7,r=12,l=5,b=5))

#dev.new (width = 7, height = 4, unit = "in", noRStudioGD = T); last_plot() #perfect

#ggsave("Length_compared_malecoho.jpg", width = dev.size()[1], height = dev.size()[2]); dev.off()



############################3
#01/02/22 - did I do this in the femael code?
##MEgan wants graphs of everything. Male coho wild/hatch, save as ggplot object. Introduce
ggplot(coho.dat) + aes(x=Length..mm., y=Wild.or.Hatch, color=Wild.or.Hatch) +
  geom_boxplot(color="black", outlier.alpha = 0) +
  geom_jitter(size=3) +
  scale_color_manual(values =c("orange", "blue"))+
  theme_cowplot()+
  guides(color="none") +
  labs(x="Length (mm)", y=element_blank()) +
  scale_y_discrete(labels=c("H", "W")) +
  theme(plot.margin = margin(t=0,r=0,l=10,b=0))
  #coord_cartesian(xlim=c(535, 640)) + 
  #scale_x_continuous(expand=c(0,0), breaks = c(560, 600, 640))
 #coord_cartesian(xlim=c(473,650))+
 #scale_x_continuous(breaks=c(500,550,600,650), expand=c(0,0)) +
#theme(plot.margin = margin(t=7,r=12,l=5,b=5))+
#scale_y_discrete(breaks=c("Hatchery", "Wild"), expand=c(0,0)) #+
#theme(plot.margin = margin(t=7,r=12,l=5,b=5))

dev.new (width = 7, height = 4, unit = "in", noRStudioGD = T); last_plot() #perfect

ggsave("Length_compared_malecoho.jpg", width = dev.size()[1], height = dev.size()[2]); dev.off()
dev.off()
#w
