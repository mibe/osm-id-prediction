# Path to database file
path <- "E:\\osm-replicates\\node.db"

# Read database
# 1st col. is the day, 2nd col. is the highest ID for this day
db <- read.table(path, header=FALSE, sep=",",
  colClasses=c("Date", "numeric"), col.names=c("day", "maxid"))
attach(db)

# Build linar regression model
reg = lm(maxid ~ day)
reg30 = lm(maxid ~ day, tail(db, n=30))
reg90 = lm(maxid ~ day, tail(db, n=90))

# Plot everything
plot(maxid ~ day, db, type = "l", yaxt = "n", xlab="Date", ylab="ID")
axis(2, maxid)
axis.Date(3, day, format="%Y-%m-%d")

# Regression lines
abline(reg, col="red")
abline(reg30, col="blue")
abline(reg90, col="green")

# Legend
legend(min(day), max(maxid),
  c("highest ID per day", "all data", "last 30 days", "last 90 days"),
  lty=c(1,1,1,1), lwd=c(2,2,2,2), col=c("black","red","blue","green"))

# LOWESS
#low = lowess(db)
#lines(low, col="blue")

detach(db)
