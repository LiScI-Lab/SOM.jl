
<a id='Types-1'></a>

### Types

<a id='SOM.Som' href='#SOM.Som'>#</a>
**`SOM.Som`** &mdash; *Type*.



```
struct Som
```

Stored data of a trained SOM.

**Fields:**

  * `codes`: 2D-array of codebook vectors. One vector per row
  * `colNames`: names of the attribute with which the SOM is trained
  * `normParams`: DataFrame with normalisation parameters for each column               of training data. Column headers corresponds with               colNames.
  * `norm`: normalisation of training data; one of `:none, :minmax, :zscore`
  * `xdim`: number of neurons in x-direction
  * `ydim`: number of neurons in y-direction
  * `nCodes`: total number of neurons
  * `grid`: 2D-array of coordinates of neurons on the map         (2 columns (x,y)] for rectangular and hexagonal maps          3 columns (x,y,z) for spherical maps)
  * `indices`: 2D-array of indices of the neurons
  * `topol`: topology of the SOM; one of `:rectangular, :hexagonal, :spherical`
  * `toroidal`: if `true`, the SOM is toroidal (no edges)
  * `population`: 1D-array of numbers of training samples mapped to               each neuron.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/ccd9d532c4e3b763107b1c5177a06d91433bc70f/src/types.jl#L3-L26' class='documenter-source'>source</a><br>

