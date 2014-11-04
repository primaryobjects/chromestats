# Install packages if needed.
packages <- c("RMongo", "ggplot2")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

require(RMongo)
require(ggplot2)

# Connect to QA database.
mongo <- mongoDbConnect("dbname", "host.mongo.com", 12345)

# Login.
auth <- dbAuthenticate(mongo, "username", "password")

# Find all published stories.
docs <- dbGetQuery(mongo, "analytics", "", 0, 9999999)

# Disconnect from the database.
dbDisconnect(mongo)

# Format date column. Remove EST or EDT from dates.
docs$date <- as.POSIXlt(gsub("EDT|EST", "", docs$EventDate), format = "%a %b %d %H:%M:%S %Y")

# Order data by date.
sorted <- docs[order(docs$date),]

# Plot chart.
g <- ggplot(data=sorted, aes(x=date, y=Users)) + xlab("Date") + ggtitle("My Extension Active Users") + geom_line()
g <- g + geom_smooth()
