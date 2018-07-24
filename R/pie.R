#!/usr/local/bin/Rscript
library(ggplot2)
values=c(888672, 130436)
str1=paste("Clean reads (",round(100*values[1]/sum(values),2),"%)",sep="")
str2=paste("Other reads (",round(100*values[2]/sum(values),2),"%)",sep="")
labels=c(str1,str2)
colours=c("#8dd3c7", "#ffffb3")
percent_str <- paste(round(values/sum(values) * 100,1), "%", sep="")
values <- data.frame(Percentage = round(values/sum(values) * 100,1), Type = labels,percent=percent_str )
pdf("3.pdf")
pie <- ggplot(values, aes(x = "" ,y = Percentage, fill = Type)) +  geom_bar(stat = "identity",width = 3) + coord_polar(theta = "y") + labs(x = "", y = "", title = "Sequenced Reads") + theme(axis.ticks = element_blank()) 
pie
dev.off()