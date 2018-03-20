
<a id='Visualisation-1'></a>

# Visualisation

<a id='SOM.plotDensity' href='#SOM.plotDensity'>#</a>
**`SOM.plotDensity`** &mdash; *Function*.



```
plotDensity(som::Som; predict = nothing,
            title = "somPlot", paper = :a4r,
            colormap = "autumn_r",
            device = :display, fileName = "somplot")
```

Plot the population of neurons as colours.

**Arguments:**

  * `som`: the som of type `Som`; som is the only mandatory argument
  * `predict`: DataFrame of mappings as outputed by winners()
  * `title`: main title of plot
  * `paper`: plot size; currentlx supported: `:a4, :a4r, :letter, :letterr`
  * `colormap`: MatPlotLib colourmap (Python-style as string `"gray"` or             Julia-style as Symbol `:gray`)
  * `device`: one of `:display, :png, :svg, :pdf` or any file-type supported           by MatPlotLib; default is `:display`
  * `fileName`: name of image file. File extention overrides the setting of             `device`.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/3ec925cb2c75a6af3bf9a16b2c328dc53b912898/src/api.jl#L150-L169' class='documenter-source'>source</a><br>

<a id='SOM.plotClasses' href='#SOM.plotClasses'>#</a>
**`SOM.plotClasses`** &mdash; *Function*.



```
plotClasses(som::Som, frequencies;
            title = "somPlot", paper = :a4r,
            colormap = "rainbow",
            device = :display, fileName = "somplot")
```

Plot the population of neurons as colours.

**Arguments:**

  * `som`: the som of type `Som`; som is the only mandatory argument
  * `frequencies`: DataFrame of frequencies as outputed by classFrequencies()
  * `title`: main title of plot
  * `paper`: plot size; currentlx supported: `:a4, :a4r, :letter, :letterr`
  * `colors`: MatPlotLib colourmap (Python-style as string `"gray"` or             Julia-style as Symbol `:gray`) *or* dictionary with             classes as keys and colours as vals; default: `brg`
  * `device`: one of `:display, :png, :svg, :pdf` or any file-type supported           by MatPlotLib; default is `:display`
  * `fileName`: name of image file. File extention overrides the setting of             `device`.


<a target='_blank' href='https://github.com/andreasdominik/SOM.jl/blob/3ec925cb2c75a6af3bf9a16b2c328dc53b912898/src/api.jl#L198-L218' class='documenter-source'>source</a><br>

