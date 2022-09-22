## loading relevant packages
library(dplyr)
library(readr)
library(tidyverse)
library(lubridate)

##clear environment
rm(list=ls(all=TRUE))
memory.limit(2000000)

Carnames <- read.table("Input/post-midterm/G6-Final-2.txt")
##start Batch 2 import
print("importing Batch 2")

Carnames2 <- Carnames[1:20,]
Carnames3 <- Carnames[21:40,]
Carnames4 <- Carnames[41:53,]

G6files <- c()
for (i in 1 : length(Carnames2)){
    G6files[i] <- paste0("D:/Database/G6 Reformated/", Carnames2[i], ".csv")
}
data2a <- data.frame(matrix(nrow=0,ncol = 31))
data2b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G6files)) {
    OBD <- read_csv(file = G6files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,车型 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data2a <-  rbind(data2a, OBD)
    data2b <- rbind(data2b,c(Carnames2[a],MaxEngine,MaxSpeed))
    print(paste(a,Carnames2[a],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data2b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data2a)))
write.csv(data2a, "Output/G6Data/final2_1-20.csv")
#write.csv(data2b, "Output/G6DataInfo/batch2.csv")
data2zero <- subset(data2a, data2a$车速 <= 0.1)
rm(data2a,OBD)
gc()


###start Batch 3 import
print("importing Batch 3")
G6files <- c()
for (i in 1 : length(Carnames3)){
    G6files[i] <- paste0("D:/Database/G6 Reformated/", Carnames3[i], ".csv")
}
data3a <- data.frame(matrix(nrow=0,ncol = 31))
data3b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G6files)) {
    OBD <- read_csv(file = G6files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,车型 = col_character(),转发类型 = col_character()))

    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data3a <-  rbind(data3a, OBD)
    data3b <- rbind(data3b,c(Carnames3[a],MaxEngine,MaxSpeed))
    print(paste(a,Carnames3[a],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data3b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data3a)))
write.csv(data3a, "Output/G6Data/final2_21-40.csv")
#write.csv(data3b, "Output/G6DataInfo/batch3.csv")
data3zero <- subset(data3a, data3a$车速 <= 0.1)
rm(data3a,OBD)
gc()


###start Batch 4 import
print("importing Batch 4")
G6files <- c()
for (i in 1 : length(Carnames4)){
    G6files[i] <- paste0("D:/Database/G6 Reformated/", Carnames4[i], ".csv")
}
data4a <- data.frame(matrix(nrow=0,ncol = 31))
data4b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G6files)) {
    OBD <- read_csv(file = G6files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,车型 = col_character(),转发类型 = col_character()))

    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data4a <-  rbind(data4a, OBD)
    data4b <- rbind(data4b,c(Carnames4[a],MaxEngine,MaxSpeed))
    print(paste(a,Carnames4[a],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data4b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data4a)))
write.csv(data4a, "Output/G6Data/final2_41-53.csv")
# write.csv(data4b, "Output/G6DataInfo/batch4.csv")
data4zero <- subset(data4a, data4a$车速 <= 0.1)
rm(data4a,OBD)
gc()

data2a <- read.csv("D:/Programming/RStudio/OBD Analysis 2nd/Output/G6Data/final2_1-20.csv")
data2zero <- subset(data2a, data2a$车速 <= 0.1)
rm(data2a)
data3a <- read.csv("D:/Programming/RStudio/OBD Analysis 2nd/Output/G6Data/final2_21-40.csv")
data3zero <- subset(data3a, data3a$车速 <= 0.1)
rm(data3a)
data4a <- read.csv("D:/Programming/RStudio/OBD Analysis 2nd/Output/G6Data/final2_41-53.csv")
data4zero <- subset(data4a, data4a$车速 <= 0.1)
rm(data4a)
data2_zero <- rbind(data2zero,data3zero,data4zero)
rm(data2zero,data3zero,data4zero)

##Calculate the occurrance of operation status based on Speed, Engine and Torque.
DFU2 <- read.csv("Input/UniqueDataTemplate.csv", header = TRUE)
stats1 <- data.frame(matrix(ncol = 1, nrow=0))
colnames(stats1) <- c("Drive_count")
for (k in 1 : nrow(DFU2)){
    sub3 <- subset(data2_zero, data2_zero$Engine == DFU2$Engine[k] & data2_zero$Torque2 == DFU2$Torque[k]
                   , select = c(Torque2))
    sub4 <- nrow(sub3)
    stats1 <- rbind(stats1,sub4)
}
DFU2o <- cbind(DFU2, stats1)
write.csv(DFU2o, "C:/Users/admin/OneDrive/文档/53TrucksOperationStill.csv")


##Cleanse the data and keep only parts that are used to calculate emission
data2_zero <- data2_zero[(data2_zero$SCR上游NOx传感器输出值 <= 3000 & data2_zero$SCR下游NOx传感器输出值 <= 3000 & data2_zero$SCR上游NOx传感器输出值 >= 1 &
                              data2_zero$SCR下游NOx传感器输出值 >= 1 & data2_zero$进气量 <= 3212 & data2_zero$进气量 >= 0 & data2_zero$发动机燃料流量 <= 100),]
data2_zero <- data2_zero[!(is.na(data2_zero$SCR上游NOx传感器输出值) | is.na(data2_zero$SCR下游NOx传感器输出值) | is.na(data2_zero$进气量)),]

Ratio_NO_G6 <- exp(4.805287) / (1+exp(4.805287))
Ratio_NO2_G6 <- 1 - Ratio_NO_G6
Ratio_NO_G5 <- exp(2.092286) / (1+exp(2.092286))
Ratio_NO2_G5 <- 1 - Ratio_NO_G5

NOx_m_G6 <- 30/29 * Ratio_NO_G6 + 46/29 * Ratio_NO2_G6
NOx_m_G5 <- 30/29 * Ratio_NO_G5 + 46/29 * Ratio_NO2_G5

data2_zero$NOx_up_g_s <- data2_zero$SCR上游NOx传感器输出值 * (data2_zero$进气量 + data2_zero$发动机燃料流量 * 0.85) * 0.95 / 3.6 * NOx_m_G6 * 10^-6 
data2_zero$NOx_down_g_s <- data2_zero$SCR下游NOx传感器输出值 * (data2_zero$进气量 + data2_zero$发动机燃料流量 * 0.85) *0.95 / 3.6 * NOx_m_G6 * 10^-6
data2_zero$NOx_up_g_km <- data2_zero$NOx_up_g_s/ data2_zero$车速 * 3.6 * 1000
data2_zero$NOx_down_g_km <- data2_zero$NOx_down_g_s / data2_zero$车速 * 3.6 * 1000

##Calculate the occurrance of emission and mean values based on Speed, Engine and Torque.
stats2 <- data.frame(matrix(ncol = 9, nrow=0))
colnames(stats2) <- c("Emission_count", "NOx_up_g_s_mean", "NOx_up_g_s_sd","NOx_down_g_s_mean", "NOx_down_g_s_sd"
                      ,"NOx_up_g_km_mean", "NOx_up_g_km_sd","NOx_down_g_km_mean", "NOx_down_g_km_sd")
for (k in 1 : nrow(DFU2)){
    sub3 <- subset(data2_zero, data2_zero$Engine == DFU2$Engine[k] & data2_zero$Torque2 == DFU2$Torque[k]
                   , select = c(NOx_up_g_s, NOx_down_g_s,NOx_up_g_km,NOx_down_g_km))
    sub4 <- c(nrow(sub3), mean(sub3$NOx_up_g_s), sd(sub3$NOx_up_g_s), mean(sub3$NOx_down_g_s), sd(sub3$NOx_down_g_s)
              , mean(sub3$NOx_up_g_km), sd(sub3$NOx_up_g_km), mean(sub3$NOx_down_g_km), sd(sub3$NOx_down_g_km))
    stats2 <- rbind(stats2,sub4)
}
DFU2e2 <- cbind(DFU2o,stats2)
colnames(DFU2e2) <- c("X","Engine","Torque", "Drive_count","Emission_count"
                     ,"NOx_up_g_s_mean", "NOx_up_g_s_sd","NOx_down_g_s_mean", "NOx_down_g_s_sd"
                     ,"NOx_up_g_km_mean", "NOx_up_g_km_sd","NOx_down_g_km_mean", "NOx_down_g_km_sd")
write.csv(DFU2e2, "C:/Users/admin/OneDrive/文档/53TrucksEmissionStill_2.csv")

rm(data2,data2_zero,OBD)

