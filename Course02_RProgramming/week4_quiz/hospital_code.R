# # my version
# best <- function(state, disease){
#     data <- read.csv('outcome-of-care-measures.csv', na.strings = 'Not Available')
#     if (disease == 'heart attack')
#         flag <- 11
#     else if (disease == 'pneumonia')
#         flag <- 23
# 
#     disease_name <- names(data)[flag]
#     state_name <- names(data)[7]
#     hospital_name <- names(data)[2]
# 
#     select_data <- subset(data, data[, 'State'] == state & !is.na(data[, disease_name]), select = c(hospital_name, disease_name))
#     number <- sort(select_data[, 2], index.return = TRUE)
#     result <- select_data[, 1][number$ix[1]]
#     result
# }
# reference version
best <- function(state, outcome){
    # reads the outcome-of-care-measures.csv file and returns a character vector with the 
    # the name of the hospital that has the best (i.e. lowest) 30-day moratality for the 
    # specified outcome in that state. If there si a tie, the hosptial names are sorted in 
    # alphabetical order and the first hospital in the set would be chosen and returned
    # 
    # """
    # parameters:
    #     input:
    #         state: 2-character abbreviated name of the state
    #         outcome: one of "heart attack", "heart failure", or "pneumonia"
    #     output:
    #         hospitalname
    # """
    rawData <- read.csv('outcome-of-care-measures.csv', na.strings = 'Not Available')
    outcomeData <- rawData[, c(2, 7, 11, 17, 23)]
    colnames(outcomeData) <- c('Hospital', 'State', 'heart attack', 'heart failure', 'pneumonia')
    
    ## Check that state and outcome are valid
    if (state %in% outcomeData[, 2] == FALSE) {
        #if state is not in the state list, stop the function and print error
        stop('invalid state')
    }
    if (outcome %in% colnames(outcomeData)[3:5] == FALSE) {
        #if outcome is not in the outcome list, stop the function and print error
        stop('invalid outcome')
    }
    ## Return hospital name in the state with lowest 30-day death rate
    # select only the query outcome in the state
    selectData <- outcomeData[outcomeData$State == state, c('Hospital', 'State', outcome)]
    # order hospitals alphabetically
    selectData <- selectData[order(selectData$Hospital, decreasing = F), ]
    # change the mortality column into numeric
    #warnings for coercing into NA - suppress this warning in the output
    selectData[, 3] <- suppressWarnings(as.numeric(selectData[, 3]))
    
    ## Return name of the hospital with the lowest 30-day death rate
    #which.min only finds the first occurrence
    #in this case since the hospital data is already sorted, the
    #only hospital name returned will be alphabetical
    select_hospital <- selectData[which.min(selectData[, 3]), 1]
    
    return (select_hospital)
    
}

# # my version
# rankhospital <- function(state, disease, order_name){
#     # read the data
#     data=read.csv('outcome-of-care-measures.csv', na.strings = 'Not Available')
#     # judge the disease tyoe
#     if (disease == 'heart attack')
#         flag <- 11
#     else if (disease == 'pneumonia')
#         flag <- 23
#     # get the column names
#     disease_name <- names(data)[flag]
#     state_name <- names(data)[7]
#     hospital_name <- names(data)[2]
#     
#     # select data required 'state' and !NA 
#     select_data <- subset(data, data[, 'State'] == state & !is.na(data[, disease_name]), select = c(hospital_name, disease_name))
#     # judge order
#     if (order_name == 'worst')
#         order_flag <- nrow(select_data)
#     else if (order_name == 'best')
#         order_flag <- 1
#     else 
#         order_flag <- as.numeric(order_name)
#     # sort the hospital_name alphabetically
#     select_data <- select_data[order(select_data[, 1], decreasing = F), ]
#     number <- sort(select_data[, 2], index.return = TRUE)
#     result <- select_data[, 1][number$ix[order_flag]]
#     
#     return (result)
# }

# rankall <- function(outcome, num = 'best'){
#     #reads the outcome-of-care-measures.csv file and returns a 2-column data frame
#     #containing the hospital in each state that has the ranking specified in num.
# #     """
# #     parameters:
# #         input:
# #             outcome: one of "heart attack", "heart failure", or "pneumonia"
# #             num: order
# #         output:
# #             num-outcome:the first column in the data frame is named hospital, which contains the
# #             hospital name, and the second column is named state, which contains the  2-character
# #             abbreviation for the state name.
# #     """
#     rawData <- read.csv('outcome-of-care-measures.csv', na.strings = 'Not Available')
#     outcomeData <- rawData[, c(2, 7, 11, 17, 23)]
#     colnames(outcomeData) <- c('Hospital', 'State', 'heart attack', 'heart failure', 'pneumonia')
#     ## Select data
#     selectData <- outcomeData[, c('Hospital', 'State', outcome)]
#     selectData[, 3] <- suppressWarnings(as.numeric(selectData[, 3]))
#     #change the mortality column into numeric
#     #warnings for coercing into NA - suppress this warning in the output
#     selectData <- selectData[complete.cases(selectData), ]
#     #remove the NAs
#     selectData <- selectData[order(selectData$Hospital, decreasing = F), ]
#     #order hospitals alphabetically
#     if (num == 'best') {
#         #order the hospitals by smallest mortality on top (rank == 1)
#         selectData <- selectData[order(selectData[, 3], decreasing = F), ]
#         rank <- 1
#     } else if (num == 'worst') {
#         #sort the dataframe by increasing so the first row would be the worst hospital
#         selectData <- selectData[order(selectData[, 3], decreasing = T), ]
#         rank <- 1
#     } else {
#         selectData <- selectData[order(selectData[, 3], decreasing = F), ]
#         rank <- num
#     }
# 
#     ## For each state, find the hospital of the given rank
#     splitData <- split(selectData[, c(1, 3)], selectData$State)
#     #split the hospital data by state and retain the hospital name (col 1) and the
#     #mortality rate (col 2)
#     hospital <- sapply(splitData, function(x) x[rank, 1])
#     #now splitData either is ascending or descending depending on best/worst
#     #regardless, the rank is all the same
#     #use sapply and apply the function that returns a data frame of row == rank,
#     #and hospital name (col 1)
# 
#     hospital <- data.frame(hospital)
#     #make the result a dataframe
#     hospital$state <- row.names(hospital)
#     #add a second column that is the state (also the row names of the hospital df)
# 
#     return(hospital)
# }



# my version
rankall <- function(disease, order_name){

    data <- read.csv('outcome-of-care-measures.csv', na.strings = 'Not Available')

    outcomeData <- data[ ,c(2, 7, 11, 17, 23)]
    colnames(outcomeData) <- c('Hospital', 'State', 'heart attack', 'heart failure', 'pneumonia')

    # select data required !NA
    select_data <- subset(outcomeData, !is.na(outcomeData[, disease]), select = c('Hospital', 'State', disease))
    
    #order hospitals alphabetically
    select_data <- select_data[order(select_data$Hospital, decreasing = F), ]
    
    
    # judge and order
    if (order_name == 'worst'){
        select_data <- select_data[order(select_data[, 3], decreasing = F), ]
        order_flag <- 1
    }else if (order_name == 'best'){
        select_data <- select_data[order(select_data[, 3], decreasing = T), ]
        order_flag <- 1
    }else{
        select_data <- select_data[order(select_data[, 3], decreasing = F), ]
        order_flag <- as.numeric(order_name)
    }


    # # change column names
    # names(order_data)[1] <- 'hospital'
    # names(order_data)[2] <- 'state'

   state_data <- split(select_data[, c(1, 3)], select_data$State)

   hospital <- sapply(state_data, function(x) x[order_flag, 1])
   hospital$state <- row.names(hospital)
   return(hospital)
}




