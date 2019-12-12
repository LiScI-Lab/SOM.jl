using Primes

function generate_integer_hash_function(a,b,cardinality)
    # cardinality must be prime number
    # a,b: 1 ≤ a ≤ p−1  , 0 ≤ b ≤ p−1
    @assert a < cardinality
    @assert a > 0
    @assert b < cardinality
    @assert b >= 0
    @assert isprime(cardinality)
    m = cardinality
    x -> (x^a%m + b)%m  #TODO use memory-efficient modular exponentiation for better performance
end

"""
# function generate_vector_deterministic_pseudorandom

Generates a pseudorandom vector. For the same hash function it always generates the same vector.
If the hash function is an integer hash from a universal family, the elements of the vector will
obey a continuous uniform distribution.
# Arguments:
- `seed`: A random number chosen by the user to ensure the result is deterministic
- `hash_func`: An integer hash function sampled from a universal family
- `dimension`: number of elements in the vector
"""
function generate_vector_deterministic_pseudorandom(seed,hash_func,dimension)
    [hash_func(x+seed) for x in 1:dimension]
end


"""
# function generate_dataset

Generates a pseudorandom dataset that can be used for benchmarking SOMs.
The elements in the vectors are distributed uniformly between 0 and `max_value`.

# Arguments:
- `number`: Number of rows/entries/vectors/individual iris plants in the dataset
- `dimension`: Number of dimensions/elements in each vector
- `max_value`: The maximum value that an element in a vector can have
- `y`: an optional function to map the uniformly distributed elements to a desired non-uniform distribution
- `params`: Randomness parameters chosen by user to ensure deterministic result
"""
function generate_dataset(number, dimension, max_value, y=(x->x), params = Dict(:a => 13, :b => 17, :hash_seed => 23, :prime => 1013))
    hash_func = generate_integer_hash_function(params[:a],params[:b],params[:prime])

    seed = params[:hash_seed]
    matrix = zeros((number,dimension))
    for i in 1:number
        vector = generate_vector_deterministic_pseudorandom(seed,hash_func,dimension)
        vector = map((x->x*max_value/params[:prime]),vector)
        vector = map((x->(x+max_value)/2),vector)
        vector = map(y,vector)
        seed = hash_func(seed+i)
        matrix[i,:] = vector
    end
    convert(DataFrame,matrix)
end



# Benchmarking functions
# ======================

function benchmark_init(train, topol; toroidal = false,
                    normType = :zscore)

    xdim = 10
    ydim = 10

    initSOM(train, xdim, ydim, norm = normType,
                  topol = topol, toroidal = toroidal)
end

function benchmark_train(som,train, kernel = gaussianKernel)
    trainSOM(som, train, 100000, kernelFun = kernel)
end


# Example
# =======

# iris = dataset("datasets", "iris")
# train = iris[:,1:4]

# train = generate_dataset(1000,100,1)
# som = benchmark_init(train, :rectangular, toroidal = false)
# som = benchmark_train(som,train)
