# 1.挂带表格的韦恩图 ----------------------------------------------------------------


# install.packages("tidyverse")
# install.packages("ggvenn")
# install.packages("ggpmisc")
# install.packages("randomcoloR")

library(randomcoloR)
library(ggpmisc)
library(tidyverse)
library(ggvenn)

cols <- distinctColorPalette(7)
genes <- data.frame(genes=c('BLM','SLC12A4','ZBTB45','ZCCHC4',
                            'RAD1'))
example_data <- list(
  `Wildtype Lost or Inacvated`=c('PALB2','LLGL2','VSIG1','LTBP1', 
                                 'BLM','SLC12A4','ZBTB45','ZCCHC4',
                                 'RAD1','LOXL2','GPALPP1','CDKL3',
                                 'FAM216A','ATM','FANCM','MAP6D1',
                                 'STARD6','IFIT2','MIPOL1','SLC38A8',
                                 'SCYL3','HARS2','CDH23'),
  `Variant Lost or Inacvated`=c('LOXL2','GPALPP1','CDKL3','FAM216A',
                                'BLM','SLC12A4','ZBTB45','ZCCHC4',
                                'RAD1','CPT1B','WRAP53','RASSF7','ANKRD18A',
                                'ERCC3','SORD','SSX3','IMPDH2','CCDC14','CARMIL2',
                                'USP50','PLEKHA4'),
  `Heterozygous or Indeterminate`=c('ATM','FANCM','MAP6D1',
                                    'STARD6','IFIT2','MIPOL1','SLC38A8',
                                    'SCYL3','HARS2','CDH23','BLM','SLC12A4','ZBTB45','ZCCHC4',
                                    'RAD1','ERCC3','SORD','SSX3','IMPDH2','CCDC14','CARMIL2',
                                    'USP50','PLEKHA4','MRE11A','RPA3','CCDC88B','FBLIM1','TTC24'
                                    ,'ANKAR','MMAA','ZNF418','LRRC56','PRKACG','ZNF616','TBXAS1'
                                    ,'ADGRD1','DLGAP5')
)


ggvenn(
  data=example_data,#数据列表
  columns=c("Wildtype Lost or Inacvated",
            "Variant Lost or Inacvated",
            "Heterozygous or Indeterminate"),#对选中的列名绘图，最多选择4个，NULL为默认全选
  show_elements=F,#当为TRUE时，显示具体的交集情况，而不是交集个数
  label_sep="\n",#当show_elements=T时生效
  show_percentage=T,#显示每一组的百分比
  digits=1,#百分比的小数点位数
  fill_color=cols,#填充颜色
  fill_alpha=0.5,#填充透明度
  stroke_color="white",#边缘颜色
  stroke_alpha=0.5,#边缘透明度
  stroke_size=0.5,#边缘粗细
  stroke_linetype="solid",#边缘线条#实线：solid 虚线：twodash longdash 点：dotdash dotted dashed 无：blank
  set_name_color="black",#组名颜色
  set_name_size=4,#组名大小
  text_color="black",#交集个数颜色
  text_size=4#交集个数文字大小
)+
  annotate(geom = "table",x = 1.6,y = 0.2,size=6,
           label = list(cbind(genes)))

