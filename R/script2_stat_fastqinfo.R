# script to compute the number of clean reads and bases, GC content as well as bases quality Q20, Q30.
# @author: cxiang

# parse the arguments
#
# input file:
#   1.sample information file including columns: column 1 is file number; column 2 is sequecing number; column 3 is filename of paired sequence R1 in fastq format; column 4 is filename of paired sequence R2 in fastq format.
#   column 5 is filename of target interval file in bed format; column 6 is filename of trimmed sequence R1 in fastq format; column 7 is filename of trimmed sequence R2 in fastq format
#
# output file:
#   1.an excel table, format as sample name, clean reads, clean bases, Q20, Q30, GC.
#
#
library(seqTools)
args = commandArgs(trailing = TRUE)
infile = args[1]
outfile = args[2]

con = file(infile,"r")
line = readline(con,n=1)
n = 1
x = data.frame(row.names = 1)
colnames(x) = c("Sample", "Clean reads", "Clean bases", "Q20(%)", "Q30(%)", "GC(%)")
while (length(line)>0) {
  sq = strsplit(line,"\t")
  fq1 = fastqq(sq[6],k=6)
  fq2 = fastqq(sq[7],k=6)
  
  x[n][1] = sq[1]
  x[n+1][1]
  x[n][2] = fq1@nReads
  x[n+1][2] = fq2@nReads
  x[n][3] = computeBases(fq1@seqLenCount)
  x[n+1][3] = computeBases(fq2@seqLenCount)
  Q = computeQ(fq1@phred)
  x[n][4] = Q[1]
  x[n][5] = Q[2]
  Q = computeQ(fq2@phred)
  x[n+1][4] = Q[1]
  x[n+1][5] = Q[2]
  x[n][6] = computeGC(fq1@gcContent)
  x[n+1][6] = computeGC(fq2@gcContent)
  n = n + 1
  line = readline(con,"\t")
}
write.csv(
  x,
  file = paste(outfile, ".csv", sep = ""),
  row.names = F
)

computeBases <- function(x){
  count = 0
  n = 0;
  for(i in x){
    count = count + i*n;
    n = n + 1
  }
  return(count)
}

computeQ <- function(x){
  x = data.frame(x)
  row = as.numeric(rownames(x))
  Q20 = 0;
  for(i in row){
    Q20 = Q20 + sum(x[[i]][which(row>=20)])
    Q30 = Q30 + sum(x[[i]][which(row>=30)])
  }
  Q20 = round(Q20*100/sum(x),2)
  Q30 = round(Q30*100/sum(x),2)
  return(c(Q20,Q30))
}

computeGC <- function(x){
  n = 0
  GC = 0;
  for(i in x){
    GC = GC + n * i
  }
  GC = round(GC/sum(x),2)
  return(GC)
}