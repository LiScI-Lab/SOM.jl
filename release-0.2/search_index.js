var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Introduction",
    "title": "Introduction",
    "category": "page",
    "text": ""
},

{
    "location": "#SOM.jl-Kohonen\'s-self-organising-maps-for-Julia-1",
    "page": "Introduction",
    "title": "SOM.jl - Kohonen\'s self-organising maps for Julia",
    "category": "section",
    "text": "The package provides training and visualisation functions for Kohonen\'s self-organising maps for Julia. Training functions are implemented in pure Julia, without calling external libraries.     Visualisation is implemented by using Python\'s Matplotlib."
},

{
    "location": "#Self-organising-maps-1",
    "page": "Introduction",
    "title": "Self-organising maps",
    "category": "section",
    "text": "Self-organising maps (also referred to as SOMs or Kohonen maps) are artificial neural networks introduced by Teuvo Kohonen in the 1980s. Despite of their age, SOMs are still widely used as an easy and robust unsupervised learning technique for analysis and visualisation of high-dimensional data.The SOM algorithm maps high-dimensional vectors into a lower-dimensional grid. Most often the target grid is two-dimensional, resulting into  intuitively interpretable maps.For more details see Kohonen\'s papers, such asTeuvo Kohonen, Biological Cybernetics, 43 (1982) p. 59-69   \nTeuvo Kohonen, Biological Cybernetics, 44 (1982) p. 135-140      Technical details and background can be found in Kohonen\'s still relevant technical report:Teuvo Kohonen, Jussi Hynninen, Jari Kangas, and Jorma Laaksonen, SOM_PAK: The Self-Organizing Map Program Package. Technical Report A31, Helsinki University of Technology, Laboratory of Computer and Information Science, FIN-02150 Espoo, Finland, 1996. http://www.cis.hut.fi/research/papers/som_tr96.ps.Z"
},

{
    "location": "#Installation-1",
    "page": "Introduction",
    "title": "Installation",
    "category": "section",
    "text": "For installation please refer to the README @github: https://github.com/andreasdominik/SOM.jl"
},

{
    "location": "#Matplotlib-issues-1",
    "page": "Introduction",
    "title": "Matplotlib issues",
    "category": "section",
    "text": "Common installation problems arise from a known incompatibility between Matplotlib and Julia. The issue seems to be less common for Julia versions v0.7 or later. However, if the error message contains a line comparable to:...\nimportError(\"/lib/x86_64-linux-gnu/libz.so.1: version `ZLIB_*.*.*\' not found\n...then most probably Matplotlib fails to find a required library.   A first attempt could be to reinstall Matplotlib into the Python environment of Julia via:ENV[\"PYTHON\"]=\"\"\nPkg.add(\"Conda\")\nusing Conda\nConda.update()\n\nConda.add(\"matplotlib\")\nPkg.add(\"PyCall\")\nPkg.build(\"PyCall\")\nPkg.add(\"PyPlot\");A second solution (or second step) is to tell Matplotlib the path to the correct library, which is provided by Conda. Temporarily this can be achieved by starting Julia asexport LD_LIBRARY_PATH=$HOME/.julia/v0.6/Conda/deps/usr/lib; juliawith the path replaced by the location of the missing library file. To specify the path permanently, the following line can be added to the file .bashrc in the home directory:LD_LIBRARY_PATH=\"$HOME/.julia/v0.6/Conda/deps/usr/lib:$LD_LIBRARY_PATH\"For training of self-organising maps issues with Matplotlib installation can be ignored; the SOMs will work without Matplotlib. However, Matplotlib visualisations cannot be plotted without Matplotlib."
},

{
    "location": "#Quick-Start-1",
    "page": "Introduction",
    "title": "Quick Start",
    "category": "section",
    "text": "Pages = [\n    \"tutorials/firstTutorial.md\"\n    ]\nDepth = 2"
},

{
    "location": "#API-1",
    "page": "Introduction",
    "title": "API",
    "category": "section",
    "text": "Pages = [\n    \"api/types.md\",\n    \"api/soms.md\",\n    \"api/visualisations.md\"\n    ]\nDepth = 2"
},

{
    "location": "#Index-1",
    "page": "Introduction",
    "title": "Index",
    "category": "section",
    "text": ""
},

{
    "location": "tutorials/firstTutorial/#",
    "page": "Quick Start",
    "title": "Quick Start",
    "category": "page",
    "text": ""
},

{
    "location": "tutorials/firstTutorial/#Quick-start:-a-first-tutorial-1",
    "page": "Quick Start",
    "title": "Quick start: a first tutorial",
    "category": "section",
    "text": "The concept of SOM.jl follows Kohonen\'s SOM_PAK software by taking a 3-step approach:initialise the SOM by defining topology, dimensions and random initial codebook vectors\ntrain the SOM in one or more rounds with different training parameters\nmap data into the Som and get visualisations.In the following example the functions are called with a minimum set of parameters. For a description of all possible arguments see the API documentation."
},

{
    "location": "tutorials/firstTutorial/#Training-data-1",
    "page": "Quick Start",
    "title": "Training data",
    "category": "section",
    "text": "A first example uses the Iris dataset, that comprises lengths and widths of petals and sepals of the blossoms of iris flowers of species Iris viginica, Iris setosa and Iris versicolor. The dataset includes the 4 attributes and the correct species for 150 flowers:iris\n150×5 DataFrames.DataFrame\n│ Row │ SepalLength │ SepalWidth │ PetalLength │ PetalWidth │ Species   │\n├─────┼─────────────┼────────────┼─────────────┼────────────┼───────────┤\n│ 1   │ 5.1         │ 3.5        │ 1.4         │ 0.2        │ setosa    │\n│ 2   │ 4.9         │ 3.0        │ 1.4         │ 0.2        │ setosa    │\n│ 3   │ 4.7         │ 3.2        │ 1.3         │ 0.2        │ setosa    │\n│ 4   │ 4.6         │ 3.1        │ 1.5         │ 0.2        │ setosa    │\n│ 5   │ 5.0         │ 3.6        │ 1.4         │ 0.2        │ setosa    │\n│ 6   │ 5.4         │ 3.9        │ 1.7         │ 0.4        │ setosa    │\n│ 7   │ 4.6         │ 3.4        │ 1.4         │ 0.3        │ setosa    │\n...As the training of self-organising maps is unsupervised, the class label (species) must be removed for training:using SOM\nusing RDatasets\n\niris = dataset(\"datasets\", \"iris\")\ntrain = iris[:,1:4]"
},

{
    "location": "tutorials/firstTutorial/#SOM-initialisation-1",
    "page": "Quick Start",
    "title": "SOM initialisation",
    "category": "section",
    "text": "Initialisation sets the parameters of the SOM, such as dimensions, topology and normalisation as well as initial values of the codebook vectors.Called with the minimal set of arguments, topology defaults to hexagonal and not toroidal and normalisation to z-score normalisation with μ = 0.0 and σ = 1.0. In the example, the SOM will havean hexagonal grid of size 10 × 8 with edges\nz-score normalised training data.The training data must be provided for initialisation to derive normalisation parameters and to initialise the codes to random values within the attribute space of the dataset:som = initSOM(train, 10, 8)"
},

{
    "location": "tutorials/firstTutorial/#Training-1",
    "page": "Quick Start",
    "title": "Training",
    "category": "section",
    "text": "Several rounds of training can be performed with different training parameters, such as training steps and training radius. Each step returns a new object of type Som, so that the progress of training can be analysed later. Although by default the radius decreases in the course of training, it is often advantageous to finalise the training with an additional round with small radius:som = trainSOM(som, train, 10000)\nsom = trainSOM(som, train, 10000, r = 3.0)"
},

{
    "location": "tutorials/firstTutorial/#Mapping-of-samples-to-the-Som-1",
    "page": "Quick Start",
    "title": "Mapping of samples to the Som",
    "category": "section",
    "text": "Unknown samples can be mapped to the SOM with the mapping function (analogous to Kohonen\'s visual). As result, a vector with ID and index of the winner neuron for each sample is returned:winners = mapToSOM(som, train[1:5,:])\n\n5×3 DataFrames.DataFrame\n│ Row │ X  │ Y │ index │\n├─────┼────┼───┼───────┤\n│ 1   │ 10 │ 4 │ 40    │\n│ 2   │ 8  │ 2 │ 18    │\n│ 3   │ 10 │ 2 │ 20    │\n│ 4   │ 9  │ 2 │ 19    │\n│ 5   │ 10 │ 4 │ 40    │"
},

{
    "location": "tutorials/firstTutorial/#Visualisation-1",
    "page": "Quick Start",
    "title": "Visualisation",
    "category": "section",
    "text": "Visualisations include a density plot that displays the number of training samples mapped to each neuron and a classes plot that shows the class labels of training samples for every neuron as pie charts.Called without specification of a device or file name, an interactive Matplotlib-window will be opened. If a file name is specified, a file with the respective format will be created.plotDensity(som)\n\nfreqs = classFrequencies(som, iris, :Species)\nplotClasses(som, freqs)\n\nplotClasses(som, freqs, fileName = \"mychart.png\")\n\nfreqs\n80×7 DataFrames.DataFrame\n│ Row │ index │ X  │ Y │ Population │ setosa │ versicolor │ virginica │\n├─────┼───────┼────┼───┼────────────┼────────┼────────────┼───────────┤\n│ 1   │ 1     │ 1  │ 1 │ 5          │ 0.0    │ 0.0        │ 1.0       │\n│ 2   │ 2     │ 2  │ 1 │ 4          │ 0.0    │ 0.0        │ 1.0       │\n│ 3   │ 3     │ 3  │ 1 │ 1          │ 0.0    │ 0.0        │ 1.0       │\n│ 4   │ 4     │ 4  │ 1 │ 3          │ 0.0    │ 1.0        │ 0.0       │\n│ 5   │ 5     │ 5  │ 1 │ 4          │ 0.0    │ 1.0        │ 0.0       │\n│ 6   │ 6     │ 6  │ 1 │ 1          │ 0.0    │ 1.0        │ 0.0       │\n│ 7   │ 7     │ 7  │ 1 │ 0          │ 0.0    │ 0.0        │ 0.0       │\n⋮\n│ 73  │ 73    │ 3  │ 8 │ 2          │ 0.0    │ 0.5        │ 0.5       │\n│ 74  │ 74    │ 4  │ 8 │ 3          │ 0.0    │ 1.0        │ 0.0       │\n│ 75  │ 75    │ 5  │ 8 │ 1          │ 0.0    │ 0.0        │ 1.0       │\n│ 76  │ 76    │ 6  │ 8 │ 1          │ 0.0    │ 1.0        │ 0.0       │\n│ 77  │ 77    │ 7  │ 8 │ 3          │ 0.0    │ 1.0        │ 0.0       │\n│ 78  │ 78    │ 8  │ 8 │ 0          │ 0.0    │ 0.0        │ 0.0       │\n│ 79  │ 79    │ 9  │ 8 │ 2          │ 1.0    │ 0.0        │ 0.0       │\n│ 80  │ 80    │ 10 │ 8 │ 4          │ 1.0    │ 0.0        │ 0.0       │"
},

{
    "location": "tutorials/firstTutorial/#Supported-topologies-1",
    "page": "Quick Start",
    "title": "Supported topologies",
    "category": "section",
    "text": "Default topology is a hexagonal grid with borders. By specifying topol = :rectangular a rectangular grid is uses instead. For both grids an edge-less toroidal topology can be defined with toroidal = true. In this case neurons on the edge of the SOM will neighbour the neurons on the opposite edge (simply spoken: the left is connected to the right and the top is connected with the bottom).In addition spherical SOMs are possible (topol = :spherical).Training and visualisations work for all supported topologies. Please refer to the API documentation for details."
},

{
    "location": "api/types/#",
    "page": "Types",
    "title": "Types",
    "category": "page",
    "text": ""
},

{
    "location": "api/types/#SOM.Som",
    "page": "Types",
    "title": "SOM.Som",
    "category": "type",
    "text": "struct Som\n\nStructure to hold all data of a trained SOM.\n\nFields:\n\ncodes::Array{Float64,2}: 2D-array of codebook vectors. One vector per row\ncolNames::Array{String,1}: names of the attribute with which the SOM is trained\nnormParams::DataFrame: normalisation parameters for each column               of training data. Column headers corresponds with               colNames.\nnorm::Symbol: normalisation type; one of :none, :minmax, :zscore\nxdim::Int: number of neurons in x-direction\nydim::Int: number of neurons in y-direction\nnCodes::Int: total number of neurons\ngrid::Array{Float64,2}: 2D-array of coordinates of neurons on the map         (2 columns (x,y)] for rectangular and hexagonal maps          3 columns (x,y,z) for spherical maps)\nindices::DataFrame: X-, Y-indices of the neurons\ntopol::Symbol: topology of the SOM; one of :rectangular, :hexagonal, :spherical\ntoroidal::Bool: if true, the SOM is toroidal (has no edges)\npopulation::Array{Int,1}: 1D-array of numbers of training samples mapped to               each neuron.\n\n\n\n\n\n"
},

{
    "location": "api/types/#Types-1",
    "page": "Types",
    "title": "Types",
    "category": "section",
    "text": "Som"
},

{
    "location": "api/soms/#",
    "page": "Training",
    "title": "Training",
    "category": "page",
    "text": ""
},

{
    "location": "api/soms/#SOM.initSOM",
    "page": "Training",
    "title": "SOM.initSOM",
    "category": "function",
    "text": "initSOM(train, xdim, ydim = xdim;  norm = :zscore, topol = :hexagonal,\n        toroidal = false)\n\nInitialises a SOM.\n\nArguments:\n\ntrain: training data\nxdim, ydim: geometry of the SOM          If DataFrame, the column names will be used as attribute names.          Codebook vectors will be sampled from the training data.          for spherical SOMs ydim can be omitted.\nnorm: optional normalisation; one of :minmax, :zscore or :none\ntopol: topology of the SOM; one of :rectangular, :hexagonal or :spherical.\ntoroidal: optional flag; if true, the SOM is toroidal.\n\n\n\n\n\n"
},

{
    "location": "api/soms/#SOM.trainSOM",
    "page": "Training",
    "title": "SOM.trainSOM",
    "category": "function",
    "text": "trainSOM(som::Som, train::Any, len;\n         η = 0.2, kernelFun = gaussianKernel,\n         r = 0.0, rDecay = true, ηDecay = true)\n\nTrain an initialised or pre-trained SOM.\n\nArguments:\n\nsom: object of type Som with a trained som\ntrain: training data\nlen: number of single training steps (not epochs)\nη: learning rate\nkernel::function: optional distance kernel; one of (bubbleKernel, gaussianKernel)           default is gaussianKernel\nr: optional training radius.      If r is not specified, it defaults to √(xdim^2 + ydim^2) / 2\nrDecay: optional flag; if true, r decays to 0.0 during the training.\nηDecay: optional flag; if true, learning rate η decays to 0.0           during the training.\n\nTraining data must be convertable to Array{Float64,2} with convert(). Training samples are row-wise; one sample per row.\n\nAn alternative kernel function can be provided to modify the distance-dependent training. The function must fit to the signature fun(x, r) where x is an arbitrary distance and r is a parameter controlling the function and the return value is between 0.0 and 1.0.\n\n\n\n\n\n"
},

{
    "location": "api/soms/#SOM.mapToSOM",
    "page": "Training",
    "title": "SOM.mapToSOM",
    "category": "function",
    "text": "mapToSOM(som::Som, data)\n\nReturn a DataFrame with X-, Y-indices and index of winner neuron for every row in data.\n\nArguments\n\nsom: a trained SOM\ndata: Array or DataFrame with training data.\n\nData must have the same number of dimensions as the training dataset and will be normalised with the same parameters.\n\n\n\n\n\n"
},

{
    "location": "api/soms/#SOM.classFrequencies",
    "page": "Training",
    "title": "SOM.classFrequencies",
    "category": "function",
    "text": "classFrequencies(som::Som, data, classes)\n\nReturn a DataFrame with class frequencies for all neurons.\n\nArguments:\n\nsom: a trained SOM\ndata: data with row-wise samples and class information in each row\nclasses: Name of column with class information.\n\nData must have the same number of dimensions as the training dataset. The column with class labels is given as classes (name or index). Returned DataFrame has the columns:\n\nX-, Y-indices and index: of winner neuron for every row in data\npopulation: number of samples mapped to the neuron\nfrequencies: one column for each class label.\n\n\n\n\n\n"
},

{
    "location": "api/soms/#Training-1",
    "page": "Training",
    "title": "Training",
    "category": "section",
    "text": "initSOM\ntrainSOM\nmapToSOM\nclassFrequencies"
},

{
    "location": "api/soms/#SOM.bubbleKernel",
    "page": "Training",
    "title": "SOM.bubbleKernel",
    "category": "function",
    "text": "bubbleKernel(x::Float64, r::Float64)::Float64\n\nReturn 1.0 if dist <= r, otherwise 0.0.\n\n\n\n\n\n"
},

{
    "location": "api/soms/#SOM.gaussianKernel",
    "page": "Training",
    "title": "SOM.gaussianKernel",
    "category": "function",
    "text": "gaussianKernel(x::Float64, r::Float64)::Float64\n\nReturn Gaussian(x) for μ=0.0 and σ = r/3. (a value of σ = r/3 makes the training results comparable between different kernels for sample values or r).\n\n\n\n\n\n"
},

{
    "location": "api/soms/#Kernel-functions-1",
    "page": "Training",
    "title": "Kernel functions",
    "category": "section",
    "text": "bubbleKernel\ngaussianKernel"
},

{
    "location": "api/visualisations/#",
    "page": "Visualisation",
    "title": "Visualisation",
    "category": "page",
    "text": ""
},

{
    "location": "api/visualisations/#SOM.plotDensity",
    "page": "Visualisation",
    "title": "SOM.plotDensity",
    "category": "function",
    "text": "plotDensity(som::Som; predict = nothing,\n            title = \"Density of Self-Organising Map\",\n            paper = :a4r,\n            colormap = \"autumn_r\",\n            detail = 45,\n            device = :display, fileName = \"somplot\")\n\nPlot the population of neurons as colours.\n\nArguments:\n\nsom: the som of type Som; som is the only mandatory argument\npredict: DataFrame of mappings as outputed by mapToSOM()\ntitle: main title of plot\npaper: plot size; currentlx supported: :a4, :a4r, :letter, :letterr\ncolormap: MatPlotLib colourmap (Python-style strings; e.g. \"Greys\").\ndetail: only relevant for 3D-plotting of spherical SOMs: higher           values result in smoother display of the 3D-sphere\ndevice: one of :display, :png, :svg, :pdf or any file-type supported           by MatPlotLib; default is :display\nfileName: name of image file. File extention overrides the setting of             device.\n\n\n\n\n\n"
},

{
    "location": "api/visualisations/#SOM.plotClasses",
    "page": "Visualisation",
    "title": "SOM.plotClasses",
    "category": "function",
    "text": "plotClasses(som::Som, frequencies;\n            title = \"Class Frequencies of Self-Organising Map\",\n            paper = :a4r,\n            colors = \"brg\",\n            detail = 45,\n            device = :display, fileName = \"somplot\")\n\nPlot the population of neurons as colours.\n\nArguments:\n\nsom: the som of type Som; som is the only mandatory argument\nfrequencies: DataFrame of frequencies as outputed by classFrequencies()\ntitle: main title of plot\npaper: plot size; currentlx supported: :a4, :a4r, :letter, :letterr\ncolors: MatPlotLib colourmap (Python-style as string \"gray\" or             Julia-style as Symbol :gray) or dictionary with             classes as keys and colours as vals;             keys can be provides as Strings or Symbols; colours must be             valid coulour definitions (such as RGB, names, etc).             Default: brg\ndetail: only relevant for 3D-plotting of spherical SOMs: higher           values result in smoother display of the 3D-sphere\ndevice: one of :display, :png, :svg, :pdf or any file-type supported           by MatPlotLib; default is :display\nfileName: name of image file. File extention overrides the setting of             device.\n\n\n\n\n\n"
},

{
    "location": "api/visualisations/#Visualisation-1",
    "page": "Visualisation",
    "title": "Visualisation",
    "category": "section",
    "text": "plotDensity\nplotClasses"
},

{
    "location": "LICENSE/#",
    "page": "License",
    "title": "License",
    "category": "page",
    "text": "The SOM.jl package is licensed under the MIT \"Expat\" License:Copyright (c) 2018:                   Andreas Dominik, THM University of Applied Sciences,                 Gießen, Germany    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.    THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
},

]}
