pollutantmean <- function(directory, pollutant, id = 1:332){
    # Get a list of filenames
    filenames <- list.files(path = directory, pattern = '*.csv')
    
    # Initialized a vector to hold values
    vals <- vector()
    
    # loop over the passed id's
    for(i in id){
        ## Pad the i to create a filename
        filename <- sprintf('%03d.csv', i)
        filepath <- paste(directory, filename, sep = '/')
        
        ## load the data
        data <- read.csv(filepath)[, pollutant]
        
        ## process the NA data
        data <- data[!is.na(data)]
        
        ## concatenate
        vals <- c(vals, data)
    }
    
    # calculate the final mean
    round(mean(vals), digits = 3)
   
    # x
    # pollutant_col <- subset(x, !is.na(pollutant), select = pollutant)
    # apply(pollutant_col, 2, mean)
    
}