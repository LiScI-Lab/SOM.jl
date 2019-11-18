# SOM.jl - Kohonen's self-organising maps for Julia


## Documentation

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://LiScI-Lab.github.io/SOM.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://LiScI-Lab.github.io/SOM.jl/latest)

## Build status
[![Build Status](https://travis-ci.org/LiScI-Lab/SOM.jl.svg?branch=master)](https://travis-ci.org/LiScI-Lab/SOM.jl)
[![Coverage Status](https://coveralls.io/repos/github/LiScI-Lab/SOM.jl/badge.svg?branch=master)](https://coveralls.io/github/LiScI-Lab/SOM.jl?branch=master)
[![codecov.io](http://codecov.io/github/LiScI-Lab/SOM.jl/coverage.svg?branch=master)](http://codecov.io/github/LiScI-Lab/SOM.jl?branch=master)


The package provides training and visualisation functions
for Kohonen's self-organising maps for Julia.
Training functions are implemented in pure Julia, without calling
binary libraries.    

## Installation

Because SOM.jl is a registered package, it can be installed for
Julia v0.7 or later with the package manager as

````Julia
pkg> add SOM
````

The current version 0.4.0 is tested with Julia v1.0.3 and 1.2.0 (use version 0.2.0 with Julia v0.7 and v1.0 because of changes in the PyPlot (i.e. matplotlib) package).

Please refer to the [documentation](https://lisci-lab.github.io/SOM.jl/stable) for details!
