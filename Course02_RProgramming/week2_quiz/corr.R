corr <- function(directory, threshold = 0){
        cc <- complete(directory)
        cc_threshold_ID <- subset(cc, cc[, 'nobs'] > threshold, select = 'id')[, 1]
        
        # create files list
        # filenames <- list.files(directory, pattern = '*.csv')
        
        # create vector to store data
        cr <-numeric()
        
        
        #loop over id's
        for(i in cc_threshold_ID){
            filename <- sprintf('%03d.csv', i)
            filepath <- paste(directory, filename, sep = '/')
            ## load data
            data <- read.csv(filepath)
            
            ## process data
            data <- subset(data, !is.na(data[, 2]) & !is.na(data[, 3]), 
                           select = c('sulfate', 'nitrate'))
            
            ## corr data1&data2
            data_corr <- cor(data[, 1], data[, 2])
            
            cr <- c(cr, data_corr)
        }
        cr
        
}