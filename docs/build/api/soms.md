
<a id='SOM-training-1'></a>

### SOM training

<a id='SOM.initSOM' href='#SOM.initSOM'>#</a>
**`SOM.initSOM`** &mdash; *Function*.



```
initSOM(train, xdim, ydim = xdim;  norm = :zscore, topol = :hexagonal,
        toroidal = false)
```

Initialises a SOM.

**Arguments:**

  * `train`: training data, must be convertable to Array{Float64,2}.
  * `xdim, ydim`: geometry of the SOM          If DataFrame, the column names will be used as attribute names.          Codebook vectors will be sampled from the training data.          for spherical SOMs ydim can be omitted.
  * `norm`: optional normalisation; one of :`minmax, :zscore or :none`
  * `topol`: topology of the SOM; one of `:rectangular, :hexagonal or :spherical`.
  * `toroidal`: optional flag; if true, the SOM is toroidal.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/ccd9d532c4e3b763107b1c5177a06d91433bc70f/src/api.jl#L5-L20' class='documenter-source'>source</a><br>

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
  * `train`: training DataType
  * `len`: number of training steps (*not* epochs)
  * `η`: learning rate. η decays to 0.0 during the training
  * `kernel`: optional distance kernel; one of (`bubbleKernel, gaussianKernel`)           default is `gaussianKernel`
  * `r`: optional training radius.      If r is not specified, it defaults to √(xdim^2 + ydim^2) / 2
  * `rDecay`: optional flag; if true, r decays to 0.0 during the training.
  * `ηDecay`: optional flag; if true, learning rate η decays to 0.0           during the training.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/ccd9d532c4e3b763107b1c5177a06d91433bc70f/src/api.jl#L45-L64' class='documenter-source'>source</a><br>

