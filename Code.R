install.packages("pheatmap") # Install the Pheatmap Paccage
library(pheatmap)
am = read.csv("Basketball.csv")  # Read file
head(am)
am_split = am[am$MP >= 30 ,]
TOT_players = am_split[am_split$Tm == "TOT","Player"]
am_used = am_split[((df_filt$Player %in% TOT_players) & (df_filt$Tm == "TOT")) | (!(df_filt$Player %in% TOT_players)),]
am_used[is.na(df_used)] = 0
am_number = as.matrix(am_used[,6:30])
rownames(am_number) = sapply(df_used$Player,function(x) 
strsplit(as.character(x),split = "\\\\")[[1]][1])
am_number_scale = scale(am_number)
plot(density(df$PTS),xlab = "Points PerGame",ylab="Density",main="Comparison between scaling data and raw data",col="red",lwd=3,ylim=c(0,0.45))
lines(density(am_number_scale[,"PTS"]),col="blue",lwd=3)
legend("topright",legend = c("raw","scaled"),col = c("red","blue"),lty = "solid",lwd=3)
pheatmap(am_number_scale,main = "pheatmap default")
pheatmap(am_number_scale,cluster_cols = F,main = "pheatmap row cluster")
pheatmap(am_number_scale,scale = "row",main = "Pheatmap Row Scaling")
pos_am = data.frame("Pos" = df_used$Pos)
rownames(pos_am) = rownames(df_num) # name matching
pheatmap(df_num_scale,cluster_cols = F,annotation_row = pos_df,main = "Pheatmap Row-Annotation")
cat_am = data.frame("category" =c(rep("other",3),rep("Off",13),rep("Def",3),"Off",rep("Def",2),rep("other",2),"Off"))
rownames(cat_am) = colnames(df_num)
pheatmap(am_number_scale,cluster_rows = F, annotation_col = cat_df,main = "Pheatmap Column Annotation")
pheatmap(am_number_scale,cutree_rows = 10,main = "Pheatmap Row Cut in 10")
pheatmap(am_number_scale,cutree_cols = 10,main = "Pheatmap Column Cut in 10")
