# Script to compute data volume, reads amount and depth for sequencing data.
# @author: cxiang


# parse the arguments
#
# input file:
#   1.sample information file including columns: column 1 is file number; column 2 is sequecing number; column 3 is filename of paired sequence R1 in fastq format; column 4 is filename of paired sequence R2 in fastq format.
#   column 5 is filename of target interval file in bed format. 
# output file:
#   1.an excel table, format as sample number, sample name, bases, reads, depth of coverage. 

library(seqTools)
args = commandArgs(trailingOnly = TRUE)
infile = args[1]
outfile = args[2]
con = file(infile,"r")
line = readline(con,n=1)
n=0;
data = data.frame(row.names = 1)
colnames(data)=c("Sample number","Sample name","Bases","Reads","Depth of coverage")

while(length(line)>0){
  sp = strsplit(line,"\t")
  n = n + 1
  data[n][1] = n
  data[n][2] = sp[1]
  vol = computeDataVol(sp[3],sp[5])
  data[n][3] = vol[1]
  data[n][4] = vol[2]
  data[n][5] = vol[3]
  line = readline(con,n=1)
}
write.csv(
  data,
  file = paste(outfile, ".csv", sep = ""),
  row.names = F
)
 computeDataVol <- function(file1, file2){
     con1 = file(file2,"r")
     line1 = readline(con1,n=1)
     x=c()
     while(length(line1)>0){
       sp = strsplit(line1,"\t")
       x[3] = x[3] + (sp[3]-sp[2]+1)
       line1 = readline(con1,n=1)
     }
     fq = fastqq(file1,k=6)
     x[2] = fq@nReads * 2
     x[1] = fq@nReads * fq@maxSeqLen * 2
     x[3] = round(x[1]/x[3],2)
     return(x)
 }
