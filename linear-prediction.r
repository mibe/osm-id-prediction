# Path to database file
path <- "E:\\osm-replicates\\node.db"

# Read database
# 1st col. is the day, 2nd col. is the highest ID for this day
db <- read.table(path, header=FALSE, sep=",",
  colClasses=c("Date", "numeric"), col.names=c("day", "maxid"))

# This is the prediction target (2^31)
# MAXINT = (2^31)-1
targetid <- 2147483648

# Only use the data from the last 30 days for the
# linear model
db <- tail(db, n=30)

# Create linear model
model <- lm(day ~ maxid, db)
summary(lm(maxid ~ day, db))

# Calculate prediction
prediction <- predict(model, data.frame(maxid = targetid))

# Prediction result is in days from 1970-01-01
as.Date(prediction, origin="1970-01-01")
