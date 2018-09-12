# set LD_LIBRARY_PATH for matplotlib:
#
# ENV["LD_LIBRARY_PATH"] = "\$HOME/.julia/v0.6/Conda/deps/usr/lib:\$LD_LIBRARY_PATH"
# ENV["LD_LIBRARY_PATH"] = Pkg.dir() * "/Conda/deps/usr/lib"
# run(`bash -c 'export LD_LIBRARY_PATH=\$HOME/.julia/v0.6/Conda/deps/usr/lib:\$LD_LIBRARY_PATH'`)

# ld_load_path = Pkg.dir() * "/Conda/deps/usr/lib"
# import Base._setenv
# _setenv("LD_LIBRARY_PATH", ld_load_path)

# ENV["MPLBACKEND"]="agg"
# using PyCall
# py"""
# import os
# os.environ["LD_LIBRARY_PATH"]=$(Pkg.dir()) + "/Conda/deps/usr/lib"
# os.putenv("LD_LIBRARY_PATH", $(Pkg.dir()) + "/Conda/deps/usr/lib")
# """
#
# println("Begin testing: LD_LIBRARY_PATH: $(ENV["LD_LIBRARY_PATH"])")
# println("OLA")
#
# do the tests only, if matplotlib is setup correctly!
#
#if haskey(ENV, "LD_LIBRARY_PATH") && contains(ENV["LD_LIBRARY_PATH"], "Conda")

ENV["PYTHON"]=""

using Pkg
Pkg.add("Conda")
Pkg.update()
using Conda
Conda.update()
Conda.add("matplotlib")
Pkg.add("PyCall")
Pkg.build("PyCall")
Pkg.add("PyPlot");

using SOM
using Test

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

# test normalisation:
#
@test testTrain(train, :rectangular, normType = :minmax)
@test testTrain(train, :rectangular, normType = :zscore)
@test testTrain(train, :rectangular, normType = :none)

# test convertTrainingData:
#
@test testTrain(convert(Array{Float64}, train), :rectangular)

# test kernels:
#
@test testTrain(train, :rectangular, kernel = gaussianKernel)
@test testTrain(train, :rectangular, kernel = bubbleKernel)

# test visual:
#
@test testVisual(train, :rectangular)

# test frequencies:
#
@test testFreqs(train, iris, :Species)

# test plots:
#
if MPL_INSTALLED
    @test testDensityPlot(train, :hexagonal)
    @test testDensityPlot(train, :spherical)

    @test testOtherDensityPlot(train[1:100,:], train[101:150,:])

    @test testClassesPlot(train, iris, :rectangular)
    @test testClassesPlot(train, iris, :hexagonal)
    @test testClassesPlot(train, iris, :spherical)

    # plot to file:
    #
    @test testClassesToFile(train, iris)
end
#
#eof.
