# stuct Som holds all important parameters of a trained som:
#
struct Som
    codes::Array{Float64,2}
    colNames::Array{String}
    normParams::DataFrame
    norm::Symbol        # one of :none :minmax :zscore
    xdim::Int
    ydim::Int
    nCodes::Int
    grid::Array{Float64,2}
    indices::DataFrame
    topol::Symbol       # one of :rectangular :hexagonal :spherical
    toroidal::Bool
    population::Array{Int,1}

    Som(;codes::Array{Float64} = Array{Float64}(0),
        colNames::Array{String,1} = Array{String}(0),
        normParams::DataFrame = DataFrame(),
        norm::Symbol = :none,
        xdim::Int = 1,
        ydim::Int = 1,
        nCodes::Int = 1,
        grid::Array{Float64,2} = zeros(1,1),
        indices::DataFrame = DataFrame(),
        topol::Symbol = :hexagonal,
        toroidal::Bool = false,
        population::Array{Int,1} = [1]) = new(codes,
                                              colNames,
                                              normParams,
                                              norm,
                                              xdim,
                                              ydim,
                                              nCodes,
                                              grid,
                                              indices,
                                              topol,
                                              toroidal,
                                              population)
end
