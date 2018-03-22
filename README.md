# SOM.jl - Kohonen's self-organising maps for Julia

This package is currently under development and not yet ready for use!

## Documentaion

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://andreasdominik.github.io/SOM.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://andreasdominik.github.io/SOM.jl/latest)

<!--
[![Build Status](https://travis-ci.org/andreasdominik/SOM.jl.svg?branch=master)](https://travis-ci.org/andreasdominik/SOM.jl)

[![Coverage Status](https://coveralls.io/repos/andreasdominik/SOM.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/andreasdominik/SOM.jl?branch=master)

[![codecov.io](http://codecov.io/github/andreasdominik/SOM.jl/coverage.svg?branch=master)](http://codecov.io/github/andreasdominik/SOM.jl?branch=master)
 -->

## Installation

Because the package is not yet registered, it can be installed from the
Julia REPL with:

````Julia
Pkg.clone("https://github.com/andreasdominik/SOM.jl.git")
````

The package requires
`DataFrames,
Distances,
Distributions,
ProgressMeter,
StatsBase,
PyPlot,` and `PyCall` with the Python package `matplotlib` to be installed.
The requirements will be installed automatically by package manager.
Sometimes `matplotlib` causes problems. The easiest way of manually installation is
from within Julia into the default Julia-Python environment via:

````Julia
ENV["PYTHON"]=""
Pkg.add("Conda")
using Conda
Conda.update()

Conda.add("matplotlib")
Pkg.add("PyCall")
Pkg.build("PyCall")
Pkg.add("PyPlot");
````
