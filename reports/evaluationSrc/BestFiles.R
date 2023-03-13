# Libraries
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("hrbrthemes")
#install.packages("magrittr")

library(magrittr)
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(RColorBrewer)
library(stringr)

#Generate the stats for all algorithm including the best files of Blossom for each node density.


#Gets all the seed files in path declared in line 22.
#city: Can be either Venice or SanFran.
#algorithm: Can be either BlossomRouter, FirstContact, Epidemic or ProphetRouter
getSeedsOfAlgorithm <- function(city, algorithm) {
  settings <- data.frame(matrix(NA, nrow = 4, ncol = 10))
  
  steps <- seq(10, 100, by = 10)
  for(i in steps ) {
    
  
  path1 <- paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", i, "Nodes/Seed", sep = "")
  pattern <- paste("(",algorithm,")(.*)(5MB)(.*)(MessageStatsReport.txt)", sep = "")
  files <-list.files(path1, pattern = pattern, full.names = TRUE)
  
  
  settings[1, i/10] = files[1]
  settings[2, i/10] = files[2]
  settings[3, i/10] = files[3]
  settings[4, i/10] = files[4]
  }
  
  return(settings)
}

#Gets all simulation files and chooses for Blossom the best setting.
#city: Can be either Venice or SanFran.
sortFilesBySetting <- function(city) {
  
  steps <- seq(10, 100, by = 10)
  
  settings <- data.frame(matrix(NA, nrow = 4, ncol = 10))
  
  
  for (i in steps) {
    path1 <- paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", i, "Nodes", sep = "")
    files <-list.files(path1, pattern = "(BlossomRouter)(.*)(5MB)(.*)(MessageStatsReport.txt)", full.names = TRUE)
    
    
    bestDP = 0
    bestOH = 100
    bestBlossom = ""
    
    for (j in 1:length(files)) {
      currentfile <- files[j]
      my_data <- read.delim(currentfile, sep =" ")
      DP = my_data$stats[9]
      OH = my_data$stats[12]
      
      if(bestDP <= DP && bestOH > OH) {
        bestBlossom <- currentfile
        bestDP = DP
        bestOH = OH
      }
    }
    settings[1, i/10] = bestBlossom
    settings[2, i/10] = list.files(path1, pattern = "(ProphetRouter)(.*)(5MB)(.*)(MessageStatsReport.txt)", full.names = TRUE)
    settings[3, i/10] = list.files(path1, pattern = "(FirstContactRouter)(.*)(5MB)(.*)(MessageStatsReport.txt)", full.names = TRUE)
    settings[4, i/10] = list.files(path1, pattern = "(EpidemicRouter)(.*)(5MB)(.*)(MessageStatsReport.txt)", full.names = TRUE)
  }
  
  return(settings)
}

#Gets the stats from the given files of a certain node density
generateStats <- function(dataFiles) {
  DP = c()
  Drop = c()
  OverHead = c()
  LatencyAvg = c()


  for(i in dataFiles) {
    my_data <- read.delim(i, sep =" ")

    DP = c(DP, my_data$stats[9])
    Drop = c(Drop, my_data$stats[6] / (my_data$stats[2] + my_data$stats[3]))
    OverHead = c(OverHead, my_data$stats[12])
    LatencyAvg = c(LatencyAvg,  my_data$stats[13])
  }

  stats <- cbind(DP, Drop, OverHead, LatencyAvg)

  return(stats)
}

#Gets all Stats for all densities
#city: Can be either Venice or SanFran.
#files: All files
generateAllStats <- function(city, files) {
  stats <- generateStats(files[1, ])
  
  for(i in 2:nrow(files)) {
    stats <- rbind(stats, generateStats(files[i, ]))
  }
  
  return(stats)
}

#Generates a data frame with all files for all algorithms
city <- "Venice"
files <- sortFilesBySetting(city)
files <- rbind(files, getSeedsOfAlgorithm(city, "BlossomRouter"))
files <- rbind(files, getSeedsOfAlgorithm(city, "ProphetRouter"))
files <- rbind(files, getSeedsOfAlgorithm(city, "FirstContact"))
files <- rbind(files, getSeedsOfAlgorithm(city, "Epidemic"))

#Call for all files and adds the algorithm names and node densities
sanFran <- as.data.frame(generateAllStats(city, files))
AlgorithmColumn <- c(rep("Blossom", 10), rep("PRoPHET", 10), rep("FirstContact", 10), rep("Epidemic", 10), rep("Blossom", 40), rep("PRoPHET", 40), rep("FirstContact", 40), rep("Epidemic", 40) )
sanFran$Algorithm <- AlgorithmColumn
Nodes <-rep(c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100), 4)
sanFran$NrOfNodes <- Nodes 

#Save
write.csv(sanFran, paste("/Users/benny/IdeaProjects/the-one-Maven/reports/",city, "/", city, "BestSimulation.csv", sep = ""))