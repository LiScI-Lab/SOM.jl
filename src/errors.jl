#
# error messages:
#
SOM_ERRORS = Dict(
:ERR_MPL =>
"""
    Matplotlib is not correctly installed!

    See the documentation at https://andreasdominik.github.io/SOM.jl/stable/
    for details and potential solutions.
""", 
:ERR_MATRIX =>
"""
    Input data is not a numerical 2D-matrix!

    Please provide a numerical 2D-array or DataFrame
    that can be converted into an Array{Float64,2}.
"""
)
