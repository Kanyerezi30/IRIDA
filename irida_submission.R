# Given a directory path with samples IDs, create a worksheet for IRIDA submission

setwd("/media/kanye/skanyerezi/220716_M05143_0032_000000000-K9VYL/Alignment_1/20220717_153923/Fastq")
File_Forward <- list.files(pattern = "R1")
File_Reverse <- list.files(pattern = "R2")
ids <- list.files(pattern = "*gz")
ids <- strsplit(ids, '_')

Sample_Name <- unique(sapply(ids, "[[", 1))

Project_ID <- rep(22, length(ids))
#hedrd <- "[Data]"
fin <- as.data.frame(cbind(Sample_Name, Project_ID, File_Forward, File_Reverse))
View(fin)
# create the worksheet
library(writexl)
write_xlsx(fin, path = "./fin.xlsx")
