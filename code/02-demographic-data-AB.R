read.csv(file = "data/crab-metadata.csv", header = FALSE)
class(dat)
dat <- read.csv(file = "data/crab-metadata.csv", header = FALSE)
head(dat)
class(dat)
dim(dat)
dat[1,3]
dat[2:156, ]
dat[]
weight <- dat[2:156,9]
length <- dat[2:156,8]
sex <- dat[2:156,5]
max(weight)
max(length)
max(weight)
weight <- dat[2:156,9]
max(weight)
width <- dat[2:156,7]
max(width)
mean(dat[, 7])
mean(width)
summary(dat[7:9, ])
mean(width)
x <- data.frame(X_1 = c(NA, "Title", 1:3),
                X_2 = c(NA, "Title2", 4:6))
x %>%
  row_to_names(row_number = 2)
colnames(df) <- as.character(df[1, ])
df <- data.frame
read.csv(file = "data/crab-metadata.csv", header = TRUE, row.names = 1)
mean(width)
dat <- read.csv(file = "data/crab-metadata.csv", header = TRUE, row.names = 1)
head(dat)
mean(weight)
class(dat)
dim(dat)
max(weight)
max(width)
mean(width)
width <- dat[ , 6]
max(width)
mean(width)
weight <- dat[ , 8]
mean(weight)
length <- dat[ , 7]
mean(length)
sd(length)
summary(dat[ , 6:8])
plot(weight)
plot(weight, length)
sex <- dat[ , 4]
plot(weight, sex)
plot(weight, height)
max(height)
plot(weight,length)
color <- dat[ , 5]
sort(color)
histogram(weight,width)
vec <- as.character(c(M,F))
vec
install.packages("tidyverse") # Installing Tidyverse
require(tidyverse)
Male.data <- dat %>% # filter male data
  filter(sex == "M")
plot(Male.data$weight, Male.data$carapace.length)
Female.data <- dat%>% #filter female data
  filter(sex == "F")
plot(Female.data$weight, Female.data$carapace.length)
sessionInfo() #shift + command + c to turn all into comment
# R version 4.5.2 (2025-10-31)
# Platform: aarch64-apple-darwin20
# Running under: macOS Sequoia 15.7.3
# 
# Matrix products: default
# BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib 
# LAPACK: /Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.1
# 
# locale:
#   [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
# 
# time zone: America/Los_Angeles
# tzcode source: internal
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] lubridate_1.9.4 forcats_1.0.1   stringr_1.6.0   dplyr_1.1.4     purrr_1.2.1    
# [6] readr_2.1.6     tidyr_1.3.2     tibble_3.3.1    ggplot2_4.0.1   tidyverse_2.0.0
# 
# loaded via a namespace (and not attached):
#   [1] vctrs_0.7.0        cli_3.6.5          rlang_1.1.7        stringi_1.8.7     
# [5] generics_0.1.4     S7_0.2.1           glue_1.8.0         hms_1.1.4         
# [9] scales_1.4.0       grid_4.5.2         tzdb_0.5.0         lifecycle_1.0.5   
# [13] compiler_4.5.2     RColorBrewer_1.1-3 timechange_0.3.0   pkgconfig_2.0.3   
# [17] rstudioapi_0.18.0  farver_2.1.2       R6_2.6.1           tidyselect_1.2.1  
# [21] pillar_1.11.1      magrittr_2.0.4     tools_4.5.2        withr_3.0.2       
# [25] gtable_0.3.6      
getInfo()
getInfo()
getInfo()
getinfo()
sessioninfo()
class(dat)
require(tidyverse)
getinfo()
getinfo()
sessionInfo()
# # R version 4.5.2 (2025-10-31 ucrt)
# Platform: x86_64-w64-mingw32/x64
# Running under: Windows 11 x64 (build 26100)
# 
# Matrix products: default
# LAPACK version 3.12.1
# 
# locale:
#   [1] LC_COLLATE=English_United States.utf8 
# [2] LC_CTYPE=English_United States.utf8   
# [3] LC_MONETARY=English_United States.utf8
# [4] LC_NUMERIC=C                          
# [5] LC_TIME=English_United States.utf8    
# 
# time zone: America/Los_Angeles
# tzcode source: internal
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods  
# [7] base     
# 
# other attached packages:
#   [1] lubridate_1.9.4 forcats_1.0.1   stringr_1.6.0   dplyr_1.1.4    
# [5] purrr_1.2.1     readr_2.1.6     tidyr_1.3.2     tibble_3.3.1   
# [9] ggplot2_4.0.2   tidyverse_2.0.0
# 
# loaded via a namespace (and not attached):
#   [1] vctrs_0.7.1        cli_3.6.5          rlang_1.1.7       
# [4] stringi_1.8.7      generics_0.1.4     S7_0.2.1          
# [7] glue_1.8.0         hms_1.1.4          scales_1.4.0      
# [10] grid_4.5.2         tzdb_0.5.0         lifecycle_1.0.5   
# [13] compiler_4.5.2     RColorBrewer_1.1-3 timechange_0.4.0  
# [16] pkgconfig_2.0.3    rstudioapi_0.18.0  farver_2.1.2      
# [19] R6_2.6.1           tidyselect_1.2.1   pillar_1.11.1     
# [22] magrittr_2.0.4     tools_4.5.2        withr_3.0.2       
# # [25] gtable_0.3.6     
#loading the data
read.csv(file = "../data/time-to-right.csv", header = TRUE)
group_by(tank)
crab.dat <- read.csv(file = "../data/time-to-right.csv", header = TRUE)
read(crab.dat)
head(crab.dat)
%>% crab.dat
group_by(tank)
crab.dat %>% 
  summarize(tank)
crab.dat %>% 
  group_by(tank)
crab.dat %>% 
  summarize(tank)
crab.dat %>% 
  count(sex)
crab.dat %>% 
  mean(weight)
mean(weight)
#summarizing the entire dataset mean weight
crab.dat %>% 
  summarize(mean(weight))
crab.dat %>% 
  filter(tank == "T1") %>% 
  count(sex = M)
# filtering into only tank 1
crab.dat %>% 
  filter(tank == "T1")
tank.one <- crab.dat %>% 
  filter(tank == "T1")
tank.one
tank.one %>% 
  count(sex = "M" , "F")
# counting how many males/females are in tank 1
tank.one %>% 
  count(sex = "M")
tank.one %>% 
  count(sex = "F")
tank.one %>% 
  summarize
summarize(tank.one)
tank.one %>% 
  filter(sex == "M")
male.t.one <- tank.one %>% 
  filter(sex == "M")
count(male.t.one)
tank.one %>% 
  filter(sex == "F")
female.t.one <- tank.one %>% 
  filter(sex == "F")
count(female.t.one)
tank.one %>% 
  mean(weight)
tank.one %>% 
  group_by(integument.color)
tank.one %>% 
  sort(integument.color)
tank.one %>% 
  mean(weight , na.rm = TRUE)
load(tidyverse)
require(tidyverse)
head(tank.one)
str(tank.one)
crab.dat %>% 
  group_by(tank) %>% 
  summarize(mean.tank.weight = mean(weight, na.rm = TRUE)) #finding the mean weight for each tank
crab.dat %>% 
  group_by(sex) %>% 
  count("M" , "F") #counting the number of males and females in total
treatment.5 <- crab.dat %>% 
  