# Quick start: a first tutorial

The concept of SOM.jl follows Kohonen's SOM_PAK software by doing
a 3-step approach:

1) initialise the SOM by defining topology, dimensions and random inital
   codebook vectors
2) train the SOM in one or more rounds with different training parameters
3) map data into the Som and get visualisations.


A first example uses the *Iris* dataset to show the three steps:

````Julia
using SOM
using RDatasets

# get the dataset:
#
iris = dataset("datasets", "iris")

# remove class column from dataset:
#
train = iris[:,1:4]

# init and train SOM:
#
som = initSOM(train, 10,8)
som = trainSOM(som, train, 10000)
som = trainSOM(som, train, 10000, r = 3)

# visualise density of SOM:
#
plotDensity(som)

# visualise mapped classes:
#
freqs = classFrequencies(som, iris, :Species)
plotClasses(som, freqs)
````
