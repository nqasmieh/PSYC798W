# Complete all of the items below
# Use comments where you're having trouble or questions


# 1. Read your data set into R
library(haven)
SAS.data <- read_sav("QASMIEH_DATASET_PSYC798W.sav")

#I keep seeing read.sav("QASMIEH_DATASET_PSYC798W.sav") in the console after running code from the first half of this assignment; 
#   is this the right way to read in a dataset? 

# 2. Peek at the top few rows
head(SAS.data)

# 3. Peek at the top few rows for only a few columns
head(SAS.data$GROUPAB)
head(SAS.data$SAFE)

# 4. How many rows does your data have?
nrow(SAS.data)

# 5. Get a summary for every column
summary(SAS.data)

# 6. Get a summary for one column
summary(SAS.data$SAFE_TOTAL_C)

# 7. Are any of the columns giving you unexpected values?
#No, everything looks reasonable

# 8. Select a few key columns, make a vector of the column names
colnames(SAS.data)
SAS.vector <- c( "MASTER_ID","GROUPAB" ,"SAFE_TOTAL_C", "SAFE_TOTAL_P", "spaicctot", "spaicptot" )

# 9. Create a new data.frame with just that subset of columns
SAS.df <- SAS.data[,SAS.vector]
View(SAS.df)

# 10. Create a new data.frame that is just the first 10 rows
#     and the last 10 rows of the data from the previous step

head.SAS.df <- head (SAS.df, 10)
head.SAS.df
tail.SAS.df <- tail (SAS.df, 10)
tail.SAS.df


SAS.20df <- rbind.data.frame(head.SAS.df, tail.SAS.df) 
View(SAS.20df)

#wasn't sure how to do this one without using rbind; i tried the following code below after defining the head and tail vectors 
#       but it only yanked the first 10 rows and not the last 10 as well
#         SAS.reduced <- c(head.SAS.df, tail.SAS.df)
#         SAS.final <- SAS.data[,SAS.reduced]



# 11. Create a new data.frame that is a random sample of half of the rows.
# HINT: ?sample
library(dplyr)
set.seed(666)
SAS.random <- sample_n(SAS.data, (nrow(SAS.data)/2) )
View(SAS.random)

# 12. Find a comparison in your data that is interesting to make
#     (comparing two sets of numbers)
#     - run a t.test for that comparison
#     - decide whether you need a non-default test
#       (e.g., Student's, paired)
#     - run the t.test with BOTH the formula and "vector"
#       formats, if possible
#     - if one is NOT possible, say why you can't do it

library(car)
SAS.df$GROUPAB <- as.factor(SAS.df$GROUPAB)
leveneTest(SAS.df$SAFE_TOTAL_C, SAS.df$GROUPAB)
#Different variances between study groups, will use Welch's t test; not paired because each case is an independent/unmatched observation

SAS.AGROUP <- SAS.df$SAFE_TOTAL_C[SAS.df$GROUPAB=="1"]
SAS.BGROUP <- SAS.df$SAFE_TOTAL_C[SAS.df$GROUPAB=="0"]

SAS.ttest.vector <- t.test (SAS.AGROUP, SAS.BGROUP)
SAS.ttest.vector

SAS.ttest.alt <- t.test(SAS.df$SAFE_TOTAL_C[SAS.df$GROUPAB=="1"],  SAS.df$SAFE_TOTAL_C[SAS.df$GROUPAB=="0"])
SAS.ttest.alt


# 13. Repeat #12 for TWO more comparisons
#     - ALTERNATIVELY, if correlations are more interesting,
#       do those instead of t-tests (and try both Spearman and
#       Pearson correlations)
#     - Tip: it's okay if the comparisons are kind of nonsensical, this is 
#       just a programming exercise

Teen.Parent.SAFE.correlation <- cor(SAS.df$SAFE_TOTAL_C, SAS.df$SAFE_TOTAL_P)
Teen.Parent.SAFE.correlation
Teen.SAFE.SAM.correlation <- cor(SAS.data$SAFE_TOTAL_C, SAS.data$TEEN_SAM_COMP_ALL_TASKS)   
Teen.SAFE.SAM.correlation  

# 14. Save all results from #12 and #13 in an .RData file
save(SAS.ttest.vector, SAS.ttest.alt, Teen.Parent.SAFE.correlation, Teen.SAFE.SAM.correlation,
     file = "HW2_Results_QASMIEH.RData")



# 15. Email me your version of this script, PLUS the .RData
#     file from #14
#     - ALTERNATIVELY, push your version of this script and your .RData results
#       to a repo on GitHub, and send me the link


