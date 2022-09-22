## loading relevant packages
library(dplyr)
library(readr)
library(tidyverse)
library(lubridate)

##clear environment
rm(list=ls(all=TRUE))
memory.limit(2000000)

##accquire selected car data 
##all datasets with more than 10000 rows are divided into 7 batches to be feed into the script
##start Batch 1 import
print("importing Batch 1")
Carnames1 <- read.table("Input/post-midterm/G5-Ent1.txt")
G5files <- c()
for (i in 1 : nrow(Carnames1)){
    G5files[i] <- paste0("D:/Database/G5 Reformated/", Carnames1[i,], ".csv")
}
data1a <- data.frame(matrix(nrow=0,ncol = 31))
data1b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G5files)) {
    OBD <- read_csv(file = G5files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,排放标准 = col_character(),转发类型 = col_character()))

    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data1a <-  rbind(data1a, OBD)
    data1b <- rbind(data1b,c(Carnames1[a,],MaxEngine,MaxSpeed))
    print(paste(a,Carnames1[a,],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data1b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data1a)))
write.csv(data1a, "Output/G5Data/batch1.csv")
write.csv(data1b, "Output/G5DataInfo/batch1.csv")
rm(data1a,OBD)
gc()


##start Batch 2 import
print("importing Batch 2")
Carnames2 <- read.table("Input/post-midterm/G5-Ent2.txt")
G5files <- c()
for (i in 1 : nrow(Carnames2)){
    G5files[i] <- paste0("D:/Database/G5 Reformated/", Carnames2[i,], ".csv")
}
data2a <- data.frame(matrix(nrow=0,ncol = 31))
data2b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G5files)) {
    OBD <- read_csv(file = G5files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,排放标准 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data2a <-  rbind(data2a, OBD)
    data2b <- rbind(data2b,c(Carnames2[a,],MaxEngine,MaxSpeed))
    print(paste(a,Carnames2[a,],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data2b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data2a)))
write.csv(data2a, "Output/G5Data/batch2.csv")
write.csv(data2b, "Output/G5DataInfo/batch2.csv")
rm(data2a,OBD)
gc()


###start Batch 3 import
print("importing Batch 3")
Carnames3 <- read.table("Input/post-midterm/G5-Ent3.txt")
G5files <- c()
for (i in 1 : nrow(Carnames3)){
    G5files[i] <- paste0("D:/Database/G5 Reformated/", Carnames3[i,], ".csv")
}
data3a <- data.frame(matrix(nrow=0,ncol = 31))
data3b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G5files)) {
    OBD <- read_csv(file = G5files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,排放标准 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data3a <-  rbind(data3a, OBD)
    data3b <- rbind(data3b,c(Carnames3[a,],MaxEngine,MaxSpeed))
    print(paste(a,Carnames3[a,],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data3b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data3a)))
write.csv(data3a, "Output/G5Data/batch3.csv")
write.csv(data3b, "Output/G5DataInfo/batch3.csv")
rm(data3a,OBD)
gc()


###start Batch 4 import
print("importing Batch 4")
Carnames4 <- read.table("Input/post-midterm/G5-Ent4.txt")
G5files <- c()
for (i in 1 : nrow(Carnames4)){
    G5files[i] <- paste0("D:/Database/G5 Reformated/", Carnames4[i,], ".csv")
}
data4a <- data.frame(matrix(nrow=0,ncol = 31))
data4b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G5files)) {
    OBD <- read_csv(file = G5files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,排放标准 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data4a <-  rbind(data4a, OBD)
    data4b <- rbind(data4b,c(Carnames4[a,],MaxEngine,MaxSpeed))
    print(paste(a,Carnames4[a,],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data4b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data4a)))
write.csv(data4a, "Output/G5Data/batch4.csv")
write.csv(data4b, "Output/G5DataInfo/batch4.csv")
rm(data4a,OBD)
gc()

###start Batch 5 import
print("importing Batch 5")
Carnames5 <- read.table("Input/post-midterm/G5-Ent5.txt")
G5files <- c()
for (i in 1 : nrow(Carnames5)){
    G5files[i] <- paste0("D:/Database/G5 Reformated/", Carnames5[i,], ".csv")
}
data5a <- data.frame(matrix(nrow=0,ncol = 31))
data5b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G5files)) {
    OBD <- read_csv(file = G5files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,排放标准 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data5a <-  rbind(data5a, OBD)
    data5b <- rbind(data5b,c(Carnames5[a,],MaxEngine,MaxSpeed))
    print(paste(a,Carnames5[a,],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data5b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data5a)))
write.csv(data5a, "Output/G5Data/batch5.csv")
write.csv(data5b, "Output/G5DataInfo/batch5.csv")
rm(data5a,OBD)
gc()


###start Batch 6 import
print("importing Batch 6")
Carnames6 <- read.table("Input/post-midterm/G5-Ent6.txt")
G5files <- c()
for (i in 1 : nrow(Carnames6)){
    G5files[i] <- paste0("D:/Database/G5 Reformated/", Carnames6[i,], ".csv")
}
data6a <- data.frame(matrix(nrow=0,ncol = 31))
data6b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G5files)) {
    OBD <- read_csv(file = G5files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,排放标准 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data6a <-  rbind(data6a, OBD)
    data6b <- rbind(data6b,c(Carnames6[a,],MaxEngine,MaxSpeed))
    print(paste(a,Carnames6[a,],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data6b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data6a)))
write.csv(data6a, "Output/G5Data/batch6.csv")
write.csv(data6b, "Output/G5DataInfo/batch6.csv")
rm(data6a,OBD)
gc()

###start Batch 7 import
print("importing Batch 7")
Carnames7 <- read.table("Input/post-midterm/G5-Ent7.txt")
G5files <- c()
for (i in 1 : nrow(Carnames7)){
    G5files[i] <- paste0("D:/Database/G5 Reformated/", Carnames7[i,], ".csv")
}
data7a <- data.frame(matrix(nrow=0,ncol = 31))
data7b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G5files)) {
    OBD <- read_csv(file = G5files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,排放标准 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data7a <-  rbind(data7a, OBD)
    data7b <- rbind(data7b,c(Carnames7[a,],MaxEngine,MaxSpeed))
    print(paste(a,Carnames7[a,],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data7b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data7a)))
write.csv(data7a, "Output/G5Data/batch7.csv")
write.csv(data7b, "Output/G5DataInfo/batch7.csv")
rm(data7a,OBD)
gc()

###start Batch 8 import
print("importing Batch 8")
Carnames8 <- read.table("Input/post-midterm/G5-Ent8.txt")
G5files <- c()
for (i in 1 : nrow(Carnames8)){
    G5files[i] <- paste0("D:/Database/G5 Reformated/", Carnames8[i,], ".csv")
}
data8a <- data.frame(matrix(nrow=0,ncol = 31))
data8b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G5files)) {
    OBD <- read_csv(file = G5files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,排放标准 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data8a <-  rbind(data8a, OBD)
    data8b <- rbind(data8b,c(Carnames8[a,],MaxEngine,MaxSpeed))
    print(paste(a,Carnames8[a,],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data8b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data8a)))
write.csv(data8a, "Output/G5Data/batch8.csv")
write.csv(data8b, "Output/G5DataInfo/batch8.csv")
rm(data8a,OBD)
gc()

###start Batch 9 import
print("importing Batch 9")
Carnames9 <- read.table("Input/post-midterm/G5-Ent9.txt")
G5files <- c()
for (i in 1 : nrow(Carnames9)){
    G5files[i] <- paste0("D:/Database/G5 Reformated/", Carnames9[i,], ".csv")
}
data9a <- data.frame(matrix(nrow=0,ncol = 31))
data9b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G5files)) {
    OBD <- read_csv(file = G5files[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,排放标准 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data9a <-  rbind(data9a, OBD)
    data9b <- rbind(data9b,c(Carnames9[a,],MaxEngine,MaxSpeed))
    print(paste(a,Carnames9[a,],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data9b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data9a)))
write.csv(data9a, "Output/G5Data/batch9.csv")
write.csv(data9b, "Output/G5DataInfo/batch9.csv")
rm(data9a,OBD)
gc()

#Combine the 9 datasets in data, and create DF1
data_b <- rbind(data1b,data2b,data3b,data4b,data5b,data6b,data7b,data8b,data9b)
write.csv(data_b, "Output/G5DataInfo/AllG5Cars.csv")

data <- rbind(read.csv("Output/G5Data/batch1.csv"), read.csv("Output/G5Data/batch2.csv"), read.csv("Output/G5Data/batch3.csv")
            , read.csv("Output/G5Data/batch4.csv"), read.csv("Output/G5Data/batch5.csv"), read.csv("Output/G5Data/batch6.csv")
            , read.csv("Output/G5Data/batch7.csv"), read.csv("Output/G5Data/batch8.csv"), read.csv("Output/G5Data/batch9.csv"))

data$SCR上游NOx传感器输出值[is.na(data$SCR上游NOx传感器输出值)] <- 0
data$SCR下游NOx传感器输出值[is.na(data$SCR下游NOx传感器输出值)] <- 0
data$SCR监测值 <- data$SCR上游NOx传感器输出值 + data$SCR下游NOx传感器输出值
data$SCR上游NOx传感器输出值 <- NULL
data$SCR下游NOx传感器输出值 <- NULL
data <- data[!(data$SCR监测值 > 3000 |  data$SCR监测值 <= 1),]
data <- data[(data$进气量 <= 3212 & data$进气量 >= 0 & data$发动机燃料流量 <= 100),]
data <- data[!(is.na(data$进气量)),]

Ratio_NO_G6 <- exp(4.805287) / (1+exp(4.805287))
Ratio_NO2_G6 <- 1 - Ratio_NO_G6
Ratio_NO_G5 <- exp(2.092286) / (1+exp(2.092286))
Ratio_NO2_G5 <- 1 - Ratio_NO_G5

NOx_m_G6 <- 30/29 * Ratio_NO_G6 + 46/29 * Ratio_NO2_G6
NOx_m_G5 <- 30/29 * Ratio_NO_G5 + 46/29 * Ratio_NO2_G5



data$NOxdown1 <- data$SCR监测值 * (data$进气量 + data$发动机燃料流量 * 0.85) *0.95 / 3.6 * NOx_m_G5 * 10^-6
data$NOxdown2 <- data$NOxdown1 / data$车速 * 3.6 * 1000

##从全部卡车数据中选取一台车
VIN <- unique(data$vin)
DFU <- read.csv("Input/UniqueDataTemplate.csv",header = TRUE)
colnames(DFU) <- c("X", "Engine", "Torque")
Truckinfo <- data.frame(matrix(ncol = 5, nrow=0))
colnames(Truckinfo) <- c("VIN","total","nonzero","nonzeroemission","zeroemssion")
for (c in 1 : length(VIN)){
    Truckdata <- data[data$vin == VIN[c],]
    Truckinfo_1 <- nrow(Truckdata)
    Truckdatazero <- Truckdata[Truckdata$车速 <= 0.1,]
    Truckdata <- Truckdata[Truckdata$车速 > 0.1,]
    Truckinfo_2 <- nrow(Truckdata)
    
    ##为每辆车非静止部分生成氮氧化物排放分布图
    stats2 <- data.frame(matrix(ncol = 3, nrow=0))
    colnames(stats2) <- c("N", "NOx_down_g_km_mean", "NOx_down_g_km_sd")
    Truckinfo_3 <- nrow(Truckdata)
    for (k in 1 : nrow(DFU)){
        sub3 <- subset(Truckdata, Truckdata$Engine == DFU$Engine[k] & Truckdata$Torque1 == DFU$Torque[k]
                       , select = c(NOxdown2))
        sub4 <- c(nrow(sub3), mean(sub3$NOxdown2), sd(sub3$NOxdown2))
        stats2 <- rbind(stats2,sub4)
    }
    DFUe <- cbind(DFU, stats2)
    colnames(DFUe) <- c("X","Engine", "Torque","N", "NOx_down_g_km_mean", "NOx_down_g_km_sd")
    write.csv(DFUe, paste0("C:/Users/admin/OneDrive/文档/G5Emission1/",VIN[c],".csv"))
    rm(DFUe,stats2,sub3,sub4)
    gc()
    
    Truckdata <- Truckdatazero
    Truckinfo_4 <- nrow(Truckdata)
    ##为每辆车静止状态生成氮氧化物排放分布图
    stats2 <- data.frame(matrix(ncol = 3, nrow=0))
    colnames(stats2) <- c("N", "NOx_down_g_s_mean", "NOx_down_g_s_sd")
    
    for (k in 1 : nrow(DFU)){
        sub3 <- subset(Truckdata, Truckdata$Engine == DFU$Engine[k] & Truckdata$Torque1 == DFU$Torque[k]
                       , select = c(NOxdown1))
        sub4 <- c(nrow(sub3), mean(sub3$NOxdown1), sd(sub3$NOxdown1))
        stats2 <- rbind(stats2,sub4)
    }
    DFUe <- cbind(DFU, stats2)
    colnames(DFUe) <- c("X","Engine", "Torque","N","NOx_down_g_s_mean", "NOx_down_g_s_sd")
    write.csv(DFUe, paste0("C:/Users/admin/OneDrive/文档/G5Emissionzero1/",VIN[c],".csv"))
    rm(DFUe,stats2,sub3,sub4)
    gc()
    Truckinfo <- rbind(Truckinfo,c(VIN[c],Truckinfo_1,Truckinfo_2,Truckinfo_3,Truckinfo_4))
    print(paste(VIN[c],"data sampling complete. Starting next car."))
    rm(Truckdata,Truckdatazero)
    gc()
}
colnames(Truckinfo) <- c("VIN","total","nonzero","nonzeroemission","zeroemssion")
write.csv(Truckinfo,"C:/Users/admin/OneDrive/文档/G5Truckinfo1.csv")

for (c in 1 : length(VIN)){
    Truckdata <- data[data$vin == VIN[c],]
    Truckinfo_1 <- nrow(Truckdata)
    Truckdatazero <- Truckdata[Truckdata$车速 <= 0.1,]
    Truckdata <- Truckdata[Truckdata$车速 > 0.1,]
    Truckinfo_2 <- nrow(Truckdata)
    
    ##为每辆车非静止部分生成氮氧化物排放分布图
    stats2 <- data.frame(matrix(ncol = 3, nrow=0))
    colnames(stats2) <- c("N", "NOx_down_g_km_mean", "NOx_down_g_km_sd")
    Truckinfo_3 <- nrow(Truckdata)
    for (k in 1 : nrow(DFU)){
        sub3 <- subset(Truckdata, Truckdata$Engine == DFU$Engine[k] & Truckdata$Torque2 == DFU$Torque[k]
                       , select = c(NOxdown2))
        sub4 <- c(nrow(sub3), mean(sub3$NOxdown2), sd(sub3$NOxdown2))
        stats2 <- rbind(stats2,sub4)
    }
    DFUe <- cbind(DFU, stats2)
    colnames(DFUe) <- c("X","Engine", "Torque","N", "NOx_down_g_km_mean", "NOx_down_g_km_sd")
    write.csv(DFUe, paste0("C:/Users/admin/OneDrive/文档/G5Emission2/",VIN[c],".csv"))
    rm(DFUe,stats2,sub3,sub4)
    gc()
    
    Truckdata <- Truckdatazero
    Truckinfo_4 <- nrow(Truckdata)
    ##为每辆车静止状态生成氮氧化物排放分布图
    stats2 <- data.frame(matrix(ncol = 3, nrow=0))
    colnames(stats2) <- c("N", "NOx_down_g_s_mean", "NOx_down_g_s_sd")
    
    for (k in 1 : nrow(DFU)){
        sub3 <- subset(Truckdata, Truckdata$Engine == DFU$Engine[k] & Truckdata$Torque2 == DFU$Torque[k]
                       , select = c(NOxdown1))
        sub4 <- c(nrow(sub3), mean(sub3$NOxdown1), sd(sub3$NOxdown1))
        stats2 <- rbind(stats2,sub4)
    }
    DFUe <- cbind(DFU, stats2)
    colnames(DFUe) <- c("X","Engine", "Torque","N", "NOx_down_g_s_mean", "NOx_down_g_s_sd")
    write.csv(DFUe, paste0("C:/Users/admin/OneDrive/文档/G5Emissionzero2/",VIN[c],".csv"))
    rm(DFUe,stats2,sub3,sub4)
    gc()
    Truckinfo <- rbind(Truckinfo,c(VIN[c],Truckinfo_1,Truckinfo_2,Truckinfo_3,Truckinfo_4))
    print(paste(VIN[c],"data sampling complete. Starting next car."))
    rm(Truckdata,Truckdatazero)
    gc()
}
colnames(Truckinfo) <- c("VIN","total","nonzero","nonzeroemission","zeroemssion")
write.csv(Truckinfo,"C:/Users/admin/OneDrive/文档/G5_Truckinfo2.csv")

for (c in 1 : length(VIN)){
    Truckdata <- data[data$vin == VIN[c],]
    Truckinfo_1 <- nrow(Truckdata)
    Truckdatazero <- Truckdata[Truckdata$车速 <= 0.1,]
    Truckdata <- Truckdata[Truckdata$车速 > 0.1,]
    Truckinfo_2 <- nrow(Truckdata)
    
    ##为每辆车非静止部分生成氮氧化物排放分布图
    stats2 <- data.frame(matrix(ncol = 3, nrow=0))
    colnames(stats2) <- c("N","NOx_down_g_km_mean", "NOx_down_g_km_sd")
    Truckinfo_3 <- nrow(Truckdata)
    for (k in 1 : nrow(DFU)){
        sub3 <- subset(Truckdata, Truckdata$Engine == DFU$Engine[k] & Truckdata$Torque3 == DFU$Torque[k]
                       , select = c(NOxdown2))
        sub4 <- c(nrow(sub3), mean(sub3$NOxdown2), sd(sub3$NOxdown2))
        stats2 <- rbind(stats2,sub4)
    }
    DFUe <- cbind(DFU, stats2)
    colnames(DFUe) <- c("X","Engine", "Torque","N", "NOx_down_g_km_mean", "NOx_down_g_km_sd")
    write.csv(DFUe, paste0("C:/Users/admin/OneDrive/文档/G5Emission3/",VIN[c],".csv"))
    rm(DFUe,stats2,sub3,sub4)
    gc()
    
    Truckdata <- Truckdatazero
    Truckinfo_4 <- nrow(Truckdata)
    ##为每辆车静止状态生成氮氧化物排放分布图
    stats2 <- data.frame(matrix(ncol = 3, nrow=0))
    colnames(stats2) <- c("N", "NOx_down_g_s_mean", "NOx_down_g_s_sd")
    
    for (k in 1 : nrow(DFU)){
        sub3 <- subset(Truckdata, Truckdata$Engine == DFU$Engine[k] & Truckdata$Torque3 == DFU$Torque[k]
                       , select = c(NOxdown1))
        sub4 <- c(nrow(sub3), mean(sub3$NOxdown1), sd(sub3$NOxdown1))
        stats2 <- rbind(stats2,sub4)
    }
    DFUe <- cbind(DFU, stats2)
    colnames(DFUe) <- c("X","Engine", "Torque","N","NOx_down_g_s_mean", "NOx_down_g_s_sd")
    write.csv(DFUe, paste0("C:/Users/admin/OneDrive/文档/G5Emissionzero3/",VIN[c],".csv"))
    rm(DFUe,stats2,sub3,sub4)
    gc()
    Truckinfo <- rbind(Truckinfo,c(VIN[c],Truckinfo_1,Truckinfo_2,Truckinfo_3,Truckinfo_4))
    print(paste(VIN[c],"data sampling complete. Starting next car."))
    rm(Truckdata,Truckdatazero)
    gc()
}
colnames(Truckinfo) <- c("VIN","total","nonzero","nonzeroemission","zeroemssion")
write.csv(Truckinfo,"C:/Users/admin/OneDrive/文档/G5_Truckinfo3.csv")

source("Scripts/NOx_g_s_G5.R", encoding = 'utf-8')
source("Scripts/NOx_g_km_G5.R", encoding = 'utf-8')