# Quick start: a first tutorial

The concept of SOM.jl follows Kohonen's `SOM_PAK` software
by taking a 3-step approach:

1) initialise the SOM by defining topology, dimensions and random initial
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
iris
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

Called with the minimal set of arguments, topology defaults to *hexagonal*
and *not toroidal* and normalisation to *z-score normalisation* with *μ = 0.0*
and *σ = 1.0.*
In the example, the SOM will have
* an hexagonal grid of size 10 × 8 with edges
* z-score normalised training data.

The training data must be provided for initialisation to derive normalisation parameters and
to initialise the codes to random values within the attribute space
of the dataset:

````Julia
som = initSOM(train, 10, 8)
````


#### Training
Several rounds of training can be performed with different training parameters,
such as training steps and training radius.
Each step returns a *new* object of type Som, so that the progress of training
can be analysed later.
Although by default the
radius decreases in the course of training, it is often advantageous
to finalise the training with an additional round with small radius:

````Julia
som = trainSOM(som, train, 10000)
som = trainSOM(som, train, 10000, r = 3.0)
````


#### Mapping of samples to the Som
Unknown samples can be mapped to the SOM with the mapping function
(analogous to Kohonen's `visual`). As result, a vector with ID and index of
the winner neuron for each sample is returned:

````Julia
winners = mapToSOM(som, train[1:5,:])

5×3 DataFrames.DataFrame
│ Row │ X  │ Y │ index │
├─────┼────┼───┼───────┤
│ 1   │ 10 │ 4 │ 40    │
│ 2   │ 8  │ 2 │ 18    │
│ 3   │ 10 │ 2 │ 20    │
│ 4   │ 9  │ 2 │ 19    │
│ 5   │ 10 │ 4 │ 40    │
````


#### Visualisation
Visualisations include a density plot that displays the number of training
samples mapped to each neuron and a classes plot that shows the class labels
of training samples for every neuron as pie charts.

Called without specification of a device or file name, an interactive
Matplotlib-window will be opened. If a file name is specified, a file with
the respective format will be created.

````Julia
plotDensity(som)

freqs = classFrequencies(som, iris, :Species)
plotClasses(som, freqs)

plotClasses(som, freqs, fileName = "mychart.png")

freqs
80×7 DataFrames.DataFrame
│ Row │ index │ X  │ Y │ Population │ setosa │ versicolor │ virginica │
├─────┼───────┼────┼───┼────────────┼────────┼────────────┼───────────┤
│ 1   │ 1     │ 1  │ 1 │ 5          │ 0.0    │ 0.0        │ 1.0       │
│ 2   │ 2     │ 2  │ 1 │ 4          │ 0.0    │ 0.0        │ 1.0       │
│ 3   │ 3     │ 3  │ 1 │ 1          │ 0.0    │ 0.0        │ 1.0       │
│ 4   │ 4     │ 4  │ 1 │ 3          │ 0.0    │ 1.0        │ 0.0       │
│ 5   │ 5     │ 5  │ 1 │ 4          │ 0.0    │ 1.0        │ 0.0       │
│ 6   │ 6     │ 6  │ 1 │ 1          │ 0.0    │ 1.0        │ 0.0       │
│ 7   │ 7     │ 7  │ 1 │ 0          │ 0.0    │ 0.0        │ 0.0       │
⋮
│ 73  │ 73    │ 3  │ 8 │ 2          │ 0.0    │ 0.5        │ 0.5       │
│ 74  │ 74    │ 4  │ 8 │ 3          │ 0.0    │ 1.0        │ 0.0       │
│ 75  │ 75    │ 5  │ 8 │ 1          │ 0.0    │ 0.0        │ 1.0       │
│ 76  │ 76    │ 6  │ 8 │ 1          │ 0.0    │ 1.0        │ 0.0       │
│ 77  │ 77    │ 7  │ 8 │ 3          │ 0.0    │ 1.0        │ 0.0       │
│ 78  │ 78    │ 8  │ 8 │ 0          │ 0.0    │ 0.0        │ 0.0       │
│ 79  │ 79    │ 9  │ 8 │ 2          │ 1.0    │ 0.0        │ 0.0       │
│ 80  │ 80    │ 10 │ 8 │ 4          │ 1.0    │ 0.0        │ 0.0       │
````

#### Supported topologies
Default topology is a hexagonal grid with borders. By specifying
`topol = :rectangular` a rectangular grid is uses instead. For both
grids an edge-less toroidal topology can be defined with `toroidal = true`.
In this case neurons on the edge of the SOM will neighbour the neurons
on the opposite edge (simply spoken: the left is connected to
the right and the top is connected with the bottom).

In addition spherical SOMs are possible (`topol = :spherical`).

Training and visualisations work for all supported topologies.
Please refer to the API documentation for details.
