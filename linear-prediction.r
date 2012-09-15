# Read node database; 1st col. is the day, 2nd col. is the max. ID for this day
nodes <- read.table("E:\\osm-replicates\\node.db", header=FALSE, sep=",",
  colClasses=c("Date", "numeric"), col.names=c("day", "maxid"))
attach(nodes)

# This is our prediction target (2^31 + 1)
targetid <- 2147483649

# Create linear model
model <- lm(day ~ maxid)
summary(lm(maxid ~ day))

# Calculate prediction
prediction <- predict(model, data.frame(maxid = targetid))
# Result is in days from 1970-01-01
as.Date(prediction, origin="1970-01-01")
