source("http://bioconductor.org/biocLite.R")
biocLite("clusterProfiler")


a=read.table("/Users/cx/Desktop/CancerInfo/enrichment/tissue_gene.txt", sep = "\t", header = F)

require(DOSE)

require(clusterProfiler)

gene=as.character(a[,2])
entrezIDs = mget(gene, org.Hs.egSYMBOL2EG, ifnotfound = NA)
entrezIDs = as.character(entrezIDs)

ego <- enrichGO(gene=entrezIDs,'org.Hs.eg.db',ont="BP",pvalueCutoff=0.01,readable=TRUE)

ekk <- enrichKEGG(gene=entrezIDs,organism = "hsa",pAdjustMethod = "BH",pvalueCutoff=0.01)

write.csv(summary(ekk),"KEGG-enrich.csv",row.names =F)

write.csv(summary(ego),"GO-enrich.csv",row.names =F)
barplot(ego, showCategory=15,title="EnrichmentGO") #条形图
dotplot(ego,title="EnrichmentGO_dot")