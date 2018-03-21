# SOM.jl - Kohonen's self-organising maps for Julia

The package provides training and visualisation functions
for Kohonen's self-organising maps for Julia.
Training functions are implemented in pure Julia, without calling
external libraries.

Visualisation is implemented by using Python's MatPlotLib.


## Self-organising maps

Self-organising maps (also referred to as SOMs or *Kohonen* maps) are
artificial neural networks introduced by Teuvo Kohonen in the 1980s.
Despite of their age SOMs are still widely used as an easy and robust
unsupervised learning algorithm
for analysis and visualisation of high-dimensional data.

The SOM algorithm maps high-dimensional vectors into a lower-dimensional grid. Most often
the target grid is two-dimensional, resulting into  intuitively interpretable maps.

For more details see Kohonen's papers, such as

> Teuvo Kohonen, *Biological Cybernetics,* **43** (1982) p. 59-69
> Teuvo Kohonen, *Biological Cybernetics,* **44** (1982) p. 135-140    

Technical details and background can be found in Kohonen's still relevant
technical report:

> Teuvo Kohonen, Jussi Hynninen, Jari Kangas, and Jorma Laaksonen.
  *SOM_PAK: The Self-Organizing Map Program Package.*
  Technical Report A31, Helsinki University of Technology,
  Laboratory of Computer and Information Science,
  FIN-02150 Espoo, Finland, 1996.
  (`http://www.cis.hut.fi/research/papers/som_tr96.ps.Z`)


## Installation

Because the package is not yet registered, it can be installed from the
Julia REPL with:

````Julia
Pkg.clone("https://github.com/andreasdominik/SOM.jl.git")
````

## Quick Start

```@contents
Pages = [
    "tutorials/firstTutorial.md"
    ]
Depth = 2
```

## API
```@contents
Pages = [
    "api/types.md",
    "api/soms.md",
    "api/visualisations.md"
    ]
Depth = 2
```

## Index

```@index
```
