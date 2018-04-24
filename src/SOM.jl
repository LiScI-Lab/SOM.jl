# __precompile__()
module SOM

using DataFrames
using Distances
using ProgressMeter
using StatsBase
using Distributions

include("errors.jl")

include("types.jl")
include("helpers.jl")
include("grids.jl")
include("kernels.jl")
include("soms.jl")
include("api.jl")

MPL_INSTALLED = true
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
