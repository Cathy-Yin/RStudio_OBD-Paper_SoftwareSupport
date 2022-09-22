library(readr)
memory.limit(200000)
data1 <- read.csv("Output/G6Data/final2_1-20.csv")
data2 <- read.csv("Output/G6Data/final2_21-40.csv")
data3 <- read.csv("Output/G6Data/final2_41-53.csv")
data <- rbind(data1,data2,data3)
data$Speed <- round(data$车速/5,0)*5
rm(data1,data2,data3)
VIN <- unique(data$vin)
data_zero <- subset(data, data$车速 <= 0.1)
data_move <- subset(data, data$车速 > 0.1)

DFU_still <- read.csv("Input/UniqueDataTemplate.csv", header = TRUE)
colnames(DFU_still) <- c("N","Engine","Torque")
DFU_move <- read.csv("Input/UniqueDataTemplate2.csv", header = TRUE)
colnames(DFU_still) <- c("N","Engine","Torque","Speed")

result2 <- data.frame(matrix(ncol=5,nrow=0))
for (i in 1: length(VIN)){
    vehiclemove <- data_move[data_move$vin == VIN[i],]
    vehiclestill <- data_zero[data_zero$vin == VIN[i],]
    
## Find the Drive_count for each Vehicle OBD    
    stats1 <- data.frame(matrix(ncol = 1, nrow=0))
    colnames(stats1) <- c("Drive_count")
    for (j in 1 : nrow(DFU_still)){
        sub1a <- subset(vehiclestill, vehiclestill$Engine == DFU_still$Engine[j] & vehiclestill$Torque2 == DFU_still$Torque[j]
                       , select = c(Torque2))
        sub1b <- nrow(sub1a)
        stats1 <- rbind(stats1,sub1b)
    }
    colnames(stats1) <- c("Drive_count")
    DFU_still <- cbind(DFU_still, stats1)
    
    stats2 <- data.frame(matrix(ncol = 1, nrow=0))
    colnames(stats2) <- c("Drive_count")
    for (k in 1 : nrow(DFU_move)){
        sub2a <- subset(vehiclemove, vehiclemove$Engine == DFU_move$Engine[k] & vehiclemove$Torque2 == DFU_move$Torque[k]
                       & vehiclemove$Speed == DFU_move$Speed[k], select = c(Torque2))
        sub2b <- nrow(sub2a)
        stats2 <- rbind(stats2,sub2b)
    }
    colnames(stats2) <- c("Drive_count")
    DFU_move <- cbind(DFU_move, stats2)
    message1 <- paste(i, VIN[i],"Operational data count recored.")
    print(message1)
## Calculate the valid emission data statistics
    Ratio_NO_G6 <- exp(4.805287) / (1+exp(4.805287))
    Ratio_NO2_G6 <- 1 - Ratio_NO_G6
    NOx_m_G6 <- 30/29 * Ratio_NO_G6 + 46/29 * Ratio_NO2_G6
    
    
    vehiclestill <- vehiclestill[(vehiclestill$SCR上游NOx传感器输出值 <= 3000 & vehiclestill$SCR下游NOx传感器输出值 <= 3000 & vehiclestill$SCR上游NOx传感器输出值 >= 1 &
                                  vehiclestill$SCR下游NOx传感器输出值 >= 1 & vehiclestill$进气量 <= 3212 & vehiclestill$进气量 >= 0 & vehiclestill$发动机燃料流量 <= 100),]
    vehiclestill <- vehiclestill[!(is.na(vehiclestill$SCR上游NOx传感器输出值) | is.na(vehiclestill$SCR下游NOx传感器输出值) | is.na(vehiclestill$进气量)),]
    
    vehiclestill$NOx_up_g_s <- vehiclestill$SCR上游NOx传感器输出值 * (vehiclestill$进气量 + vehiclestill$发动机燃料流量 * 0.85) * 0.95 / 3.6 * NOx_m_G6 * 10^-6 
    vehiclestill$NOx_down_g_s <- vehiclestill$SCR下游NOx传感器输出值 * (vehiclestill$进气量 + vehiclestill$发动机燃料流量 * 0.85) *0.95 / 3.6 * NOx_m_G6 * 10^-6
    vehiclestill$NOx_up_g_km <- vehiclestill$NOx_up_g_s/ vehiclestill$车速 * 3.6 * 1000
    vehiclestill$NOx_down_g_km <- vehiclestill$NOx_down_g_s / vehiclestill$车速 * 3.6 * 1000
    
    vehiclemove <- vehiclemove[(vehiclemove$SCR上游NOx传感器输出值 <= 3000 & vehiclemove$SCR下游NOx传感器输出值 <= 3000 & vehiclemove$SCR上游NOx传感器输出值 >= 1 &
                                      vehiclemove$SCR下游NOx传感器输出值 >= 1 & vehiclemove$进气量 <= 3212 & vehiclemove$进气量 >= 0 & vehiclemove$发动机燃料流量 <= 100),]
    vehiclemove <- vehiclemove[!(is.na(vehiclemove$SCR上游NOx传感器输出值) | is.na(vehiclemove$SCR下游NOx传感器输出值) | is.na(vehiclemove$进气量)),]
    
    vehiclemove$NOx_up_g_s <- vehiclemove$SCR上游NOx传感器输出值 * (vehiclemove$进气量 + vehiclemove$发动机燃料流量 * 0.85) * 0.95 / 3.6 * NOx_m_G6 * 10^-6 
    vehiclemove$NOx_down_g_s <- vehiclemove$SCR下游NOx传感器输出值 * (vehiclemove$进气量 + vehiclemove$发动机燃料流量 * 0.85) *0.95 / 3.6 * NOx_m_G6 * 10^-6

## Find the Emission_count for each Vehicle OBD    
    stats3 <- data.frame(matrix(ncol = 5, nrow=0))
    colnames(stats3) <- c("Emission_count","NOx_up_g_s_mean", "NOx_up_g_s_sd","NOx_down_g_s_mean", "NOx_down_g_s_sd")
    for (l in 1 : nrow(DFU_still)){
        sub3a <- subset(vehiclestill, vehiclestill$Engine == DFU_still$Engine[l] & vehiclestill$Torque2 == DFU_still$Torque[l]
                        , select = c(NOx_up_g_s, NOx_down_g_s))
        sub3b <-c(nrow(sub3a), mean(sub3a$NOx_up_g_s), sd(sub3a$NOx_up_g_s), mean(sub3a$NOx_down_g_s), sd(sub3a$NOx_down_g_s))
        stats3 <- rbind(stats3,sub3b)
    }
    colnames(stats3) <- c("Emission_count","NOx_up_g_s_mean", "NOx_up_g_s_sd","NOx_down_g_s_mean", "NOx_down_g_s_sd")
    DFU_still <- cbind(DFU_still, stats3)
    
    stats4 <- data.frame(matrix(ncol = 5, nrow=0))
    colnames(stats4) <- c("Emission_count","NOx_up_g_s_mean", "NOx_up_g_s_sd","NOx_down_g_s_mean", "NOx_down_g_s_sd")
    for (m in 1 : nrow(DFU_move)){
        sub4a <- subset(vehiclemove, vehiclemove$Engine == DFU_move$Engine[m] & vehiclemove$Torque2 == DFU_move$Torque[m]
                        & vehiclemove$Speed == DFU_move$Speed[m], select = c(NOx_up_g_s, NOx_down_g_s))
        sub4b <- c(nrow(sub4a), mean(sub4a$NOx_up_g_s), sd(sub4a$NOx_up_g_s), mean(sub4a$NOx_down_g_s), sd(sub4a$NOx_down_g_s))
        stats4 <- rbind(stats4,sub4b)
    }
    colnames(stats4) <- c("Emission_count","NOx_up_g_s_mean", "NOx_up_g_s_sd","NOx_down_g_s_mean", "NOx_down_g_s_sd")
    DFU_move <- cbind(DFU_move, stats4)   
    
## Sink the in-motion and immobile datasets
    write.csv(DFU_still,paste0("C:/Users/admin/OneDrive/文档/Individualstill/",VIN[i],"_still.csv"))
    write.csv(DFU_move,paste0("C:/Users/admin/OneDrive/文档/Individualmove/",VIN[i],"_move.csv"))
    message2 <- paste(i,VIN[i],"OBD data has been individually treated.")
    print(message2)
    
    DFU_still$Frequency <- DFU_still$Drive_count / sum(DFU_still$Drive_count)
    DFU_move$Frequency <- DFU_move$Drive_count / sum(DFU_move$Drive_count)
    still_NOx_up <- sum(DFU_still$Frequency * DFU_still$Nox_up_g_s_mean)
    still_NOx_down <- sum(DFU_still$Frequency * DFU_still$Nox_down_g_s_mean)
    move_NOx_up <- sum(DFU_move$Frequency * DFU_move$Nox_up_g_s_mean)
    move_NOx_down <- sum(DFU_move$Frequency * DFU_move$Nox_down_g_s_mean)
    result1 <- c(VIN[i],move_NOx_up, move_NOx_down, still_NOx_up, still_NOx_down)
    result2 <- rbind(result2,result1)
    message3 <- paste(i, VIN[i], "data summary recorded")
    print(message3)
}
write.csv(result2,"C:/Users/admin/OneDrive/文档/IndividalResults.csv")