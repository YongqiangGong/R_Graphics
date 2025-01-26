# install.packages("tidyverse")
# install.packages("patchwork")
# install.packages("colourpicker")
library(tidyverse)
library(patchwork)
library(colourpicker)

#p1
cols <- c("#1C86EE", "#1E90FF", "#00B2EE", "#00BFFF")
example_data1 <- data.frame(
  prop=c(44,22,20,14),
  type=c("Compound \nheterozygous","Dominant","X-Linked","Homozygous")) %>% 
  arrange(desc(type)) %>% 
  mutate(lab.ypos = cumsum(prop) - 0.5*prop) %>% 
  mutate(label=str_c(type,"\n",prop,"%"))

p1 <- ggplot(example_data1, aes(x = "", y = prop, fill = type)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = lab.ypos, label = label), 
            color = "black", size = 5,
            nudge_x = 0.04) +
  scale_fill_manual(values = cols) +
  coord_polar("y", start = 0) +
  theme_void() +
  theme(legend.position = "none")

#p2
example_data2 <- data.frame(
  gene=c("USH2A","RPGR","ABCA4","RHO","EYS","PRPF31","CHM",
         "RDH12","CRB1","RS1","PDE6A","RP1","CNGB1","CERKL",
         "PRPH2","PROM1","CNGB3","RP2","BEST1","COL2A1","PDE6B",
         "CDHR1","MYO7A","ARL6","PRPF8","TYR","FAM161A","CRX","GUCY2D"),
  count=c(58,47,35,25,14,14,13,11,10,9,8,7,7,7,7,5,5,5,5,5,4,4,4,4,4,3,3,3,3)
)

p2 <- ggplot(example_data2,aes(x=reorder(gene, -count),y=count))+
  geom_bar(stat = "identity",fill="blue",width = 0.5)+
  scale_y_continuous(limits = c(0,70),
                     breaks = seq(0, 70, by = 10),
                     expand = c(0, 0))+
  labs(x=" ",
       y=" ")+
  theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(angle = 60, vjust=1,
                                   hjust = 1,size = 6),
        axis.ticks=element_blank())

p1+p2+
  plot_annotation(tag_levels = c("A"))
