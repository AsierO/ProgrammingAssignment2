## How to use it:
# x <- matrix(rnorm(25), nrow = 5)          // Create a matrix x
# mx <- makeCacheMatrix(x)                  // Create the special matrix (see below)
# cacheSolve(mx)                            // Obtain the inverse
# cacheSolve(mx)                            // Call again so it returns the cached value (observe the message)
# mx$get() %*% cacheSolve(mx)               // Multiply the matrix by the inverse in order to check that we obtain an unity matrix.



## The first function, makeCacheMatrix creates a special "matrix", which is really a list containing a function to

#1.-set the value of the matrix
#2.-get the value of the matrix
#3.-set the value of the inverse
#4.-get the value of the inverse


makeCacheMatrix <- function(x = matrix()) {

        inv <- NULL
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setinverse <- function(inverse) inv <<- inverse
        getinverse <- function() inv
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
        
}


## The following function calculates the inverse of the special "matrix" created with the above function. 
##However, it first checks to see if the inverse has already been calculated. 
##If so, it gets the inverse from the cache and skips the computation. 
##Otherwise, it calculates the inverse of the data and sets the value of the inverse in the cache via the setinverse function.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        
        inv <- x$getinverse()
        if(!is.null(inv)) {
                message("Getting cached data of inverse matrix...")
                return(inv)
        }
        data <- x$get()
        inv <- solve(data, ...)
        x$setinverse(inv)
        inv
}
