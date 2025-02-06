# 3.分层数据 ------------------------------------------------------------------

# 加载R包，未安装先安装
library(tidyverse)
library(repurrrsive)
library(jsonlite)

# 列表
## 列表可以存储各种类型的数据
x1 <- list(1:4, "a", TRUE)
x1
##  我们可以命名列表
x2 <- list(a = 1:2, b = 1:3, c = 1:4)
x2

## 使用`str`函数查看列表结构

str(x1)
str(x2)

## 列表可以多层次构建
x3 <- list(list(1, 2), list(3, 4))
str(x3)

## 看看有什么不一样的地方
c(c(1, 2), c(3, 4))
x4 <- c(list(1, 2), list(3, 4))
str(x4)

## 构建一个多层次的列表
x5 <- list(1, list(2, list(3, list(4, list(5)))))
str(x5)

## 把列表放到数据框里面
df <- tibble(
  x = 1:2, 
  y = c("a", "b"),
  z = list(list(1, 2), list(3, 4, 5))
)
df

# 取消嵌套

## 我们把列表放到数据框里面
df1 <- tribble(
  ~x, ~y,
  1, list(a = 11, b = 12),
  2, list(a = 21, b = 22),
  3, list(a = 31, b = 32),
)

df2 <- tribble(
  ~x, ~y,
  1, list(11, 12, 13),
  2, list(21),
  3, list(31, 32),
)

## 使用函数`unnest_wider`拆分列表
df1 |> 
  unnest_wider(y)

## 函数`names_sep`更改名字
df1 |> 
  unnest_wider(y, names_sep = "_")

## 使用函数`unnest_longer`拆分列表
df2 |> 
  unnest_longer(y)

## 列表里面有空值会怎么样

df6 <- tribble(
  ~x, ~y,
  "a", list(1, 2),
  "b", list(3),
  "c", list()
)
df6 |> unnest_longer(y)

## 使用参数`keep_empty = TRUE`保留空值

df6 |> unnest_longer(y,keep_empty = TRUE)

