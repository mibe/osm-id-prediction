nodes <- read.table("E:\\osm-replicates\\node.db", header=FALSE, sep=",")
nodes$V1 <- as.Date(nodes$V1, "%Y-%m-%d")
plot(V2 ~ V1, nodes, type = "l")
