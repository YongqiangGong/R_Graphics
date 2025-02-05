
# 2.读取数据 ------------------------------------------------------------------

# 加载R包，未安装先安装
library(readxl)
library(tidyverse)
library(writexl)

# -read_xls()读取格式为xls的Excel 文件。
# -read_xlsx()阅读有格式的xlsx的Excel 文件。
# -read_excel()可以读取同时具有xls和xlsx格式的文件。

# 读取工作薄

# 函数`read_excel`读取数据
students <- read_excel("data/students.xlsx")

# 参数`col_names`确定列名
read_excel(
  "data/students.xlsx",
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age")
)

# 参数`skip`跳过几行数据
read_excel(
  "data/students.xlsx",
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"),
  skip = 1
)

# 参数`na`定义缺失值
read_excel(
  "data/students.xlsx",
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"),
  skip = 1,
  na = c("", "N/A")
)

# 参数`col_types`确定列的属性
read_excel(
  "data/students.xlsx",
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"),
  skip = 1,
  na = c("", "N/A"),
  col_types = c("numeric", "text", "text", "text", "numeric")
)

# 读取工作表

# 参数`sheet`确定工作簿中的工作表
read_excel("data/penguins.xlsx", sheet = "Torgersen Island")

# 参数`na`定义缺失值
penguins_torgersen <- read_excel("data/penguins.xlsx", 
                                 sheet = "Torgersen Island", 
                                 na = "NA")
penguins_torgersen

# 函数`excel_sheets`读取所有工作表名称
excel_sheets("data/penguins.xlsx")
penguins_biscoe <- read_excel("data/penguins.xlsx", 
                              sheet = "Biscoe Island", 
                              na = "NA")
penguins_dream  <- read_excel("data/penguins.xlsx", 
                              "Dream Island", 
                              na = "NA")
# 函数`bind_rows`合并列名一样的工作表
penguins <- bind_rows(penguins_torgersen, penguins_biscoe, penguins_dream)
penguins

# 参数`range`提取工作表中的部分数据
deaths_path <- readxl_example("deaths.xlsx")#示例数据
deaths <- read_excel(deaths_path)
read_excel(deaths_path, range = "A5:F15")

# 写入数据

# 创建数据框
bake_sale <- tibble(
  item     = factor(c("brownie", "cupcake", "cookie")),
  quantity = c(10, 5, 8)
)

# 函数`write_xlsx`写入表格
write_xlsx(bake_sale, path = "data/bake-sale.xlsx")

# 谷歌表格（很少用，简单了解即可）

# 加载R包，未安装先安装
library(googlesheets4)
library(tidyverse)

# 读取数据
students_sheet_id <- "1V1nPp1tzOuutXFLb3G9Eyxi3qxeEhnOXUzL5_BcCQ0w"
students <- read_sheet(students_sheet_id)

# 参数用法基本一样（列的属性除外）
students <- read_sheet(
  students_sheet_id,
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"),
  skip = 1,
  na = c("", "N/A"),
  col_types = "dcccc"
)

# 读取特定工作表
penguins_sheet_id <- "1aFu8lnD_g0yjF5O-K6SFgSEWiHPpgvFCF0NY9D6LXnY"
read_sheet(penguins_sheet_id, sheet = "Torgersen Island")

# 所有工作表名称
sheet_names(penguins_sheet_id)
deaths_url <- gs4_example("deaths")

# 读取工作表特定范围
deaths <- read_sheet(deaths_url, range = "A5:F15")

# 写入数据
write_sheet(bake_sale, ss = "bake-sale")
write_sheet(bake_sale, ss = "bake-sale", sheet = "Sales")#写入特定工作表