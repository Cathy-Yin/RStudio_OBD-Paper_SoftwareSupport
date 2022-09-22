Carnames<- "LVBV6PDC3LW083011"
G6testfiles <- paste0("D:/Database/G6 Reformated/", Carnames, ".csv")

OBD <- read_csv(file = G6testfiles, col_names = TRUE, cols(.default = col_double()
                                                              ,vin = col_character(),接入标识_协议种类_协议版本 = col_character(),车辆类型 = col_character()
                                                              ,终端报文采集时间 = col_datetime(),服务器时间 = col_datetime(),终端报文发送时间 = col_datetime()
                                                              ,车型 = col_character(),转发类型 = col_character()))


OBD <- OBD[as.Date(OBD$终端报文采集时间) >= "2020-11-01" & as.Date(OBD$终端报文采集时间) <= "2020-12-31", ]
OBD <- OBD[!(is.na(OBD$发动机净输出扭矩) | is.na(OBD$车速) | OBD$车速 >= 150 |
                   OBD$累计里程 >= 115000),]
OBD <- OBD[(OBD$SCR入口温度 <= 1734 & OBD$SCR出口温度 <= 1734 & OBD$大气压力 >= 50 &
                  OBD$发动机净输出扭矩 >= -50 & OBD$发动机净输出扭矩 <= 125),]
OBD <- OBD[(OBD$SCR上游NOx传感器输出值 <= 3011 & OBD$SCR下游NOx传感器输出值 <= 3011 & OBD$SCR上游NOx传感器输出值 >= 1 &
                   OBD$SCR下游NOx传感器输出值 >= 1 & OBD$进气量 <= 3212 & OBD$进气量 >= 0),]
OBD <- OBD[!(is.na(OBD$SCR上游NOx传感器输出值) | is.na(OBD$SCR下游NOx传感器输出值) | is.na(OBD$进气量)),]
OBD$inletr <- 3.6/OBD$进气量

set.seed(50) # random number will generate from 5
TenRandomNumbers <- sort(sample.int(nrow(OBD), 1000))
OBD <- OBD[TenRandomNumbers,]


Inlet <- OBD$inletr
tempup <- OBD$SCR入口温度
tempdown <- OBD$SCR出口温度
NOxup <- OBD$SCR上游NOx传感器输出值
NOxdown <- OBD$SCR下游NOx传感器输出值
Speed <- OBD$车速
Torque <- OBD$发动机净输出扭矩
Engine <- OBD$发动机转速
Fuel <- OBD$发动机燃料流量
Reagent <- OBD$反应剂余量
Range <- OBD$累计里程

fit1 <- lm(NOxup ~ Inlet + tempup + Speed + Torque + Engine + Fuel + Range + 0)
summary(fit1)
fit2 <- lm(NOxdown ~ NOxup + Inlet + tempdown + Speed + Torque + Engine + Fuel + Range + Reagent + 0)
summary(fit2)