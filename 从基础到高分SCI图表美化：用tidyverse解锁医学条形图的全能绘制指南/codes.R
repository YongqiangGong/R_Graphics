# 以下是使用 `tidyverse` 包（特别是 `ggplot2`）绘制条形图的详细指南，涵盖基础绘图、自定义调整和高级用法。所有代码示例均以 **可复现的 R 代码** 形式提供，并附带注释说明。
### **数据准备**
# 假设我们有一个模拟的医学实验数据集，包含不同治疗组（`Treatment`）和患者性别（`Sex`）的临床效果评分（`Score`）：

library(tidyverse)

# 生成示例数据
set.seed(123)
data <- tibble(
  Treatment = rep(c("Drug_A", "Drug_B", "Placebo"), each = 20),
  Sex = rep(c("Male", "Female"), 30),
  Score = round(c(rnorm(20, mean = 70, sd = 5),   # Drug_A
                  rnorm(20, mean = 65, sd = 6),   # Drug_B
                  rnorm(20, mean = 60, sd = 4)), 1) # Placebo
)

  
### **1. 基础条形图**
#### 1.1 单变量条形图（计数统计）
# 绘制各治疗组的样本数量分布
data %>%
  ggplot(aes(x = Treatment)) +
  geom_bar(fill = "#4C72B0", width = 0.6) +  # width控制条宽
  labs(title = "Sample Size by Treatment",
       x = "Treatment Group",
       y = "Count") +
  theme_minimal()

#### 1.2 带汇总值的条形图（如均值）
# 计算各治疗组的平均评分
mean_data <- data %>%
  group_by(Treatment) %>%
  summarise(Mean_Score = mean(Score))

# 绘制均值条形图
mean_data %>%
  ggplot(aes(x = Treatment, y = Mean_Score)) +
  geom_col(fill = "#55A868", width = 0.7) +  # 注意使用geom_col而非geom_bar
  labs(title = "Average Score by Treatment",
       x = "Treatment Group",
       y = "Mean Score") +
  theme_classic()

### **2. 分组与堆叠条形图**
#### 2.1 分组条形图（按性别分组）
# 按治疗组和性别分组计算均值
grouped_data <- data %>%
  group_by(Treatment, Sex) %>%
  summarise(Mean_Score = mean(Score), .groups = "drop")

# 绘制分组条形图
grouped_data %>%
  ggplot(aes(x = Treatment, y = Mean_Score, fill = Sex)) +
  geom_col(position = position_dodge(width = 0.8),  # 分组间距
           width = 0.7) +
  scale_fill_manual(values = c("Male" = "#0072B2", "Female" = "#D55E00")) +
  labs(title = "Average Score by Treatment and Sex",
       x = "Treatment Group",
       y = "Mean Score") +
  theme_bw()

#### 2.2 堆叠条形图

grouped_data %>%
  ggplot(aes(x = Treatment, y = Mean_Score, fill = Sex)) +
  geom_col(position = position_stack()) +  # 默认堆叠
  scale_fill_brewer(palette = "Set2") +    # 使用ColorBrewer调色板
  labs(title = "Stacked Bar Chart of Scores",
       x = "Treatment Group",
       y = "Total Score") +
  theme_minimal()

### **3. 坐标轴与标签调整**
#### 3.1 调整坐标轴范围与刻度
mean_data %>%
  ggplot(aes(x = Treatment, y = Mean_Score)) +
  geom_col(fill = "#DDAA33") +
  scale_y_continuous(
    name = "Mean Score (0-100)",  # 修改y轴名称
    limits = c(0, 100),           # 设置y轴范围
    breaks = seq(0, 100, by = 20) # 设置刻度间隔
  ) +
  coord_flip() +  # 翻转坐标轴（横向条形图）
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # 旋转x轴标签

#### 3.2 添加数据标签
grouped_data %>%
  ggplot(aes(x = Treatment, y = Mean_Score, fill = Sex)) +
  geom_col(position = position_dodge(0.8), width = 0.7) +
  geom_text(
    aes(label = round(Mean_Score, 1)),  # 显示一位小数
    position = position_dodge(0.8),     # 与条形图分组对齐
    vjust = -0.5,                       # 标签位于条形上方
    size = 3.5
  ) +
  labs(title = "Bar Chart with Data Labels") +
  theme(legend.position = "top")  # 图例位置调整
### **4. 高级自定义**
#### 4.1 误差线（标准差）

# 计算均值和标准差
summary_data <- data %>%
  group_by(Treatment) %>%
  summarise(
    Mean = mean(Score),
    SD = sd(Score)
  )

# 绘制带误差线的条形图
summary_data %>%
  ggplot(aes(x = Treatment, y = Mean)) +
  geom_col(fill = "#CC79A7", width = 0.6) +
  geom_errorbar(
    aes(ymin = Mean - SD, ymax = Mean + SD),
    width = 0.2,        # 误差线宽度
    color = "black",
    linewidth = 0.5
  ) +
  labs(title = "Mean Score with Error Bars (±1 SD)") +
  theme_light()


#### 4.2 分面（Faceting）

grouped_data %>%
  ggplot(aes(x = Treatment, y = Mean_Score, fill = Sex)) +
  geom_col(position = "dodge") +
  facet_wrap(~ Sex, ncol = 2) +  # 按性别分面
  scale_fill_viridis_d(option = "D") +  # 使用viridis色盲友好色板
  labs(title = "Faceted Bar Chart by Sex") +
  theme(strip.background = element_rect(fill = "#2c3e50"),  # 分面标题背景色
        strip.text = element_text(color = "white"))          # 分面标题文字颜色

  
### **5. 主题与导出**
#### 5.1 自定义主题

custom_theme <- theme(
  plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
  axis.title.x = element_text(size = 12, color = "darkblue"),
  axis.title.y = element_text(size = 12, color = "darkred"),
  panel.grid.major = element_line(colour = "grey80"),
  panel.background = element_rect(fill = "white")
)

mean_data %>%
  ggplot(aes(x = Treatment, y = Mean_Score)) +
  geom_col(fill = "#009E73") +
  labs(title = "Custom Theme Example") +
  custom_theme

#### 5.2 导出高清图

ggsave("barplot.png", 
       width = 8,   # 图片宽度（英寸）
       height = 6,  # 图片高度
       dpi = 300)   # 分辨率（出版级要求）



  
### **关键要点**
#   1. **几何对象选择**：
# - `geom_bar()`：自动计算频数（`stat = "count"`）。
# - `geom_col()`：直接使用预计算的 `y` 值（`stat = "identity"`）。
# 
# 2. **分组与定位**：
# - `position_dodge()`：水平分组。
# - `position_stack()`：垂直堆叠。
# 
# 3. **颜色与填充**：
# - 使用 `scale_fill_*` 和 `scale_color_*` 系列函数调整颜色（如 `scale_fill_manual()`）。
# 
# 4. **标签与注释**：
# - `geom_text()` 或 `geom_label()` 添加数据标签。
# - `labs()` 修改轴标题和图例标题。
# 
# 5. **坐标轴调整**：
# - `scale_x_continuous()` 和 `scale_y_continuous()` 控制刻度。
# - `coord_flip()` 翻转坐标系。
# 
