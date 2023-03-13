# Libraries
#install.packages("dplyr")
#install.packages("hrbrthemes")
#install.packages("magrittr")
#install.packages("stringr")

library(dplyr)
library(hrbrthemes)
library(magrittr)
library(stringr)

#Gets all simulation files of all settings.
#city: Can be either Venice or SanFran.
sortFilesBySetting <- function(city) {
  
  steps <- seq(10, 100, by = 10)
  
  settings <- data.frame(matrix(NA, nrow = 15, ncol = 10))
  

  for (i in steps) {
    path1 <- paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", i, "Nodes/", sep = "")
    files <-list.files(path1, pattern = "(BlossomRouter)(.*)(5MB)(.*)(MessageStatsReport.txt)", full.names = TRUE)
    
    test <- nrow(settings)
    for (j in 1:(nrow(settings) - 3)) {
      settings[j, i/10] = files[j]
    }
    settings[13, i/10] = list.files(path1, pattern = "(ProphetRouter)(.*)(5MB)(.*)(MessageStatsReport.txt)", full.names = TRUE)
    settings[14, i/10] = list.files(path1, pattern = "(FirstContactRouter)(.*)(5MB)(.*)(MessageStatsReport.txt)", full.names = TRUE)
    settings[15, i/10] = list.files(path1, pattern = "(EpidemicRouter)(.*)(5MB)(.*)(MessageStatsReport.txt)", full.names = TRUE)
  }

  return(settings)
}

#Gets the stats of the given datafiles for a certain density of nodes.
#datafiles: table containing all files.
generateStats <- function(dataFiles) {
  DP = c()
  Drop = c()
  OverHead = c()
  LatencyAvg = c()
  Settings = c()
  
  nrSetting = 1
  
  for(i in dataFiles) {
    nrSettingString = paste("(", nrSetting, ")", sep="")
    my_data <- read.delim(i, sep =" ")
    
    DP = round(c(DP, my_data$stats[9]), digits = 3)
    Drop = c(Drop, my_data$stats[10])
    OverHead = round(c(OverHead, my_data$stats[12]), digits = 2)
    LatencyAvg = c(LatencyAvg,  my_data$stats[13])
    
    if(grepl("Prophet", i)) {
      Algorithm = "PRoPHET"
    } else if (grepl("Epidemic", i)) {
      Algorithm = "Epidemic"
    } else if (grepl("FirstContact", i)) {
      Algorithm = "Fist Contact"
    } else {
      Algorithm = paste(sub('../../../../BlossomClustering', '', str_extract(i, "[MB](?=0)(.*)(A)")), nrSettingString, sep=" ")
    }
    
    Settings = c(Settings, Algorithm)
    
    nrSetting = nrSetting + 1
  }
  
  stats <- cbind(DP, Drop, OverHead, LatencyAvg, Settings)
  
  return(stats)
}

#Gets the stats of the given datafiles for all densities of nodes.
#datafiles: table containing all files.
generateStatsforAllCombinations <- function(city) {
  settingsBlossom <- sortFilesBySetting(city) 
  
  stats <- c()
  
  for (i in 1:ncol(settingsBlossom)) {
    currentStats <- generateStats(settingsBlossom[, i])
    
    stats = rbind(stats, currentStats)
  }
  
  return(as.data.frame(stats))
}

city <- "SanFran"
#city <- "Venice"

allSettings <- generateStatsforAllCombinations(city)
allSettings$NrOfNodes <- c(rep(10, 15), rep(20, 15), rep(30, 15), rep(40, 15), rep(50, 15), rep(60, 15), rep(70, 15), rep(80, 15), rep(90, 15), rep(100, 15))

write.csv(allSettings, paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", city, "AllSettings.csv", sep = ""))