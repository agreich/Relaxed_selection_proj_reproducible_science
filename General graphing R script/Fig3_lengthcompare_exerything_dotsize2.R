##Figure 3 graphing##
##all lengths compared figure

library(ggplot2)
library(cowplot)
library(dplyr)


#############################3
#female coho (all)
##make sure the non-sub version has run to give you the correct c.GSI.clean
##or just load it here:
c.GSI.clean <- read.csv("c.GSI.clean")

coho_f_boxplot<-ggplot(c.GSI.clean) + aes(x=Length..mm., y=Wild.or.Hatch, color=Wild.or.Hatch) +
  geom_boxplot(color="black") +
  geom_jitter(size=2) +
  scale_color_manual(values =c("orange", "blue"))+
  theme_cowplot()+
  guides(color="none") +
  labs(x="Length (mm)", y=element_blank()) +
  coord_cartesian(xlim=c(473,650))+
  scale_x_continuous(breaks=c(500,550,600,650), expand=c(0,0)) +
  theme(plot.margin = margin(t=7,r=12,l=5,b=5))+
  scale_y_discrete(labels=c("H", "W"))
#+
#scale_y_discrete(breaks=c("Hatchery", "Wild"), expand=c(0,0)) #+
#theme(plot.margin = margin(t=7,r=12,l=5,b=5))

#dev.new (width = 7, height = 4, unit = "in", noRStudioGD = T); last_plot() #perfect

#ggsave("Length_compared_femalecoho.jpg", width = dev.size()[1], height = dev.size()[2]); dev.off()
#####################################

##############################
#male coho (all)
##LOAD IN coho.dat!!!
coho.dat <- read.csv("MASTERMaleCohoQC copy.csv")
write.csv(coho.dat, "coho.dat")
coho.dat <- read.csv("coho.dat")

coho_m_boxplot<-ggplot(coho.dat) + aes(x=Length..mm., y=Wild.or.Hatch, color=Wild.or.Hatch) +
  geom_boxplot(color="black", outlier.alpha = 0) +
  geom_jitter(size=2) +
  scale_color_manual(values =c("orange", "blue"))+
  theme_cowplot()+
  guides(color="none") +
  labs(x="Length (mm)", y=element_blank()) +
  scale_y_discrete(labels=c("H", "W")) +
  scale_x_continuous(breaks=c(450, 550, 650), expand=c(0,0))+
  coord_cartesian(xlim=c(400,650))+
  ylab("Coho salmon")
 




#####
even_male_pink <- p.dat <- read.csv("MASTERMalePinksQC.reorder.csv")
even_female_pink <- read.csv("FemalePinkGSIotodataadd1_without_gaps copy.csv")
odd_male_pink <-  read.csv("Male.p2.Rdata.2.csv")
odd_female_pink <- read.csv("Female.p2.Rdata.3.csv")
##eventually smooth this part out
#even-year pinks
##Wait -> I think we need to ezclude the big hatchery fish.
#males - use wild or hatch to differentiate, we don't have otos
even_male_boxplot <-ggplot(even_male_pink) + aes(x=Length..mm., y=Wild.or.Hatch, color=Wild.or.Hatch) +
  geom_boxplot(color="black", outlier.alpha = 0) +
  geom_jitter(size=2) +
  scale_color_manual(values =c("orange", "blue"))+
  theme_cowplot()+
  guides(color="none") +
  labs(x=element_blank(), y=element_blank()) +
  scale_y_discrete(labels=c("H", "W"))+
  scale_x_continuous(breaks=c(400, 440, 480, 520), expand=c(0,0))+
  coord_cartesian(xlim=c(366, 520))+
  ylab("Even-year pink salmon")+
  labs(title = "Male")+
  theme(plot.title = element_text(hjust = 0.5))
#females
library(forcats)
?fct_rev
even_female_pink_clean <- even_female_pink %>% filter(Weird == "n", Otolith.results != "unknown") 
even_female_boxplot<-ggplot(even_female_pink_clean) + aes(x=Length..mm., y=fct_rev(Otolith.results), color=fct_rev(Otolith.results)) +
  geom_boxplot(color="black", outlier.alpha = 0) +
  geom_jitter(size=2) +
  scale_color_manual(values =c("orange", "blue"))+
  theme_cowplot()+
  guides(color="none") +
  labs(x=element_blank(), y=element_blank()) +
  scale_y_discrete(labels=c("H", "W"))+
  scale_x_continuous(breaks=c(400, 440, 480), expand=c(0,0))+
  coord_cartesian(xlim=c(395,480))+
  labs(title="Female")+
  theme(plot.title = element_text(hjust = 0.5))
##looks good there

#############33
#pink odd
#males
odd_male_pink_clean <- odd_male_pink %>% filter(Otolith.reading != "Overground")
odd_male_boxplot <- ggplot(odd_male_pink_clean) + aes(x=Length.mm., y=fct_rev(Otolith.reading), color=fct_rev(Otolith.reading)) +
  geom_boxplot(color="black", outlier.alpha = 0) +
  geom_jitter(size=2) +
  scale_color_manual(values =c("orange", "blue"))+
  theme_cowplot()+
  guides(color="none") +
  labs(x=element_blank(), y=element_blank()) +
  scale_y_discrete(labels=c("H", "W"))+
  scale_x_continuous(breaks=c(350, 400, 450, 500), expand=c(0,0))+
  coord_cartesian(xlim=c(342,500))+ #looks good
  ylab("Odd-year pink salmon")
#females
odd_female_pink_clean <- odd_female_pink %>% filter(Weird == "n", Oto.reading != "No Oto", Oto.reading != "Overground") 
odd_female_boxplot <- ggplot(odd_female_pink_clean) + aes(x=Length.mm., y=fct_rev(Oto.reading), color=fct_rev(Oto.reading)) +
  geom_boxplot(color="black", outlier.alpha = 0) +
  geom_jitter(size=2) +
  scale_color_manual(values =c("orange", "blue"))+
  theme_cowplot()+
  guides(color="none") +
  labs(x=element_blank(), y=element_blank()) +
  scale_y_discrete(labels=c("H", "W")) +
  scale_x_continuous(breaks=c(375, 425, 475), expand=c(0,0))+
  coord_cartesian(xlim=c(340,475))
  
##Qced positions, it's correct (min length is 344, which is a hatchery fish)




#link everything together with patchwork
##I'll need to adjust axes later
###I'm thinking 6 panel, 3 rows by 2 columns. Even year pink, odd year pink, coho by row
library(patchwork)
#(even_male_boxplot/odd_male_boxplot/coho_m_boxplot)+(even_female_boxplot/odd_female_boxplot/coho_f_boxplot)

length_boxplot_base <-(even_male_boxplot+even_female_boxplot)/(odd_male_boxplot+odd_female_boxplot)/(coho_m_boxplot+coho_f_boxplot)
#I ENDED UP USING THIS ONE ALL IS WELL
#SHIT, HOW DO I SAVE PLOTS AGAIN?
# 7 BY 8 DIMENSIONS

length_boxplot_base
dev.new (width = 8, height = 8, unit = "in", noRStudioGD = T); last_plot() #perfect
ggsave ("FIG3_LENGTH_dotsize2.jpg", width = dev.size()[1], height = dev.size()[2]); dev.off()
dev.off()

###ALL BELOW IS NOT SO RELEVANT I THINK

##this one looks better. I'll have to add labels and make dots smaller
###How to add the labels tho?
###I'd like to add labels: MALE, FEMALE to colums and EP, OP, and C (or of the sort) to the rows
#01/11/23.FIGURED IT OUT!
#(even_male_boxplot+even_female_boxplot)/(odd_male_boxplot+odd_female_boxplot)/(coho_m_boxplot+coho_f_boxplot)+
  #plot_layout(tag_level = 'new') +
  #plot_annotation(tag_levels = list(c('CM', 'CF', 'EPM', 'EPF', 'OPM', 'OPF' )))
#on the rght track, but I'm not stoked
##
#(even_male_boxplot+even_female_boxplot)/(odd_male_boxplot+odd_female_boxplot)/(coho_m_boxplot+coho_f_boxplot)+



####how to add them labels.... Look at old stuff? Code from data viz class
###get rid of how everything says length? In the first two plots

#nice, we've fixed the axes. Good job
#now let;s add some labels
#length_boxplot_base + annotate("text", x=0.100, y=0.100, hjust=0, size=10, label= "Female", family="Times New Roman")#+
  #annotate("text", x=1, y=5600, hjust=0, size=5, label="Male", family="Times New Roman")
#well it's esentially done, just need to add the labels

#might give up and just add labels in ppt. Sometimes doing things in R makes sense, sometiems it does not.



###I'll do some length comparison here##
#even vs odd pink length (megan wants to know)
t.test(odd_male_pink_clean$Length.mm., even_male_pink$Length..mm.)
#sig that even is larger
t.test(odd_female_pink_clean$Length.mm., even_female_pink_clean$Length..mm.)
#t.test that even is larger