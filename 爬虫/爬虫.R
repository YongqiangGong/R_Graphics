# 1.爬虫 --------------------------------------------------------------------

# 加载R包，未安装的话先安装

library(tidyverse)
library(rvest)

# 爬取网址`read_html`

html <- read_html("http://rvest.tidyverse.org/")
html

# 自己构建一个html，使用函数`minimal_html`

html <- minimal_html("
  <p>This is a paragraph</p>
  <ul>
    <li>This is a bulleted list</li>
  </ul>
")
html

# 我们构建一个html，进行演示

html <- minimal_html("
  <h1>This is a heading</h1>
  <p id='first'>This is a paragraph</p>
  <p class='important'>This is an important paragraph</p>
")

# 函数`html_elements`爬取所有对应的属性

html |> html_elements("li")#爬取所有li属性

html |> html_elements(".important")#爬取所有包括important属性

html |> html_elements("#first")#爬取所有属性是first的条目

# 函数`html_element`爬取第一个对应的属性
html |> html_element("p")

# 函数`html_element`和函数`html_elements`区别

#构建一个示例
html <- minimal_html("
  <ul>
    <li><b>C-3PO</b> is a <i>droid</i> that weighs <span class='weight'>167 kg</span></li>
    <li><b>R4-P17</b> is a <i>droid</i></li>
    <li><b>R2-D2</b> is a <i>droid</i> that weighs <span class='weight'>96 kg</span></li>
    <li><b>Yoda</b> weighs <span class='weight'>66 kg</span></li>
  </ul>
  ")
# `html_element`
characters |> html_element(".weight")

# `html_elements`
characters |> html_elements(".weight")

# 函数`html_text2`提取文本

characters |> 
  html_element("b") |> 
  html_text2()

characters |> 
  html_element(".weight") |> 
  html_text2()

# 函数`html_attr`提取属性对应值

html <- minimal_html("
  <p><a href='https://en.wikipedia.org/wiki/Cat'>cats</a></p>
  <p><a href='https://en.wikipedia.org/wiki/Dog'>dogs</a></p>
")

html |> 
  html_elements("p") |> 
  html_element("a") |> 
  html_attr("href")

# 函数`html_table`提取表格

html <- minimal_html("
  <table class='mytable'>
    <tr><th>x</th>   <th>y</th></tr>
    <tr><td>1.5</td> <td>2.7</td></tr>
    <tr><td>4.9</td> <td>1.3</td></tr>
    <tr><td>7.2</td> <td>8.1</td></tr>
  </table>
  ")

html |> 
  html_element(".mytable") |> 
  html_table()


# 完整示例

url <- "https://rvest.tidyverse.org/articles/starwars.html"
html <- read_html(url)

section <- html |> html_elements("section")
section

tibble(
  title = section |> 
    html_element("h2") |> 
    html_text2(),
  released = section |> 
    html_element("p") |> 
    html_text2() |> 
    str_remove("Released: ") |> 
    parse_date(),
  director = section |> 
    html_element(".director") |> 
    html_text2(),
  intro = section |> 
    html_element(".crawl") |> 
    html_text2()
)
