## Here is how you should test my script:

## Source the script in RStudio to load the functions

## I'll comment the instructions so that they don't intefere with running of the script

## x = matrix(c(2, 3, 1, 4), nrow=2, ncol=2) ## create a 2,2 matrix
## class(x) ## it shows the class of x variable which will be a matrix
## xx <- makeCacheMatrix(x) ## Assigns get, set, getinv and setinv functions to xx
## xx$get() ## it gets the x matrix
## xx$getinv() ## prints inverse if exists else NULL
## xx$setinv(solve(x)) ## It uses solve command to set the inverse of matrix and caches it for later use
## xx$getinverse() ## it prints the inverse matrix.

## If you want to test the Caching functionality run the following commands
# x = matrix(c(2, 3, 1, 4), nrow=2, ncol=2)
# xx = makeCacheMatrix(x)
# You will see
#> cacheSolve(xx)
#[,1] [,2]
#[1,]  0.8 -0.2
#[2,] -0.6  0.4

# If you call the function again it will read the value from cache as shown below
# cacheSolve(xx)
#getting cached data
#[,1] [,2]
#[1,]  0.8 -0.2
#[2,] -0.6  0.4
#_______________________________________________________________________________
## ____________________ Start of script_________________________________________
#_______________________________________________________________________________

## This craetes a list of functions operating on matrix for caching the inverse

makeCacheMatrix <- function(x = matrix()) {
  # Initiate inverse matrix as null
  inverseMatrix <- NULL
  
  # function to set the matrix
  set <- function(y) {
    x <<- y
    inverseMatrix <<- NULL
  }
  #Function to get the matrix
  get <- function() x
  
  #Function to set the inverse of the matrix in cache
  setinv <- function(matrixToCache) inverseMatrix <<- matrixToCache
  
  #Function to get the inverse of the matrix
  getinv <- function() inverseMatrix
  
  # Create a list of matrices
  list(set = set, 
       get = get, 
       setinv = setinv, 
       getinv = getinv)
}


## This function demonstrate reading from cache capability

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  inverseMatrix <- x$getinv()
  if(!is.null(inverseMatrix)) {
    message("getting cached data")
    return(inverseMatrix)
  }
  data <- x$get()
  inverseMatrix <- solve(data,...)
  x$setinv(inverseMatrix)
  inverseMatrix
}
#_______________________________________________________________________________
#---------------------------------------- End of File --------------------------
#_______________________________________________________________________________