# script to compute depth of coverage
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

