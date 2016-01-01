# Install packages if needed.
packages <- c("mongolite", "ggplot2")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

library(mongolite)
require(ggplot2)

# Connect to database.
mongo <- mongo('collection_name', url = 'mongodb://user:pw@host.mongo.com:12345/dbname')

# Find all records.
docs <- mongo$find()

# Format date column. Remove EST or EDT from dates.
docs$date <- as.POSIXlt(gsub("EDT|EST", "", docs$EventDate), format = "%Y-%m-%d %H:%M:%S")

# Order data by date.
sorted <- docs[order(docs$date),]

# Plot chart.
g <- ggplot(data=sorted, aes(x=date, y=Users)) + xlab("Date") + ggtitle("My Extension Active Users") + geom_line()
g <- g + geom_smooth()
g
