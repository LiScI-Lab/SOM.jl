using SOM
using Test
#
using DataFrames
using RDatasets
using Primes

function generate_integer_hash_function(a,b,cardinality)
    # cardinality must be prime number
    # a,b: 1 ≤ a ≤ p−1  , 0 ≤ b ≤ p−1
    @assert a < cardinality
    @assert a > 0
    @assert b < cardinality
    @assert b >= 0
    # @assert isprime(cardinality)
    m = cardinality
    x -> (x^a%m + b)%m  #TODO use modular exponentiation
end

function generate_vector_deterministic_pseudorandom(seed,hash_func,dimension)
    [hash_func(x+seed) for x in 1:dimension]
end

function generate_dataset(number,dimension,max_value)
    # dimension = 16
    # max_value = 1013
    params = Dict(:a => 13, :b => 17, :hash_seed => 23)
    hash_func = generate_integer_hash_function(params[:a],params[:b],max_value)


    seed = params[:hash_seed]
    matrix = zeros((number,dimension))
    for i in 1:number
        vector = generate_vector_deterministic_pseudorandom(seed,hash_func,dimension)
        seed = hash_func(seed+i)
        matrix[i,:] = vector
    end
    convert(DataFrame,matrix)
end


include("testFuns.jl")



function benchmarkTrain(train, topol; toroidal = false,
                    normType = :zscore, kernel = gaussianKernel)

    xdim = 10
    ydim = 10

    som = initSOM(train, xdim, ydim, norm = normType,
                  topol = topol, toroidal = toroidal)
    som = trainSOM(som, train, 1000, kernelFun = kernel)

    ntrain = nrow(train)
    npopul = sum(som.population)

    return ntrain == npopul
end


train = generate_dataset(2000000,3,1013)

# test hexagonal, rectangular and spherical training:
#
# @test benchmarkTrain(train, :hexagonal, toroidal = false)
@time benchmarkTrain(train, :rectangular, toroidal = false)
# @test benchmarkTrain(train, :spherical, toroidal = false)
