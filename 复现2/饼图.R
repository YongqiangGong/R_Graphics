# install.packages("tidyverse")
# install.packages("randomcoloR")
# install.packages("scales")
# install.packages("patchwork")

library(randomcoloR)
library(tidyverse)
library(scales)
library(patchwork)

cols <- distinctColorPalette(4)

example_data1 <- data.frame(
  prop=c(11.8,7.9,5.3,75),
  type=c("Definitive positive","Probable positive",
         "Inconclusive","Negative")) %>% 
  arrange(desc(type)) %>% 
  mutate(lab.ypos = cumsum(prop) - 0.5*prop) 

example_data2 <- data.frame(
  prop=c(9.3,15.7,18.5,56.5),
  type=c("Definitive positive","Probable positive",
         "Inconclusive","Negative"))%>% 
  arrange(desc(type)) %>% # 重排序
  mutate(lab.ypos = cumsum(prop) - 0.5*prop) 

example_data3 <- data.frame(
  prop=c(22.3,6.4,14.5,56.8),
  type=c("Definitive positive","Probable positive",
         "Inconclusive","Negative"))%>% 
  arrange(desc(type)) %>% # 重排序
  mutate(lab.ypos = cumsum(prop) - 0.5*prop) 

example_data4 <- data.frame(
  prop=c(15.2,9.1,6.1,69.7),
  type=c("Definitive positive","Probable positive",
         "Inconclusive","Negative"))%>% 
  arrange(desc(type)) %>% # 重排序
  mutate(lab.ypos = cumsum(prop) - 0.5*prop) 

example_data5 <- data.frame(
  prop=c(14.3,0,7.1,78.6),
  type=c("Definitive positive","Probable positive",
         "Inconclusive","Negative"))%>% 
  arrange(desc(type)) %>% # 重排序
  mutate(lab.ypos = cumsum(prop) - 0.5*prop) 

example_data6 <- data.frame(
  prop=c(11.9,6.7,6.3,75.1),
  type=c("Definitive positive","Probable positive",
         "Inconclusive","Negative"))%>% 
  arrange(desc(type)) %>% # 重排序
  mutate(lab.ypos = cumsum(prop) - 0.5*prop) 

p1 <- ggplot(example_data1, aes(x = "", y = prop, fill = type)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = lab.ypos, label = scales::percent(prop / 100)), 
            color = "black",size = 4,
            nudge_x = 0.7)+
  scale_fill_manual(values = cols) +
  coord_polar("y", start = 0)+
  theme_void()+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="",
       title = "Pediatric - Proband first")+
  guides(fill = guide_legend(ncol = 2)) 
p2 <- ggplot(example_data2, aes(x = "", y = prop, fill = type)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = lab.ypos, label = scales::percent(prop / 100),), 
            color = "black",size = 4,
            nudge_x = 0.7)+
  scale_fill_manual(values = cols) +
  coord_polar("y", start = 0)+
  theme_void()+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="",
       title = "Pediatric - Duo")+
  guides(fill = guide_legend(ncol = 2)) 
p3 <- ggplot(example_data3, aes(x = "", y = prop, fill = type)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = lab.ypos, label = scales::percent(prop / 100)), 
            color = "black",size = 4,
            nudge_x = 0.7)+
  scale_fill_manual(values = cols) +
  coord_polar("y", start = 0)+
  theme_void()+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="",
       title = "Pediatric - Trio/Quad")+
  guides(fill = guide_legend(ncol = 2)) 
p4 <- ggplot(example_data4, aes(x = "", y = prop, fill = type)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = lab.ypos, label = scales::percent(prop / 100)), 
            color = "black",size = 4,
            nudge_x = 0.7)+
  scale_fill_manual(values = cols) +
  coord_polar("y", start = 0)+
  theme_void()+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="",
       title = "Prenatal - Proband first")+
  guides(fill = guide_legend(ncol = 2)) 
p5 <- ggplot(example_data5, aes(x = "", y = prop, fill = type)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = lab.ypos, label = scales::percent(prop / 100)), 
            color = "black",size = 4,
            nudge_x = 0.7)+
  scale_fill_manual(values = cols) +
  coord_polar("y", start = 0)+
  theme_void()+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="",
       title = "Prenatal - Duo")+
  guides(fill = guide_legend(ncol = 2)) 
p6 <- ggplot(example_data6, aes(x = "", y = prop, fill = type)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = lab.ypos, label = scales::percent(prop / 100)), 
            color = "black",size = 4,
            nudge_x = 0.7)+
  scale_fill_manual(values = cols) +
  coord_polar("y", start = 0)+
  theme_void()+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(fill="",
       title = "Prenatal - Trio/Quad")+
  guides(fill = guide_legend(ncol = 2)) 

p1 + p2 + p3 + p4 + p5 +p6+
  plot_layout(nrow = 2, guides = "collect")+
  plot_annotation(tag_levels = c("A"))&
    theme(legend.position = "bottom") 

