# Path to database file
path <- "E:\\osm-replicates\\node.db"

# Read database
# 1st col. is the day, 2nd col. is the highest ID for this day
db <- read.table(path, header=FALSE, sep=",",
  colClasses=c("Date", "numeric"), col.names=c("day", "maxid"))
attach(db)

# Plot as line
plot(maxid ~ day, db, type = "l", yaxt = "n", xlab="Date", ylab="ID")
axis(2, maxid)

# Regression line
reg = lm(maxid ~ day)
abline(reg, col="red")

# LOWESS
low = lowess(db)
lines(low, col="blue")

detach(db)
