

install.packages("tidyverse")  # 首次使用需要安装
library(tidyverse)

base_plot <- ggplot(mtcars, 
                    aes(x = wt, 
                        y = mpg)) +
  geom_point(size = 3)

print(base_plot)

base_plot + 
  geom_point(color = "#2E8B57",  # 使用十六进制颜色码
             size = 3)


mtcars %>%
  ggplot(aes(x = wt, y = mpg, 
             color = factor(cyl))) +  # 将cyl转换为因子
  geom_point(size = 3) +
  scale_color_manual(
    name = "气缸数",  # 修改图例标题
    values = c("4" = "#FF6B6B", 
               "6" = "#4ECDC4", 
               "8" = "#556270")  # 自定义颜色
  )




mtcars %>%
  ggplot(aes(x = wt, y = mpg, 
             color = hp)) +  # 马力作为连续变量
  geom_point(size = 3) +
  scale_color_gradient(
    low = "#FFE194", 
    high = "#FF6B6B"  # 渐变色设置
  )

base_plot +
  labs(
    title = "汽车重量与油耗关系",
    subtitle = "数据来源：1974 Motor Trend杂志",
    x = "重量（吨）",
    y = "油耗（英里/加仑）",
    caption = "制图：数据分析师"
  ) +
  theme(plot.title = element_text(size = 16, 
                                  face = "bold",
                                  hjust = 0.5))  # 标题居中



base_plot + 
  theme_bw()  # 黑白主题

base_plot + 
  theme_minimal()  # 极简主题



custom_theme <- theme(
  panel.background = element_rect(fill = "#F5F5F5"),
  panel.grid.major = element_line(color = "#DCDCDC"),
  axis.text.x = element_text(angle = 45,  # X轴标签旋转45度
                             hjust = 1),
  legend.position = "bottom",  # 图例位置
  legend.title = element_text(size = 10),
  plot.background = element_rect(fill = "white")
)

base_plot + custom_theme



base_plot +
  geom_smooth(method = "lm", 
              color = "#FF6B6B",
              se = FALSE)  # 去除置信区间

mtcars %>%
  ggplot(aes(wt, mpg, color = factor(cyl))) +
  geom_point() +
  facet_wrap(~cyl, ncol = 2)  # 按气缸数分面


mtcars %>%
  ggplot(aes(wt, mpg, color = factor(cyl))) +
  geom_point(alpha = 0.7)  # 添加透明度参数



final_plot <- base_plot + custom_theme + labs(title = "最终图表")

ggsave("my_scatterplot.png", 
       plot = final_plot,
       width = 8, 
       height = 6,
       dpi = 300)

mtcars %>%
  ggplot(aes(x = wt, y = mpg, 
             color = factor(cyl))) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_brewer(palette = "Set2") +  # 使用预设调色板
  labs(title = "汽车性能分析",
       x = "重量（吨）",
       y = "油耗（mpg）",
       color = "气缸数") +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(size = 18, 
                              face = "bold",
                              color = "#2c3e50"),
    axis.title = element_text(color = "#34495e")
  )


