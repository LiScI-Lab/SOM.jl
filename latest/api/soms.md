
<a id='Training-1'></a>

# Training

<a id='SOM.initSOM' href='#SOM.initSOM'>#</a>
**`SOM.initSOM`** &mdash; *Function*.



```
initSOM(train, xdim, ydim = xdim;  norm = :zscore, topol = :hexagonal,
        toroidal = false)
```

Initialises a SOM.

**Arguments:**

  * `train`: training data
  * `xdim, ydim`: geometry of the SOM          If DataFrame, the column names will be used as attribute names.          Codebook vectors will be sampled from the training data.          for spherical SOMs ydim can be omitted.
  * `norm`: optional normalisation; one of :`minmax, :zscore or :none`
  * `topol`: topology of the SOM; one of `:rectangular, :hexagonal or :spherical`.
  * `toroidal`: optional flag; if true, the SOM is toroidal.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/d5e2e7a264c5bfbeadb49b83716efc54386c99ea/src/api.jl#L5-L20' class='documenter-source'>source</a><br>

<a id='SOM.trainSOM' href='#SOM.trainSOM'>#</a>
**`SOM.trainSOM`** &mdash; *Function*.



```
trainSOM(som::Som, train::Any, len;
         η = 0.2 kernel = gaussianKernel,
         r = 0.0, rDecay = true, ηDecay = true)
```

Train an initialised or pre-trained SOM.

**Arguments:**

  * `som`: object of type Som with a trained som
  * `train`: training data
  * `len`: number of single training steps (*not* epochs)
  * `η`: learning rate
  * `kernel::function`: optional distance kernel; one of (`bubbleKernel, gaussianKernel`)           default is `gaussianKernel`
  * `r`: optional training radius.      If r is not specified, it defaults to √(xdim^2 + ydim^2) / 2
  * `rDecay`: optional flag; if true, r decays to 0.0 during the training.
  * `ηDecay`: optional flag; if true, learning rate η decays to 0.0           during the training.

Training data must be convertable to Array{Float64,2} with `convert()`. Training samples are row-wise; one sample per row.

An alternative kernel function can be provided to modify the distance-dependent training. The function must fit to the signature fun(x, r) where x is an arbitrary distance and r is a parameter controlling the function and the return value is between 0.0 and 1.0.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/d5e2e7a264c5bfbeadb49b83716efc54386c99ea/src/api.jl#L45-L73' class='documenter-source'>source</a><br>

<a id='SOM.mapToSOM' href='#SOM.mapToSOM'>#</a>
**`SOM.mapToSOM`** &mdash; *Function*.



```
mapToSOM(som::Som, data)
```

Return a DataFrame with X-, Y-indices and index of winner neuron for every row in data.

**Arguments**

  * `som`: a trained SOM
  * `data`: Array or DataFrame with training data.

Data must have the same number of dimensions as the training dataset and will be normalised with the same parameters.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/d5e2e7a264c5bfbeadb49b83716efc54386c99ea/src/api.jl#L90-L102' class='documenter-source'>source</a><br>

<a id='SOM.classFrequencies' href='#SOM.classFrequencies'>#</a>
**`SOM.classFrequencies`** &mdash; *Function*.



```
classFrequencies(som::Som, data, classes)
```

Return a DataFrame with class frequencies for all neurons.

**Arguments:**

  * `som`: a trained SOM
  * `data`: data with row-wise samples and class information in each row
  * `classes`: Name of column with class information.

Data must have the same number of dimensions as the training dataset. The column with class labels is given as `classes` (name or index). Returned DataFrame has the columns:

  * X-, Y-indices and index: of winner neuron for every row in data
  * population: number of samples mapped to the neuron
  * frequencies: one column for each class label.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/d5e2e7a264c5bfbeadb49b83716efc54386c99ea/src/api.jl#L120-L136' class='documenter-source'>source</a><br>


<a id='Kernel-functions-1'></a>

# Kernel functions

<a id='SOM.bubbleKernel' href='#SOM.bubbleKernel'>#</a>
**`SOM.bubbleKernel`** &mdash; *Function*.



```
bubbleKernel(x, r)
```

Return 1.0 if dist <= r, otherwise 0.0.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/d5e2e7a264c5bfbeadb49b83716efc54386c99ea/src/kernels.jl#L4-L8' class='documenter-source'>source</a><br>

<a id='SOM.gaussianKernel' href='#SOM.gaussianKernel'>#</a>
**`SOM.gaussianKernel`** &mdash; *Function*.



```
gaussianKernel(x, r)
```

Return Gaussian(x) for μ=0.0 and σ = r/3. (a value of σ = r/3 makes the training results comparable between different kernels for sample values or r).


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/d5e2e7a264c5bfbeadb49b83716efc54386c99ea/src/kernels.jl#L14-L20' class='documenter-source'>source</a><br>

