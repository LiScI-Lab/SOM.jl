using SOM
using Base.Test

# set LD_LIBRARY_PATH for matplotlib:
#
ENV["LD_LIBRARY_PATH"] = "\$HOME/.julia/v0.6/Conda/deps/usr/lib:\$LD_LIBRARY_PATH"

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
@test testVisual(train, :rectangular)

# test frequencies:
#
@test testFreqs(train, iris, :Species)

# test plots:
#
@test testDensityPlot(train, :rectangular)
@test testDensityPlot(train, :hexagonal)
@test testDensityPlot(train, :spherical)

@test testOtherDensityPlot(train[1:100,:], train[101:150,:])

@test testClassesPlot(train, iris, :rectangular)
@test testClassesPlot(train, iris, :hexagonal)
@test testClassesPlot(train, iris, :spherical)
