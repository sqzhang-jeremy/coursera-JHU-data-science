### Week1

#### datatype

- atomic classes: character, numeric, integer, complex, logical
- vector
- multitype i.e. y <- c(FALSE, 2 )
- matrix
- factor
- missing values
  - NaN is used for undefined mathematical operations
  - NA is used for everything else.
  - NA deduce NaN but inverse is wrong
- Dataframe

### Week2

#### Coding Standards

1. Use a text editor and save your file with the ASCII character set.

2. Indent your code

3. Limit the width of your code (80 columns?)

4. Limit the length of individual functions (one basic activity)

#### Dates and Time

- Dates and times have special classes in R that allow for numerical and statistical calculations

- Dates use the Date class
- Times use the POSIXct and POSIXlt class   

- Character strings can be coerced to Date/Time classes using the strptime function or the as.Date, as.POSIXlt, or as.POSIXct functions

### Week3

#### Loop and Debug

1lapply

2apply(x, margin, fun)

3mapply(fun, more arguments, simplify)

4tapply(x, factor, fun, …(other argument pass to fun), simplify)

5split(x, factor, drop)

#### Debugging

How do you know that sth. is wrong with ur function?

- What was your input? How did you call the function?
-  What were you expecting? Output, message, other results?
- What did you get?
- How does what you get differ from what you were expecting?
- Were your expectations correct in the first place?
- Can you reproduce the problem(exactly)?

When error occurs, traceback() anyway.

#### Funtions

**traceback, debug, browser, trace, and recover**

##### traceback

   traceback() function shows you how many levels deep you were when the error occurred.

   Looking at the traceback is useful for figuring out roughly where an error occurred but it’s not useful for more detailed debugging

##### debug

  Debug()  function goes down into the debugging model, undebug() function turn off the interactive debugging 

   n executes the current expression and moves to the next expression

   c continues execution of the function and does not stop until either an error or the function

##### exits

   Q quits the browser

##### trace()

   trace(): allows you to insert debugging code into a function a specific places

##### recover()

   recover(): allows you to modify the error behavior so that you can browse the function call 

stack options(error=recover)

   recover() function will first print out the function call stack when an error occurrs. Then, you can choose to jump around the call stack and investigate the problem. When you choose a frame number, you will be put in the browser (just like the interactive debugger triggered withdebug()) and will have the ability to poke around.

### Week4

1Str() Function

2Generate random numbers

1)

\* rnorm(): generate random Normal variates with a given mean and standard deviation

\* dnorm(): evaluate the Normal probability density (with a given mean/SD) at a point (or vector of points)

\* pnorm(): evaluate the cumulative distribution function for a Normal distribution

\* rpois(): generate random Poisson variates with a given rate

2)

\# linear model

\> set.seed(20)

\> x <- rnorm(100)

\> e <- rnorm(100, 0, 2)

\> y <- 0.5 + 2 * x + e

\> summary(y)

  Min. 1st Qu. Median  Mean 3rd Qu.  Max.

-6.4080 -1.5400 0.6789 0.6893 2.9300 6.5050

\> plot(x, y)

\# binomial distribution

\> set.seed(10)

\> x <- rbinom(100, 1, 0.5)

\> e <- rnorm(100, 0, 2)

\> y <- 0.5 + 2 * x + e

\> summary(y)

  Min. 1st Qu. Median  Mean 3rd Qu.  Max.

-3.4940 -0.1409 1.5770 1.4320 2.8400 6.9410

\> plot(x, y)

3Random sampling

4R profile

1)system.time()

\* Returns an object of class proc_time

  \* user time: time charged to the CPU(s) for this expression

  \* elapsed time: "wall clock" time

\* Usually the user time and elapsed time are relatively close fro straight computing tasks

\* Elapsed time may be greater than user time if the CPU spends a lot of time waiting around

\* Elapsed time may be smaller than the user time if your machine has multiple cores/processors (and is capable of using them)

\* Multi-threaded BLAS libraries (vecLib/Accelerate, ATLAS, ACML, MKL) 

\* Parallel processing via the parallel package



### Swirl

Basic :'Take nothing but pictures. Leave nothing but footprints.'

#### 0Find help

​     1?function name. i.e. ?

​     2 help.start()

#### 1synatax

​     1list.files()=dir()

​     2setwd()/getwd()

​     3file.exists()

​     4file.path()=os.path.join()

​     5dir.create(file.path('testdir2', 'testdir3'), recursive = TRUE)#nested create path

#### 2numbers and sequence

​     1seq_along(my_seq)=1:length(my_seq)

​     2seq(from, to, by/length)by=momentum

​     3rep(data, times)

#### 3Vector

​     1paste(my_char, collapse = ' ‘)

​     2paste('Hello', 'world!', sep = ' ‘)

​     3paste(1:3, c('X', 'Y', 'Z'), sep = ‘') #[1] "1X" "2Y" “3Z"

#### 4Missing Values

​     1is.na()

​     2!is.na()

#### 5subset vector

​     1[!is.na(x) & x > 0]

​     2

#### 6Matrices and Data Frames

​     1dim(): The dim() function allows you to get OR set the `dim` attribute

​     2data.frame: can have 不同class

​     3data.frame: colnames(data_frame)赋值 

#### 7Logical

​     1length(3 >1) = 1

#### 8Function

​     1To understand computations in R, two slogans are helpful: 

​       1. Everything that exists is an object. 

​       2. Everything that happens is a function call.

​       3 x[-1], x[0], x[-2], x[-3]. It's quite different with python.

####  9Dates and Times

​     Dates are represented by the 'Date' class and times are represented by the| 'POSIXct' and 'POSIXlt' classes. Internally, dates are stored as the number of | days since 1970-01-01 and times are stored as either the number of seconds since | 1970-01-01 (for 'POSIXct') or a list of seconds, minutes, hours, etc. (for | 'POSIXlt’).

#### 10lapply and sapply

​     Split-Apply-Combine strategy

​     1lapply():The lapply() function takes a list as input, applies a function to each element of the list,| then returns a list of the same length as the original one.

​     2sapply():sapply() allows you to automate this process by calling lapply() behind the scenes, but then| attempting to simplify (hence the 's' in 'sapply') the result for you. Use sapply() the same | way you used lapply() to get the class of each column of the flags dataset and store the | result in cls_vect.

​     两者区别在于后者能尽可能的精简，list 2 char/matrix

#### 11vapply and tapply

​     vapply() as being 'safer' than sapply(), since it requires you to specify| the format of the output in advance, instead of just allowing R to 'guess' what you wanted. | In addition, vapply() may perform faster than sapply() for large datasets. However, when | doing data analysis interactively (at the prompt), sapply() saves you some typing and will | often be good enough.

​     tapply(): split ur data into groups based on the value of some variables, and apply a fun to each group

#### 12Looking at data

​     1head()+tail()

​     2summary()反应数据分布信息，numeric会display NA

#### 13Simulation

​     rnorm(), rbinomial, hist(cm), replicate(time, fun)