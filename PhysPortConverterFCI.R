# This is a script to take the scantron results from NDSU and fix them up
# so that they are ready for uploading to the PhysPort Data Explorer.
# They need fixing becaues the correct response is listed as a "$", rather
# than the corresponding choice (one of "A", "B",..., "E").  The only assumption
# that is made is that the imported csv file of responses has the first
# question starting in column 5.  This script will not work if this is
# not the case!

# Imports the data file
filename = "~/Teaching/NDSU/Phys 211/2015 Spring/FCI PrePost Test/ImportToPhysPort_Post_2015.csv"
ImportToPhysPort <- read.csv(filename, stringsAsFactors = FALSE)

# Reads in the FCI key.  This file will NOT be made public!  If you need
# access to it, please go through the proper channels
FCIkey <- read.csv("FCIkey.csv", stringsAsFactors = FALSE)

# function to fix the responses.  This takes in a matrix (our imported csv)
# and goes through each of the question columns, replacing all "$" with 
# the actual response ("A", "B",..., or "E").

fix.responses <- function(matrix, key) {
  for (i in 1:length(key)) matrix[i+4][matrix[i+4] == "$"] <- key[i]
return (matrix)}

# This was some "lapply" stuff I was trying rather than using the loop.
# Clearly, I didn't get far
# lapply(unique_vals, function(elem) elem[2])

exportfilename = paste0("testname","_","fixed",".csv")
# Copies the fixed table to another variable
FixedPostTable <- fix.responses(ImportToPhysPort, FCIkey)

# Writes the fixed table out to a csv file
write.csv(FixedPostTable, file = exportfilename)
