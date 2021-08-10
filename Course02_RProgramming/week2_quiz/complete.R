complete <- function(directory, id = 1:332){
    # create files list
    filenames <- list.files(directory, pattern = '*.csv')
    
    # create vector to store data
    vals <- vector()
    
    #loop over id's
    for(i in id){
        filename <- sprintf('%03d.csv', i)
        filepath <- paste(directory, filename, sep = '/')
        
        ## load data
        data <- read.csv(filepath)
        
        ## process data
        data <- subset(data, !is.na(data[, 2]) & !is.na(data[, 3]), 
                       select = ID)
        
        data_col <- nrow(data)
        
        vals <- rbind(vals, c(data[1, 1], data_col))
        
    }
    data_frame <- as.data.frame(vals)
    colnames(data_frame) <- c('id', 'nobs')
    data_frame
    
    
    
    
    
}