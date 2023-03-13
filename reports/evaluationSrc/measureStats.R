#This Script is for the evaluation. It needs the other evaluation scripts compiled in advance.

#Calculates the average of given of the delivery probablity (Column can be changed for other stats)
#settingTable: Table with all stats of all settings
#range: range to only consider certain settings 
calcAverageDP <- function(settingTable, range) {
  sum = 0
  counter = 0
  
  for (i in 1:10) {
    for(j in range) { #1:6
      value = (i-1)*15+j
      currentDp = as.numeric(settingTable$DP[value]) 
      sum = sum + currentDp
      counter = counter + 1
    }
  }
  
  return(sum/counter)
}

#Calculates the variance of given of the delivery probablity (Column can be changed for other stats)
#average: the average of the considered stats.
#settingTable: Table with all stats of all settings
#range: range to only consider certain settings 
calcVarianceDP <- function(average, settingTable, range) {
  sum = 0
  counter = 0
  
  for (i in 1:10) {
    for(j in range) {
      value = (i-1)*15+j
      currentVarianz = (average - as.numeric(settingTable$DP[value]))^2
      sum = sum + currentVarianz
      counter = counter + 1
    }
  }
  
  return(sum/counter)
}

allSettingsSF <- generateStatsforAllCombinations("SanFran")
allSettingsSF$NrOfNodes <- c(rep(10, 15), rep(20, 15), rep(30, 15), rep(40, 15), rep(50, 15), rep(60, 15), rep(70, 15), rep(80, 15), rep(90, 15), rep(100, 15))

allSettingsV <- generateStatsforAllCombinations("Venice")
allSettingsV$NrOfNodes <- c(rep(10, 15), rep(20, 15), rep(30, 15), rep(40, 15), rep(50, 15), rep(60, 15), rep(70, 15), rep(80, 15), rep(90, 15), rep(100, 15))

#valuesToCompare <- seq(1, 6, by=1)
#valuesToCompare <- seq(7, 12, by=1)

#valuesToCompare <- c(1, 2, 7, 8)
#valuesToCompare <- c(3, 4, 9, 10)
valuesToCompare <- c(5, 6, 11, 12)


#valuesToCompare <- c(1, 3, 5, 7, 9, 11)
#valuesToCompare <- c(2, 4, 6, 8, 10, 12)


averageSF <- calcAverageDP(allSettingsSF, valuesToCompare)
varianzSF <- calcVarianceDP(averageSF, allSettingsSF, valuesToCompare)

averageV <- calcAverageDP(allSettingsV, valuesToCompare)
varianzV <- calcVarianceDP(averageV, allSettingsV, valuesToCompare)

#averagePrV <- calcAverageDP(allSettingsV, valuesToCompare)
#varianPrV <- calcVarianceDP(averageV, allSettingsV, valuesToCompare)

city <- "SanFran"
files <- sortFilesBySetting(city)
files <- rbind(files, getSeedsOfAlgorithm(city, "BlossomRouter"))
files <- rbind(files, getSeedsOfAlgorithm(city, "ProphetRouter"))
files <- rbind(files, getSeedsOfAlgorithm(city, "FirstContact"))
files <- rbind(files, getSeedsOfAlgorithm(city, "Epidemic"))


sanFran <- as.data.frame(generateAllStats(city, files))
AlgorithmColumn <- c(rep("Blossom", 10), rep("PRoPHET", 10), rep("FirstContact", 10), rep("Epidemic", 10), rep("Blossom", 40), rep("PRoPHET", 40), rep("FirstContact", 40), rep("Epidemic", 40) )
sanFran$Algorithm <- AlgorithmColumn
Nodes <-rep(c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100), 4)
sanFran$NrOfNodes <- Nodes 


#Calculates the average of other considered routing algorithms
#data: the table of all algorithms stats
meanOfOtherAlgorithms <- function(data) {
  fc = c()
  epi = c()
  pro= c()
  
  for (i in 1:nrow(data)) {
    
    row = data[i, ]
    if(is.element("FirstContact", row)) {
      fc = c(fc, data[i, 1])
    }
    if(is.element("Epidemic", row)) {
      epi = c(epi, data[i, 1])
    }
    if(is.element("PRoPHET", row)) {
      pro = c(pro, data[i, 1])
    }
  }
  
  return(c(mean(fc), mean(epi), mean(pro)))
}

meanOfOtherAlgorithms(sanFran)
