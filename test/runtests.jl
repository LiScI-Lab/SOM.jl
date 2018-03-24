# set LD_LIBRARY_PATH for matplotlib:
#
# ENV["LD_LIBRARY_PATH"] = "\$HOME/.julia/v0.6/Conda/deps/usr/lib:\$LD_LIBRARY_PATH"
# ENV["LD_LIBRARY_PATH"] = Pkg.dir() * "/Conda/deps/usr/lib"
run(`bash -c 'export LD_LIBRARY_PATH=\$HOME/.julia/v0.6/Conda/deps/usr/lib:\$LD_LIBRARY_PATH'`)
# println("Begin testing: LD_LIBRARY_PATH: $(ENV["LD_LIBRARY_PATH"])")

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
# ld_path = ENV["LD_LIBRARY_PATH"]
# println("Plots testing: LD_LIBRARY_PATH: $ld_path")
#
# if contains(ld_path, "Conda")
    @test testDensityPlot(train, :rectangular)
    @test testDensityPlot(train, :hexagonal)
    @test testDensityPlot(train, :spherical)

    @test testOtherDensityPlot(train[1:100,:], train[101:150,:])

    @test testClassesPlot(train, iris, :rectangular)
    @test testClassesPlot(train, iris, :hexagonal)
    @test testClassesPlot(train, iris, :spherical)
# end
