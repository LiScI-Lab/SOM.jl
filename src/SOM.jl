"""
SOME provides methods to train Kohonen's self-organising maps.
The SOM.jl package is licensed under the MIT "Expat" License.


    Andreas Dominik
    Life Science Informaticvs Laboratory
    THM University of Applied Sciences
    Gießen, Germany
"""
module SOM

using DataFrames
using Distances
using ProgressMeter
using StatsBase
using Distributions
using TensorToolbox
using LinearAlgebra
# if VERSION < v"0.7.0-DEV.5183"
#     # nothing: dotproduct is in Base
# else
#     # import LinearAlgebra Package
#     using LinearAlgebra
# end

include("errors.jl")

include("types.jl")
include("helpers.jl")
include("grids.jl")
include("kernels.jl")
include("soms.jl")
include("api.jl")

global MPL_INSTALLED = false
try
    # Do the pyimports at runtime and not at time
    # of precompilation:
    using PyPlot
    using PyCall
    global const patches = PyNULL()
    global const cm = PyNULL()
    global const ag1 = PyNULL()
    global const mp3 = PyNULL()

    include("plotPyPlot.jl")
    include("plotSpheres.jl")
    global MPL_INSTALLED = true
catch e
    println("Error loading PyPlot $e")
    println(" ")
    println(SOM_ERRORS[:ERR_MPL])
    global MPL_INSTALLED = false
end

function __init__()

    # rescue Python-pointers at runtime:
    if MPL_INSTALLED
        copy!(patches, pyimport_conda("matplotlib.patches", "matplotlib"))
        copy!(cm, pyimport_conda("matplotlib.cm", "matplotlib"))
        copy!(ag1, pyimport_conda("mpl_toolkits.axes_grid1", "mpl_toolkits"))
        copy!(mp3, pyimport_conda("mpl_toolkits.mplot3d", "mpl_toolkits"))

        # @pyimport matplotlib.patches as patches
        # @pyimport matplotlib.cm as cm               # colourmap
        # @pyimport mpl_toolkits.axes_grid1 as ag1
        # @pyimport mpl_toolkits.mplot3d as mp3
    end
end




export Som,
       initSOM, trainSOM, mapToSOM,
       bubbleKernel, gaussianKernel,
       classFrequencies,
       plotDensity, plotClasses,
       rowSample, prettyPrintArray,
       MPL_INSTALLED

end # of module SOM
