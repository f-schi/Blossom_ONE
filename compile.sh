targetdir=target

if [ ! -d "$targetdir" ]; then mkdir $targetdir; fi

javac -sourcepath src -d $targetdir -extdirs lib/ src/main/java/core/*.java src/main/java/movement/*.java src/report/*.java src/main/java/routing/*.java src/main/java/gui/*.java src/main/java/input/*.java src/main/java/applications/*.java src/main/java/interfaces/*.java

if [ ! -d "$targetdir/gui/buttonGraphics" ]; then cp -R src/main/java/gui/buttonGraphics target/gui/; fi
	
