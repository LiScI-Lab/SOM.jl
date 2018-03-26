
<a id='Types-1'></a>

# Types

<a id='SOM.Som' href='#SOM.Som'>#</a>
**`SOM.Som`** &mdash; *Type*.



```
struct Som
```

Structure to hold all data of a trained SOM.

**Fields:**

  * `codes::Array{Float64,2}`: 2D-array of codebook vectors. One vector per row
  * `colNames::Array{String,1}`: names of the attribute with which the SOM is trained
  * `normParams::DataFrame`: normalisation parameters for each column               of training data. Column headers corresponds with               colNames.
  * `norm::Symbol`: normalisation type; one of `:none, :minmax, :zscore`
  * `xdim::Int`: number of neurons in x-direction
  * `ydim::Int`: number of neurons in y-direction
  * `nCodes::Int`: total number of neurons
  * `grid::Array{Float64,2}`: 2D-array of coordinates of neurons on the map         (2 columns (x,y)] for rectangular and hexagonal maps          3 columns (x,y,z) for spherical maps)
  * `indices::DataFrame`: X-, Y-indices of the neurons
  * `topol::Symbol`: topology of the SOM; one of `:rectangular, :hexagonal, :spherical`
  * `toroidal::Bool`: if `true`, the SOM is toroidal (has no edges)
  * `population::Array{Int,1}`: 1D-array of numbers of training samples mapped to               each neuron.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/d5e2e7a264c5bfbeadb49b83716efc54386c99ea/src/types.jl#L3-L26' class='documenter-source'>source</a><br>

