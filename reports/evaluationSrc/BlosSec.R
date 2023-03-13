#Gets alls message stats files for a certain city
#city: Can be either Venice or SanFran.
sortFilesBySettingSec <- function(city) {
  
  steps <- seq(10, 100, by = 10)
  
  settings <- data.frame(matrix(NA, nrow = 5, ncol = 10))
  
  
  for (i in steps) {
    path1 <- paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", i, "Nodes/Seed/BlosSec/", sep = "")
    files <-list.files(path1, pattern = "(BlossomRouter)(.*)(5MB)(.*)(MessageStatsReport.txt)", full.names = TRUE)
    
    for (j in 1:(nrow(settings))) {
      settings[j, i/10] = files[j]
    }
    
  }
  
  return(settings)
}

#Gets the stats of the given datafiles for a certain density of nodes for BlosSec.
#datafiles: table containing all files.
generateStatsBS <- function(dataFiles) {
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
    
    
    Settings = c(Settings, "BlosSec")
    
    nrSetting = nrSetting + 1
  }
  
  stats <- cbind(DP, Drop, OverHead, LatencyAvg, Settings)
  
  return(stats)
}

#Gets the stats of the given datafiles for all densities of nodes for BlosSec.
#datafiles: table containing all files.
generateStatsforAllCombinationsBS <- function(city) {
  settingsBlossom <- sortFilesBySettingSec(city) 
  
  stats <- c()
  
  for (i in 1:ncol(settingsBlossom)) {
    currentStats <- generateStatsBS(settingsBlossom[, i])
    
    stats = rbind(stats, currentStats)
  }
  
  return(as.data.frame(stats))
}

sf <- "SanFran"

BlosSecSF <- generateStatsforAllCombinationsBS(sf)
BlosSecSF$NrOfNodes <- c(rep(10, 5), rep(20, 5), rep(30, 5), rep(40, 5), rep(50, 5), rep(60, 5), rep(70, 5), rep(80, 5), rep(90, 5), rep(100, 5))

write.csv(BlosSecSF, paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",sf, "/", sf, "BlosSec.csv", sep = ""))

######

venice <- "Venice"

BlosSecV <- generateStatsforAllCombinationsBS(venice)
BlosSecV$NrOfNodes <- c(rep(10, 5), rep(20, 5), rep(30, 5), rep(40, 5), rep(50, 5), rep(60, 5), rep(70, 5), rep(80, 5), rep(90, 5), rep(100, 5))

write.csv(BlosSecV, paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",venice, "/", venice, "BlosSec.csv", sep = ""))


###ClusterStats

#Gets alls cluster stats files for a certain city
#city: Can be either Venice or SanFran.
sortFilesBySettingClusterStatsSec<- function(city) {
  
  steps <- seq(10, 100, by = 10)
  
  settings <- data.frame(matrix(NA, nrow = 5, ncol = 10))
  
  
  for (i in steps) {
    path1 <- paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", i, "Nodes/Seed/BlosSec", sep = "")
    files <-list.files(path1, pattern = "(BlossomRouter)(.*)(5MB)(.*)(ClusterStatsReport.txt)", full.names = TRUE)
    
    for (j in 1:(nrow(settings))) {
      settings[j, i/10] = files[j]
    }
    
  }
  
  return(settings)
}

#Gets all the seed files of Blossom for the cluster stats.
#city: Can be either Venice or SanFran.
getSeedsOfBlossom <- function(city) {
  settings <- data.frame(matrix(NA, nrow = 4, ncol = 10))
  
  steps <- seq(10, 100, by = 10)
  for(i in steps ) {
    
    
    path1 <- paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", i, "Nodes/Seed", sep = "")
    pattern <- paste("(BlossomRouter)(.*)(5MB)(.*)(ClusterStatsReport.txt)", sep = "")
    files <-list.files(path1, pattern = pattern, full.names = TRUE)
    
    
    settings[1, i/10] = files[1]
    settings[2, i/10] = files[2]
    settings[3, i/10] = files[3]
    settings[4, i/10] = files[4]
  }
  
  return(settings)
}

#Gets the cluster stats of the given datafiles for a certain density of nodes.
#datafiles: table containing all files.
#algo: considerd algorithm BlosSec or Blossom
generateStatsClusterStatsSec <- function(dataFiles, algo) {
  clusterSize = c()
  clusterSizeEnd = c()
  Settings = c()
  

  for(i in dataFiles) {
    my_data <- read.delim(i, sep =":")
    
    clusterSize = c(clusterSize, round(my_data[3,1], digits = 3))
    clusterSizeEnd = c(clusterSizeEnd, round(my_data[5,1], digits = 3))

    Settings = c(Settings, algo)
    }
  
  stats <- cbind(clusterSize, clusterSizeEnd, Settings)
  
  return(stats)
}

#Gets the stats of the given datafiles for all densities of nodes.
#city: Can be either Venice or SanFran.
#files: table containing all files.
#algo: considerd algorithm BlosSec or Blossom
generateAllClusterStats <- function(city, files, algo) {
  stats <- c()
  
  for (i in 1:ncol(files)) {
    currentStats <- generateStatsClusterStatsSec(files[, i], algo)
    
    stats = rbind(stats, currentStats)
  }
  
  return(as.data.frame(stats))
}

#BlosSec
algorithm <- "BlosSec"
city <- "Venice"
filesBS <- sortFilesBySettingClusterStatsSec(city)
messageStatsBS <- generateAllClusterStats(city, filesBS, algorithm)
messageStatsBS$NrOfNodes <- c(rep(10, 5), rep(20, 5), rep(30, 5), rep(40, 5), rep(50, 5), rep(60, 5), rep(70, 5), rep(80, 5), rep(90, 5), rep(100, 5))

write.csv(messageStatsBS, paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", city, "BlosSecClusterStats.csv", sep = ""))

city <- "SanFran"
filesBS <- sortFilesBySettingClusterStatsSec(city)
messageStatsBS <- generateAllClusterStats(city, filesBS)
messageStatsBS$NrOfNodes <- c(rep(10, 5), rep(20, 5), rep(30, 5), rep(40, 5), rep(50, 5), rep(60, 5), rep(70, 5), rep(80, 5), rep(90, 5), rep(100, 5))

write.csv(messageStatsBS, paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", city, "BlosSecClusterStats.csv", sep = ""))


#Blossom
algorithm <- "Blossom"
city <- "Venice"
filesBS <- getSeedsOfBlossom(city)
messageStatsBS <- generateAllClusterStats(city, filesBS, algorithm)
messageStatsBS$NrOfNodes <- c(rep(10, 4), rep(20, 4), rep(30, 4), rep(40, 4), rep(50, 4), rep(60, 4), rep(70, 4), rep(80, 4), rep(90, 4), rep(100, 4))

write.csv(messageStatsBS, paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", city, "BlossomClusterStats.csv", sep = ""))

city <- "SanFran"
filesBS <- getSeedsOfBlossom(city)
messageStatsBS <- generateAllClusterStats(city, filesBS, algorithm)
messageStatsBS$NrOfNodes <- c(rep(10, 4), rep(20, 4), rep(30, 4), rep(40, 4), rep(50, 4), rep(60, 4), rep(70, 4), rep(80, 4), rep(90, 4), rep(100, 4))

write.csv(messageStatsBS, paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", city, "BlossomClusterStats.csv", sep = ""))
