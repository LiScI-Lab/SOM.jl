# Quick start: a first tutorial

The concept of SOM.jl follows Kohonen's SOM_PAK software by doing
a 3-step approach:

1) initialise the SOM by defining topology, dimensions and random inital
   codebook vectors
2) train the SOM in one or more rounds with different training parameters
3) map data into the Som and get visualisations.

In the following example the functions are called with a minimum set of
parameters. For a description of all possible arguments see the
API documentation.



#### Training data
A first example uses the *Iris* dataset, that comprises lengths and widths
of petals and sepals of the blossoms of iris flowers of species
*Iris viginica*, *Iris setosa* and *Iris versicolor*.
The dataset includes the 4 attributes and the correct species for 150 flowers:
````
julia> iris
150×5 DataFrames.DataFrame
│ Row │ SepalLength │ SepalWidth │ PetalLength │ PetalWidth │ Species   │
├─────┼─────────────┼────────────┼─────────────┼────────────┼───────────┤
│ 1   │ 5.1         │ 3.5        │ 1.4         │ 0.2        │ setosa    │
│ 2   │ 4.9         │ 3.0        │ 1.4         │ 0.2        │ setosa    │
│ 3   │ 4.7         │ 3.2        │ 1.3         │ 0.2        │ setosa    │
│ 4   │ 4.6         │ 3.1        │ 1.5         │ 0.2        │ setosa    │
│ 5   │ 5.0         │ 3.6        │ 1.4         │ 0.2        │ setosa    │
│ 6   │ 5.4         │ 3.9        │ 1.7         │ 0.4        │ setosa    │
│ 7   │ 4.6         │ 3.4        │ 1.4         │ 0.3        │ setosa    │
...
````
As the training of self-organising maps is unsupervised, the class label
(`species`) must be removed for training:

````Julia
using SOM
using RDatasets

iris = dataset("datasets", "iris")
train = iris[:,1:4]
````


#### SOM initialisation
Initialisation sets the parameters of the SOM, such as dimensions, topology
and normalisation as well as initial values of the codebook vectors.

Called with the minimal set of arguments topology defaults to *hexagonal*
and *not toroidal* and normalisation to *z-score normalisation* with μ = 0.0
and σ = 1.0.

The training data must be provided to derive normalisation parameters and
to initialise the codes to random values within the attribute space
of the dataset:

````Julia
som = initSOM(train, 10,8)
````


#### Training
Several training steps can be performed with different training parameters,
such as training steps and training radius.
Each step returns a *new* object of type Som, so that the progress of training
can be analysed later.
Although by default the
radius decreases in the course of training, it is often advantageous
to finalise the training with an additional round with small radius:

````Julia
som = trainSOM(som, train, 10000)
som = trainSOM(som, train, 10000, r = 3)
````


#### Visualisation
Visualisations include a density plot that displays the number of training
samples mapped to each neuron and a classes plot that shows the class labels
of training samples for every neuron as a pie chart:

````Julia
plotDensity(som)

freqs = classFrequencies(som, iris, :Species)
plotClasses(som, freqs)
````

#### Supported topologies
Default topology is a hexagonal grid with borders. By specifying
`topol = :rectangular` a rectangular grid is uses instead. For both
grids an edge-less toroidal topology can be used with `toroidal = true`.
In this case neurons on the edge of the SOM will neighbour the neurons
on the opposite edge (simply spoken: the left edge is connected to
the right edge and the top is connected with the bottom).

In addition spherical SOMs are possible.

Training and visualisations work for all supported topologies.
Please refer to the API documentation for details.
