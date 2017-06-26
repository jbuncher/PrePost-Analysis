# This is a script to take the scantron results from NDSU and fix them up
# so that they are ready for uploading to the PhysPort Data Explorer.
# They need fixing becaues the correct response is listed as a "$", rather
# than the corresponding choice (one of "A", "B",..., "E").  The only assumption
# that is made is that the imported csv file of responses has the first
# question starting in column 5.  This script will not work if this is
# not the case!

# Imports the data file
filename = "211_2015Sp_FCI_POST"
filename_ext = paste0(filename,".csv")
ImportToPhysPort <- read.csv(filename, stringsAsFactors = FALSE)

# Reads in the FCI key.  This file will NOT be made public!  If you need
# access to it, please go through the proper channels
FCIkey <- read.csv("FCIkey.csv", stringsAsFactors = FALSE, header = FALSE)

# function to fix the responses.  This takes in a matrix (our imported csv)
# and goes through each of the question columns, replacing all "$" with 
# the actual response ("A", "B",..., or "E").

fix.responses <- function(matrix, key) {
  for (i in 1:length(key)) matrix[i+4][matrix[i+4] == "$"] <- key[i]
return (matrix)}

# This was some "lapply" stuff I was trying rather than using the loop.
# Clearly, I didn't get far
# lapply(unique_vals, function(elem) elem[2])

# Create the string for the exported fixed table
exportfilename = paste0(filename,"_","FIXED",".csv")

# Fix the table, using the given key, and convert all of the column types to "character"
# rather than "list"
FixedPostTable <- lapply(fix.responses(ImportToPhysPort, FCIkey), as.character)

# Writes the fixed table out to a csv file
write.csv(FixedPostTable, file = exportfilename)

# function that takes as input the filename of the data to import, and the assessment
# (FCI, CSEM)

import.fix.and.export <- function(stringfilename, assessmentnamestring) {
  # Imports the data file
  filename = stringfilename
  filename_ext = paste0(filename,".csv")
  ImportToPhysPort <- read.csv(filename, stringsAsFactors = FALSE)
}
