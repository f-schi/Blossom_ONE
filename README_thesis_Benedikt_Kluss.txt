Scripts of the routing algorithm can be found in src/java/routing/BlossomRouter.

Additional helper scripts are in  src/java/routing/BlossomUtilities
This directory contains the following 5 files.
- The AssignClusterLogic for assigning nodes to a cluster.
- BlossomSecurity which holds the functionalities of BlosSec.
- Cluster: Class for Cluster itself.
- ClusterAnalysisRenjin which handles the call of the R script in src/R/ClusterAnalysis.R
- Direction: Class of Directions itself.

In  src/java/report/ClusterStatsReport is the report generated for the cluster stats.

In report/ are all evaluation files
- evaluationSrc: Holds the matlab and R files which handles plots and gathering all stats.
- SanFran: Holds all report files for San Francisco
- Venice: Holds all report files for Venice

In both city folder are .csv files with all gathered data for the matlab plots (report/SanFran or report/Venice).
Each node density folder contains all settings report of Blossom, First Contact, Epidemic and PRoPHET.
Additionally there different seed files in the Seed folder.
In the Seed folder there ist the BlosSec folder holding all report with different seeds of the security layer BlosSec.

Examplary default_settings in the main directory are
default_settings.txt
default_settings2.txt
default_settings3.txt
default_settings4.txt

The whole project in compiled with maven and needs to be loaded as a maven project.
The pom.xml files holds all settings to do so.
To run the project please use the DTNSim file in the src/core/ directory.


