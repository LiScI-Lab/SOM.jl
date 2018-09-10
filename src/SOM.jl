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
using Tensors

include("errors.jl")

include("types.jl")
include("helpers.jl")
include("grids.jl")
include("kernels.jl")
include("soms.jl")
include("api.jl")

global MPL_INSTALLED = true
try
    include("plotPyPlot.jl")
    include("plotSpheres.jl")
catch e
    println("Error loading PyPlot $e")
    println(" ")
    println(SOM_ERRORS[:ERR_MPL])

    MPL_INSTALLED = false
end

export Som,
       initSOM, trainSOM, mapToSOM,
       bubbleKernel, gaussianKernel,
       classFrequencies,
       plotDensity, plotClasses,
       rowSample, prettyPrintArray,
       MPL_INSTALLED

end # of module SOM
