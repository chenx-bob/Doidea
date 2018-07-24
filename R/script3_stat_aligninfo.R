# script to compute the result of sequence alignment
# @author: cxiang

# parse the arguments
#
# input file:
#   1.sample information file including columns: column 1 is file number; column 2 is sequecing number; column 3 is filename of paired sequence R1 in fastq format; column 4 is filename of paired sequence R2 in fastq format.
#   column 5 is filename of target interval file in bed format; column 6 is filename of trimmed sequence R1 in fastq format; column 7 is filename of trimmed sequence R2 in fastq format; column 8 is filename of aligned and sorted sequence file in bam format;
#
# output file:
#   1.an excel table, format as 9 columns "Effective Reads","Total Mapped","Multiple mapped","Uniquely mapped","Read1 mapped","Read2 mapped","Reads map to '+'","Reads map to '-'","Reads mapped in proper pairs".
#
#

library(Rsamtools)
args = commandArgs(trailingOnly = TRUE)
infile = args[1]
outfile = args[2]

data = data.frame(row.names = 1)
colnames(data)=c("Effective Reads","Total Mapped","Multiple mapped","Uniquely mapped","Read1 mapped","Read2 mapped","Reads map to '+'","Reads map to '-'","Reads mapped in proper pairs")
bf <- Rsamtools::scanBam(infile)
status = countFlagStus(bf[[1]]$flag)
data[1] = length(bf[[1]]$qname)
data[2] = data[1] - status$UP
data[3] = status$MP
data[4] = data[2] - status$MP
data[5] = status$R1
data[6] = status$R2
data[7] = length(bf[[1]]$strand[bf[[1]]$strand == "+"])
data[8] = length(bf[[1]]$strand[bf[[1]]$strand == "-"])
data[9] = status$PP
write.csv(
  data,
  file = paste(outfile, ".csv", sep = ""),
  row.names = F
)

countFlagStus <- function(num){
  da = data.frame(PD=1,PP=2,UP=4,MP=8,RE=16,ME=32,R1=64,R2=128,SY=256,QL=512,DUP=1024,SU=2048)
  xx = data.frame(PD=0,PP=0,UP=0,MP=0,RE=0,ME=0,R1=0,R2=0,SY=0,QL=0,DUP=0,SU=0)
  for(n in da){
    name = colnames(da[n])
    for(i in num){
      if(round(i/da$name)==1){
        xx$name = x$name + 1
      }
    }
  }
  return(xx)
}