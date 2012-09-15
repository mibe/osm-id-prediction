# Read node database; V1 = day, V2 = max. ID for this day
nodes <- read.table("E:\\osm-replicates\\node.db", header=FALSE, sep=",",
  colClasses=c("Date", "numeric"), col.names=c("day", "maxid"))
attach(nodes)

# Plot as line
plot(maxid ~ day, nodes, type = "l", yaxt = "n", xlab="Date", ylab="ID")
axis(2, maxid)

# Regression line
reg = lm(maxid ~ day)
abline(reg, col="red")

# LOWESS
low = lowess(maxid, day)
lines(low, col="blue")
