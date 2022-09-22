## loading relevant packages
library(dplyr)
library(readr)
library(tidyverse)
library(lubridate)

##clear environment
rm(list=ls(all=TRUE))
memory.limit(2500000)

Carnames <- read.table("Input/post-midterm/G6 Gas Final Test.txt")
Carnames1 <- Carnames[1:17,]
Carnames2 <- Carnames[18:46,]
Carnames3 <- Carnames[47:57,]
Carnames4 <- Carnames[58:71,]

########################
##start Batch 1 import##
########################
print("importing Batch 1")
G6files1 <- c()
for (i in 1 : length(Carnames1)){
    G6files1[i] <- paste0("D:/EE Database/G6 Reformated/", Carnames1[i], ".csv")
}
data1a <- data.frame(matrix(nrow=0,ncol = 31))
data1b <- data.frame(matrix(nrow=0,ncol=3))
for (a in 1:length(G6files1)) {
    OBD <- read_csv(file = G6files1[a], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,车型 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data1a <-  rbind(data1a, OBD)
    data1b <- rbind(data1b,c(Carnames1[a],MaxEngine,MaxSpeed))
    print(paste(a,Carnames1[a],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data1b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data1a)))

data1a$Torque1 <- NULL
data1a$Torque3 <- NULL
data1a$SCR入口温度 <- NULL
data1a$SCR出口温度 <- NULL
data1a$反应剂余量 <- NULL
data1_zero <- subset(data1a, data1a$车速 <= 0.1)
data1a <- subset(data1a,data1a$车速 > 0.1)
data1a$Speed <- round(data1a$车速 * 0.2,0) * 5

data1a <- data1a[order(data1a$Engine),]
data1a <- data1a[order(data1a$Torque2),]
data1a <- data1a[order(data1a$Speed),]
data1_zero <- data1_zero[order(data1_zero$Engine),]
data1_zero <- data1_zero[order(data1_zero$Torque2),]

write.csv(data1a, "Output/G6Data/Gas Final Move 1-17.csv")
write.csv(data1_zero, "Output/G6Data/Gas Final Still 1-17.csv")
write.csv(data1b, "Output/G6DataInfo/Gas Final 1-17.csv")
rm(data1a,data1_zero)

########################
##start Batch 2 import##
########################
print("importing Batch 2")
G6files2 <- c()
for (i in 1 : length(Carnames2)){
    G6files2[i] <- paste0("D:/EE Database/G6 Reformated/", Carnames2[i], ".csv")
}
data2a <- data.frame(matrix(nrow=0,ncol = 31))
data2b <- data.frame(matrix(nrow=0,ncol=3))
for (k in 1:length(G6files2)) {
    OBD <- read_csv(file = G6files2[k], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,车型 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data2a <-  rbind(data2a, OBD)
    data2b <- rbind(data2b,c(Carnames2[k],MaxEngine,MaxSpeed))
    print(paste(k,Carnames2[k],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data2b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data2a)))

data2a$Torque1 <- NULL
data2a$Torque3 <- NULL
data2a$SCR入口温度 <- NULL
data2a$SCR出口温度 <- NULL
data2a$反应剂余量 <- NULL
data2_zero <- subset(data2a, data2a$车速 <= 0.1)
data2a <- subset(data2a,data2a$车速 > 0.1)
data2a$Speed <- round(data2a$车速 * 0.2,0) * 5

data2a <- data2a[order(data2a$Engine),]
data2a <- data2a[order(data2a$Torque2),]
data2a <- data2a[order(data2a$Speed),]
data2_zero <- data2_zero[order(data2_zero$Engine),]
data2_zero <- data2_zero[order(data2_zero$Torque2),]

write.csv(data2a, "Output/G6Data/Gas Final Move 18-46.csv")
write.csv(data2_zero, "Output/G6Data/Gas Final Still 18-46.csv")
write.csv(data2b, "Output/G6DataInfo/Gas Final 18-46.csv")
rm(data2a,data2_zero)


########################
##start Batch 3 import##
########################
print("importing Batch 3")
G6files3 <- c()
for (i in 1 : length(Carnames3)){
    G6files3[i] <- paste0("D:/EE Database/G6 Reformated/", Carnames3[i], ".csv")
}
data3a <- data.frame(matrix(nrow=0,ncol = 31))
data3b <- data.frame(matrix(nrow=0,ncol=3))
for (j in 1:length(G6files3)) {
    OBD <- read_csv(file = G6files3[j], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,车型 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data3a <-  rbind(data3a, OBD)
    data3b <- rbind(data3b,c(Carnames3[j],MaxEngine,MaxSpeed))
    print(paste(j,Carnames3[j],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data3b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data3a)))

data3a$Torque1 <- NULL
data3a$Torque3 <- NULL
data3a$SCR入口温度 <- NULL
data3a$SCR出口温度 <- NULL
data3a$反应剂余量 <- NULL
data3_zero <- subset(data3a, data3a$车速 <= 0.1)
data3a <- subset(data3a,data3a$车速 > 0.1)
data3a$Speed <- round(data3a$车速 * 0.2,0) * 5

data3a <- data3a[order(data3a$Engine),]
data3a <- data3a[order(data3a$Torque2),]
data3a <- data3a[order(data3a$Speed),]
data3_zero <- data3_zero[order(data3_zero$Engine),]
data3_zero <- data3_zero[order(data3_zero$Torque2),]

write.csv(data3a, "Output/G6Data/Gas Final Move 47-57.csv")
write.csv(data3_zero, "Output/G6Data/Gas Final Still 47-57.csv")
write.csv(data3b, "Output/G6DataInfo/Gas Final 47-57.csv")
rm(data3a,data3_zero)


########################
##start Batch 4 import##
########################
print("importing Batch 4")
G6files4 <- c()
for (i in 1 : length(Carnames4)){
    G6files4[i] <- paste0("D:/EE Database/G6 Reformated/", Carnames4[i], ".csv")
}
data4a <- data.frame(matrix(nrow=0,ncol = 31))
data4b <- data.frame(matrix(nrow=0,ncol=3))
for (m in 1:length(G6files4)) {
    OBD <- read_csv(file = G6files4[m], col_names = TRUE, cols(.default = col_double()
        ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
        ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
        ,车型 = col_character(),转发类型 = col_character()))
    
    source("Scripts/Reformat_OBD.R", encoding = 'utf-8')
    data4a <-  rbind(data4a, OBD)
    data4b <- rbind(data4b,c(Carnames4[m],MaxEngine,MaxSpeed))
    print(paste(j,Carnames4[m],"import complete, total number of available data is",nrow(OBD)))
}
colnames(data4b) <- c("VIN","MaxEngine","MaxSpeed")
print(paste("Batch import complete. The number of usable data is:", nrow(data4a)))

data4a$Torque1 <- NULL
data4a$Torque3 <- NULL
data4a$SCR入口温度 <- NULL
data4a$SCR出口温度 <- NULL
data4a$反应剂余量 <- NULL
data4_zero <- subset(data4a, data4a$车速 <= 0.1)
data4a <- subset(data4a,data4a$车速 > 0.1)
data4a$Speed <- round(data4a$车速 * 0.2,0) * 5

data4a <- data4a[order(data4a$Engine),]
data4a <- data4a[order(data4a$Torque2),]
data4a <- data4a[order(data4a$Speed),]
data4_zero <- data4_zero[order(data4_zero$Engine),]
data4_zero <- data4_zero[order(data4_zero$Torque2),]

write.csv(data4a, "Output/G6Data/Gas Final Move 58-71.csv")
write.csv(data4_zero, "Output/G6Data/Gas Final Still 58-71.csv")
write.csv(data4b, "Output/G6DataInfo/Gas Final 58-71.csv")
rm(data4a,data4_zero)


data1a <- rbind(read.csv("Output/G6Data/Gas Final Move 1-17.csv")
                   ,read.csv("Output/G6Data/Gas Final Move 18-46.csv")
                   ,read.csv("Output/G6Data/Gas Final Move 47-57.csv")
                   ,read.csv("Output/G6Data/Gas Final Move 58-71.csv"))


data1a$X <- NULL
data1a$车速 <- NULL
data1a$终端报文采集时间 <- NULL

##Calculate the occurrance of operation status based on Speed, Engine and Torque.
DFU2 <- read.csv("Input/UniqueDataTemplate2.csv", header = TRUE)
stats1 <- data.frame(matrix(ncol = 1, nrow= 0 ))
colnames(stats1) <- c("Drive_count")

Speed_stick = -1
for (k in 1 : nrow(DFU2)){
    if (DFU2$Speed[k] != Speed_stick){
        print(paste(k,"开始刻印车速为:",DFU2$Speed[k]))
    }
    sub1a <- subset(data1a, data1a$Engine == DFU2$Engine[k] & data1a$Torque2 == DFU2$Torque[k] & data1a$Speed == DFU2$Speed[k]
                   , select = c(Torque2))
    sub1b <- nrow(sub1a)
    stats1 <- rbind(stats1,sub1b)
    Speed_stick <- DFU2$Speed[k]
}
DFU2o <- cbind(DFU2, stats1)
write.csv(DFU2o, "C:/Users/admin/OneDrive/文档/71GasTrucksOperationMove.csv")


##Cleanse the data and keep only parts that are used to calculate emission
data1a <- data1a[(data1a$SCR上游NOx传感器输出值 <= 3000  & data1a$SCR上游NOx传感器输出值 >= 1  & data1a$进气量 <= 3212 & data1a$进气量 >= 0 & data1a$发动机燃料流量 <= 100),]
data1a <- data1a[!(is.na(data1a$SCR上游NOx传感器输出值) | is.na(data1a$进气量)),]

Ratio_NO_G6 <- exp(4.805287) / (1+exp(4.805287))
Ratio_NO2_G6 <- 1 - Ratio_NO_G6
Ratio_NO_G5 <- exp(2.092286) / (1+exp(2.092286))
Ratio_NO2_G5 <- 1 - Ratio_NO_G5

NOx_m_G6 <- 30/29 * Ratio_NO_G6 + 46/29 * Ratio_NO2_G6
NOx_m_G5 <- 30/29 * Ratio_NO_G5 + 46/29 * Ratio_NO2_G5

data1a$NOx_up_g_s <- data1a$SCR上游NOx传感器输出值 * (data1a$进气量 + data1a$发动机燃料流量 * 16/22.4/1000) * 0.95 / 3.6 * NOx_m_G6 * 10^-6 

VIN <- unique(data1a$vin)

for (n in 1 : length(VIN2)){
    data2 <- data1a[data1a$vin == VIN2[n],]
    print(paste(n,VIN2[n],"开始刻印"))
##Calculate the occurrance of emission and mean values based on Speed, Engine and Torque.
    stats2 <- data.frame(matrix(ncol = 3, nrow=0))
    colnames(stats2) <- c("Emission_count", "NOx_up_g_s_mean", "NOx_up_g_s_sd")
    Speed_stick = -1
    for (k in 1 : nrow(DFU2)){
        if (DFU2o$Speed[k] != Speed_stick){
            print(paste(k,"开始刻印车速为:",DFU2o$Speed[k]))
        } 
        sub1c <- subset(data2, data2$Engine == DFU2o$Engine[k] & data2$Torque2 == DFU2o$Torque[k] & data2$Speed == DFU2o$Speed[k]
                       , select = c(NOx_up_g_s))
        sub1d <- c(nrow(sub1c), mean(sub1c$NOx_up_g_s), sd(sub1c$NOx_up_g_s))
        stats2 <- rbind(stats2,sub1d)
        Speed_stick <- DFU2o$Speed[k]
    }
    DFU2e <- cbind(DFU2o,stats2)
    colnames(DFU2e) <- c("X","Engine","Torque","Speed","Drive_count","Emission_count","NOx_up_g_s_mean", "NOx_up_g_s_sd")
    write.csv(DFU2e, paste0("C:/Users/admin/OneDrive/文档/71GasTrucksEmissionMove/",VIN2[n],".csv"))
}