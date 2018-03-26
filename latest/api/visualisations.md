
<a id='Visualisation-1'></a>

# Visualisation

<a id='SOM.plotDensity' href='#SOM.plotDensity'>#</a>
**`SOM.plotDensity`** &mdash; *Function*.



```
plotDensity(som::Som; predict = nothing,
            title = "Density of Self-Organising Map",
            paper = :a4r,
            colormap = "autumn_r",
            detail = 45,
            device = :display, fileName = "somplot")
```

Plot the population of neurons as colours.

**Arguments:**

  * `som`: the som of type `Som`; som is the only mandatory argument
  * `predict`: DataFrame of mappings as outputed by `mapToSOM()`
  * `title`: main title of plot
  * `paper`: plot size; currentlx supported: `:a4, :a4r, :letter, :letterr`
  * `colormap`: MatPlotLib colourmap (Python-style strings; e.g. `"Greys"`).
  * `detail`: only relevant for 3D-plotting of spherical SOMs: higher           values result in smoother display of the 3D-sphere
  * `device`: one of `:display, :png, :svg, :pdf` or any file-type supported           by MatPlotLib; default is `:display`
  * `fileName`: name of image file. File extention overrides the setting of             `device`.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/d5e2e7a264c5bfbeadb49b83716efc54386c99ea/src/api.jl#L158-L180' class='documenter-source'>source</a><br>

<a id='SOM.plotClasses' href='#SOM.plotClasses'>#</a>
**`SOM.plotClasses`** &mdash; *Function*.



```
plotClasses(som::Som, frequencies;
            title = "Class Frequencies of Self-Organising Map",
            paper = :a4r,
            colors = "brg",
            detail = 45,
            device = :display, fileName = "somplot")
```

Plot the population of neurons as colours.

**Arguments:**

  * `som`: the som of type `Som`; som is the only mandatory argument
  * `frequencies`: DataFrame of frequencies as outputed by classFrequencies()
  * `title`: main title of plot
  * `paper`: plot size; currentlx supported: `:a4, :a4r, :letter, :letterr`
  * `colors`: MatPlotLib colourmap (Python-style as string `"gray"` or             Julia-style as Symbol `:gray`) *or* dictionary with             classes as keys and colours as vals; default: `brg`
  * `detail`: only relevant for 3D-plotting of spherical SOMs: higher           values result in smoother display of the 3D-sphere
  * `device`: one of `:display, :png, :svg, :pdf` or any file-type supported           by MatPlotLib; default is `:display`
  * `fileName`: name of image file. File extention overrides the setting of             `device`.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/d5e2e7a264c5bfbeadb49b83716efc54386c99ea/src/api.jl#L215-L239' class='documenter-source'>source</a><br>

