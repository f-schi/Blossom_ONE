library(proxy)

# write inputData to CSV
print(hostNames)
write.table(paste(unlist(inputData),collapse=" "), file = "inputDataClusterAnalysisR.csv", sep = ",",
            append = TRUE, quote = TRUE,
            col.names = FALSE, row.names = FALSE)

gowerDistanceDegree <- function(x, y)  {
  absoluteDifference <- abs(x - y)
  distanceVector <- c(absoluteDifference, 360 - absoluteDifference)
  distance <- min(distanceVector)
  distance / 180
}

dmat <- proxy::dist(inputData, method = gowerDistanceDegree )

shier <- hclust(dmat, method="average")

cutree(shier , h = maxHeight)
