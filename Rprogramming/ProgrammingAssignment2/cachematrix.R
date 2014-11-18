
# Your assignment is to write a pair of functions that cache the inverse of a matrix.

# Write the following functions:
    
# makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.
# cacheSolve: This function computes the inverse of the special "matrix" returned by makeCacheMatrix 
# above. 

# Computing the inverse of a square matrix can be done with the solve function in R. For example, if 
# X is a square invertible matrix, then solve(X) returns its inverse.

# For this assignment, assume that the matrix supplied is always invertible.


    makeCacheMatrix <- function( m = matrix() ) 
    {
        i <- NULL   # Initialize the inverse
    
        # Method to set the matrix
        set <- function( matrix ) 
        {
            # superassignment operator: <<-
            m <<- matrix
            i <<- NULL
        }
    
    
    # Method the get the matrix
    get <- function() m
        
    # Method to set the inverse of the matrix
    setInverse <- function(inverse)
    {
        # superassignment operator: <<-
        i <<- inverse
    }
    
    # Method to get the inverse of the matrix
    getInverse <- function() i
    
    
    
    # Return the matrix list of the methods to call by name
    # Example: amatrix$get()
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}

# Compute the inverse of the special matrix returned by "makeCacheMatrix"
# above. If the inverse has already been calculated (and the matrix has not
# changed), then the "cachesolve" should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) 
{
    # Return a matrix inverse of 'x'
    m <- x$getInverse()
    
    # Already set - just return it
    if(!is.null(m) ) 
    {
        message("getting cached data")
        return(m)
    }
    else
    {
        # Get the matrix 
        data <- x$get()
    
        # Calculate the inverse 
        m <- solve(x$get())
    
        # Set the inverse to the object
        x$setInverse(m)
    
        return(m)
    }
}
   
