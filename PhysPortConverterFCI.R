# This is a script to take the scantron results from NDSU and fix them up
# so that they are ready for uploading to the PhysPort Data Explorer.
# They need fixing becaues the correct response is listed as a "$", rather
# than the corresponding choice (one of "A", "B",..., "E").  The only assumption
# that is made is that the imported csv file of responses has the first
# question starting in column 5.  This script will not work if this is
# not the case!

ImportToPhysPort <- read.csv("~/Teaching/NDSU/Phys 211/2015 Spring/FCI PrePost Test/ImportToPhysPort_Post_2015.csv", stringsAsFactors = FALSE)
read.csv("FCIkey.csv")

fix.responses <- function(matrix) {
  for (i in 1:30) matrix[i+4][matrix[i+4] == "$"] <- FCIkey[i]
return (matrix)}

# lapply(unique_vals, function(elem) elem[2])

FixedPostTable <- ImportToPhysPort
write.csv(FixedPostTable, file = "FixedPostTable.csv")

