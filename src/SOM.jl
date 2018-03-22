# __precompile__()
module SOM

using DataFrames
using Distances
using ProgressMeter
using StatsBase

include("types.jl")
include("helpers.jl")
include("grids.jl")
include("kernels.jl")
include("soms.jl")
include("api.jl")
include("plotPyPlot.jl")
include("plotSpheres.jl")

export Som,
       initSOM, trainSOM, mapToSOM,
       bubbleKernel, gaussianKernel,
       classFrequencies,
       plotDensity, plotClasses,
       rowSample, prettyPrintArray

end # of module SOM