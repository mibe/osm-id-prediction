# Path to database file
path <- "E:\\osm-replicates\\node.db"

# Read database
# 1st col. is the day, 2nd col. is the highest ID for this day
db <- read.table(path, header=FALSE, sep=",",
  colClasses=c("Date", "numeric"), col.names=c("day", "maxid"))
attach(db)

# This is the prediction target (2^31)
# MAXINT = (2^31)-1
targetid <- 2147483648

# Create linear model
model <- lm(day ~ maxid)
summary(lm(maxid ~ day))

# Calculate prediction
prediction <- predict(model, data.frame(maxid = targetid))
# Result is in days from 1970-01-01
as.Date(prediction, origin="1970-01-01")
