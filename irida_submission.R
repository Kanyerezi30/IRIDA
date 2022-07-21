# Given a directory path with samples IDs, create a worksheet for IRIDA workbench submission
# The script needs 2 arguments. First being the path of fastq files and second being the project id provide by the workbench
args1 <- commandArgs(trailingOnly = TRUE) # make the script accept arguments
cat(paste("The directory path is", args1[1]), "\n")
cat(paste("The project id provided by irida is", args1[2]), "\n")


setwd(args1[1]) # set thr working directory to that containing your fastq files
#getwd() # confirm that it is the directory you want 
cat(paste("The path is", getwd()), "\n")

File_Forward <- list.files(pattern = "^COV.*R1.*gz") # store the names of the forward reads
#length(File_Forward) # check the number of forward files
cat(paste("There are", length(File_Forward), "forward files"), "\n")

File_Reverse <- list.files(pattern = "^COV.*R2,*gz") # store the names of the forward reads
#length(File_Reverse) # check the number of reverse files
cat(paste("There are", length(File_Reverse), "reverse files"), "\n")

x <- length(File_Forward) == length(File_Reverse) # check whether the number of forward is equal to that of the reverse
cat(paste("Forward and reverse files are equal:", x), "\n")

Sample_Name <- sapply(strsplit(File_Forward, "_"), "[[", 1) # get the sample names
#length(Sample_Name) # check the number of samples
cat(paste("There are", length(Sample_Name), "samples"), "\n")

y <- length(File_Forward) == length(Sample_Name) # confirm that the number of forward reads is equal to the number of samples
cat(paste("Forward, reverse files, and number of samples are equal:", y), "\n")

Project_ID <- rep(22, length(Sample_Name)) # create the project id given by the workbench

fin <- as.data.frame(cbind(Sample_Name, Project_ID, File_Forward, File_Reverse)) # create final output dataframe

# create the first row needed
header <- c("[Data]", "NA", "NA", "NA")

# create the second row
sheader <- c("Sample_Name", "Project_ID", "File_Forward", "File_Reverse")

fin <- rbind(header, sheader, fin) # add the two first rows to the final desired output

xlsx::write.xlsx(fin, "SampleList.xlsx", col.names = F, append = F) # create the final output