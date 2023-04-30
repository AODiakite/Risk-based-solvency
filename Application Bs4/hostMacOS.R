#' Publishing Shiny app to public server on macOS
# Set the path of the folder containing the Shiny app
require(shiny)
folder_address <- "/Users/abdouloudoussdiakite/Desktop/PFE/Risk based solvency/Application Bs4"

# Get the IPv4 address of the machine running the app
x <- system("ifconfig", intern = TRUE) # Use "ifconfig" command on macOS
z <- x[grep("inet ", x)] # Search for "inet " string in the output
ip <- gsub(".*?inet ([[:digit:].]+).*", "\\1", z) # Extract the IP address using regex

# Print the link to access the app
cat(paste0("Shiny Web application runs on: http://", ip, ":1235/\n"))
cat("Please save the link above !\n")

# Launch the app on the specified port and IP address
shiny::runApp(folder_address, launch.browser = TRUE, port = 1235, host = ifelse(length(ip)>1,ip[2],ip))
