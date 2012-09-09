# Read node database; V1 = day, V2 = max. ID for this day
nodes <- read.table("E:\\osm-replicates\\node.db", header=FALSE, sep=",")
# Set V1 as date
nodes$V1 <- as.Date(nodes$V1, "%Y-%m-%d")
# Plot as line
plot(V2 ~ V1, nodes, type = "l", yaxt = "n", xlab="Date", ylab="ID")
axis(2, nodes$V2)
