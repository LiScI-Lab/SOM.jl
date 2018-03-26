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
Pkg.add("Conda")
Pkg.update()
using Conda
Conda.update()
Conda.add("matplotlib")
Pkg.add("PyCall")
Pkg.build("PyCall")
Pkg.add("PyPlot");

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
@test testVisual(train, :rectangular)

# test frequencies:
#
@test testFreqs(train, iris, :Species)

# test plots:
#
@test testDensityPlot(train, :hexagonal)
@test testDensityPlot(train, :spherical)

@test testOtherDensityPlot(train[1:100,:], train[101:150,:])

@test testClassesPlot(train, iris, :rectangular)
@test testClassesPlot(train, iris, :hexagonal)
@test testClassesPlot(train, iris, :spherical)
#
#eof.
