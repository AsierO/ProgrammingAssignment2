## How to use it:
# x <- matrix(rnorm(25), nrow = 5)          // Create a matrix x
# mx <- makeCacheMatrix(x)                  // Create the special matrix (see below)
# cacheSolve(mx)                            // Obtain the inverse
# cacheSolve(mx)                            // Call again so it returns the cached value (observe the message)
# mx$get() %*% cacheSolve(mx)               // Multiply the matrix by the inverse in order to check that we obtain an unity matrix.



## The first function, makeCacheMatrix creates a special "matrix", which is really a list containing a function to:


makeCacheMatrix <- function(x = matrix()) {
        
        #1.-set the value of the matrix

        inv <- NULL
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        
        #2.-get the value of the matrix
        
        get <- function() x
        
        #3.-set the value of the inverse
        
        setinverse <- function(inverse) inv <<- inverse
        
        #4.-get the value of the inverse
        
        getinverse <- function() inv
        
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
        
}


## The following function calculates the inverse of the special "matrix" created with the above function. 

cacheSolve <- function(x, ...) {
        
        ##First checks to see if the inverse has already been calculated. 
        
        inv <- x$getinverse()
        if(!is.null(inv)) {
                
                ##If so, it gets the inverse from the cache and skips the computation.
                
                message("Getting cached data of inverse matrix...")
                return(inv)
        }
        
        ##Otherwise, it calculates the inverse of the data and sets the value of the inverse in the cache via the setinverse function.
        
        data <- x$get()
        inv <- solve(data, ...)
        x$setinverse(inv)
        
        ## Return a matrix that is the inverse of 'x'
        
        inv
}
