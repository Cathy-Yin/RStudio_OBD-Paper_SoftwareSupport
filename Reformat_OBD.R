##Select proper time window of data
#OBD <-OBD[as.Date(OBD$终端报文采集时间) >= "2020-11-01" & as.Date(OBD$终端报文采集时间) <= "2020-12-31", ]    
##Calculate acceleration based on time and speed difference between each data point
time <- as.numeric(OBD$终端报文采集时间)
speed <- as.numeric(OBD$车速)
tdiff <- c(1,diff(time))
sdiff <-c(0,diff(speed))
acceleration <- sdiff / tdiff
for (b in 1 : length(time)){
    if (tdiff[b] > 5){
        acceleration[b] <- NA
    }
}
OBD$加速度 <- acceleration
rm(time,speed,tdiff,sdiff,acceleration,b)
gc()
##Remove unnecessary data    
OBD$X1 <- NULL
OBD$排列 <- NULL
OBD$转发类型 <- NULL
OBD$hostname <- NULL
OBD$流水号 <- NULL
OBD$终端报文发送时间 <- NULL
OBD$服务器时间 <- NULL
OBD$接入标识_协议种类_协议版本 <- NULL
OBD$DPF压差 <- NULL
OBD$发动机冷却液温度 <- NULL
OBD$油箱液位 <- NULL
OBD$排放标准 <- NULL
OBD$定位状态 <- NULL
OBD$经度 <- NULL
OBD$纬度 <- NULL
OBD$车辆类型 <- NULL
OBD$车型 <- NULL

##cleaning data
OBD <- OBD[!(is.na(OBD$发动机净输出扭矩) | is.na(OBD$车速) | OBD$车速 >= 150 |
                 OBD$累计里程 >= 115000),]
##仅用于国六卡车
#OBD <- OBD[(OBD$SCR入口温度 <= 1734 & OBD$SCR出口温度 <= 1734 & OBD$大气压力 >= 50 &
#                OBD$发动机净输出扭矩 >= -50 & OBD$发动机净输出扭矩 <= 125),]
##仅用于国五卡车
OBD <- OBD[(OBD$大气压力 >= 50 & OBD$发动机净输出扭矩 >= -50 & OBD$发动机净输出扭矩 <= 125),]


##calculate MaxEngine, MaxSpeed, Torques,Engine
MaxEngine <- floor(as.numeric(quantile(OBD$发动机转速, probs = c(0.9999)))/100)*100
MaxSpeed <- max(OBD$车速)
OBD$发动车最大转速比 <- round(OBD$发动机转速 / MaxEngine,4)
OBD$Torque1 <- round( 0.2* (OBD$发动机净输出扭矩), 0)/0.2
OBD$Torque2 <- round( 0.2* (OBD$发动机净输出扭矩-OBD$摩擦扭矩), 0)/0.2
OBD$Torque3 <- OBD$Torque2
OBD$Torque3[OBD$Torque3 < 0 ] <- 0
OBD$Engine <- round(OBD$发动车最大转速比*20, 0)/0.2

##Remove additional unnecessary data
OBD$累计里程 <- NULL
OBD$发动机转速 <- NULL
OBD$发动车最大转速比 <- NULL
OBD$发动机净输出扭矩 <- NULL
OBD$摩擦扭矩 <- NULL