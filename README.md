# SOM.jl - Kohonen's self-organising maps for Julia

This package is currently under development and not yet ready for use!

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://andreasdominik.github.io/SOM.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://andreasdominik.github.io/SOM.jl/latest)

<!--
[![Build Status](https://travis-ci.org/andreasdominik/SOM.jl.svg?branch=master)](https://travis-ci.org/andreasdominik/SOM.jl)

[![Coverage Status](https://coveralls.io/repos/andreasdominik/SOM.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/andreasdominik/SOM.jl?branch=master)

[![codecov.io](http://codecov.io/github/andreasdominik/SOM.jl/coverage.svg?branch=master)](http://codecov.io/github/andreasdominik/SOM.jl?branch=master)
 -->



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
