using SOM
using Base.Test

# Tests are using Iris dataset:
#
Pkg.add("RDatasets")
using RDatasets
iris = dataset("datasets", "iris")
train = iris[:,1:4]

include("testFuns.jl")


# test hexagonal, rectangular and spherical training:
#
@test testTrain(train, :hexagonal, toroidal = false)
@test testTrain(train, :rectangular, toroidal = false)
@test testTrain(train, :spherical, toroidal = false)

# test toroidal:
#
@test testTrain(train, :rectangular, toroidal = true)

# test visual:
#
@test testVisual(train, :rectangular, toroidal = false)

# test frequencies:
#
@test testFreqs(train, iris, :Species)

# test plots:
#
@test testDensityPlot(train, :rectangular)
@test testDensityPlot(train, :hexagonal)
@test testDensityPlot(train, :spherical)

@test testClassesPlot(train, iris, :rectangular)
@test testClassesPlot(train, iris, :hexagonal)
@test testClassesPlot(train, iris, :spherical)
