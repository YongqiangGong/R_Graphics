

# 2、优雅条形图的绘制 ----------------------------------------------------------------

# install.packages("tidyverse")
# install.packages("randomcoloR")

library(randomcoloR)
library(tidyverse)

cols <- distinctColorPalette(6)
axis_x_name <- c('GLE-Ovary_common_SBS1+18', 
                 'GLE-Ovary_common_SBS13',
                 'GLE-Ovary_common_SBS17',
                 'GLE-Ovary_common_SBS3' ,
                 'GLE-Ovary_common_SBS5' ,
                 'GLE-Ovary_common_SBS8')
example_data <- data.frame(
  `one` = runif(30, min = 20, max = 100),
  `two` = runif(30, min = 0, max = 40),
  `three` = runif(30, min = 0, max = 10),
  `four` = runif(30, min = 50, max = 150),
  `five` = runif(30, min = 0, max = 70),
  `six` = runif(30, min = 10, max = 60)
)
example_data <- example_data %>% 
  pivot_longer(cols = starts_with("one"):starts_with("six"), 
               names_to = "variants", 
               values_to = "count") 


ggplot(example_data, aes(x = variants, y = count, fill = variants)) +
  geom_boxplot(width=0.2)+
  stat_boxplot(geom='errorbar',width=0.3,
               position=position_dodge(1))+
  geom_rect(data =example_data,
            aes(xmin = as.numeric(factor(variants)) - 0.4,  
                xmax = as.numeric(factor(variants)) + 0.4
            ), fill = "pink",
            ymin = -Inf, ymax = Inf, alpha = 0.01)+
  scale_fill_manual(values = cols) +  # 确保cols已定义
  scale_x_discrete(labels = axis_x_name) +  # 确保axis_x_name已定义
  scale_y_continuous(limits = c(0, 160), 
                     breaks = seq(0, 160, by = 20),
                     expand = c(0, 0)) +
  theme_bw()+
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, vjust=1,hjust = 1),
    plot.title = element_text(hjust = 0.5),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(linewidth = 0.6),
    panel.grid.major.y = element_line(linewidth = 0.6),  # 保留纵向网格线
    panel.grid.major.x = element_blank(),  # 去掉横向网格线
    panel.border = element_blank()
  ) +
  labs(
    y = "Contribution(count)",
    x = "",
    title = "PALB2,227 variants"
  )+
  annotate( 
    geom = "text", x = 1, y =156 ,  # 设置文本注释的位置
    label = "27%", hjust = 0.5, vjust = 0.5, size = 4
  )+
  annotate( 
    geom = "text", x = 2, y =156 ,  # 设置文本注释的位置
    label = "11%", hjust = 0.5, vjust = 0.5, size = 4
  )+
  annotate( 
    geom = "text", x = 4, y =156 ,  # 设置文本注释的位置
    label = "45%", hjust = 0.5, vjust = 0.5, size = 4
  )


