function testTrain(train, topol; toroidal = false,
                    normType = :zscore, kernel = gaussianKernel)

    xdim = 8
    ydim = 10

    som = initSOM(train, xdim, ydim, norm = normType,
                  topol = topol, toroidal = toroidal)
    som = trainSOM(som, train, 10000, kernelFun = kernel)

    ntrain = nrow(train)
    npopul = sum(som.population)

    return ntrain == npopul
end




function testVisual(train, topol)

    xdim = 8
    ydim = 10

    tr  = train[1:50,:]
    val = train[51:100,:]

    som = initSOM(tr, xdim, ydim, norm = :zscore,
    topol = topol, toroidal = false)
    som = trainSOM(som, tr, 10000)

    vis = mapToSOM(som, tr)

    ntr    = nrow(tr)
    npopul = nrow(vis)

    return ntr == npopul
end


function testFreqs(train, wClasses, classes)

    xdim = 8
    ydim = 10

    som = initSOM(train, xdim, ydim)
    som = trainSOM(som, train, 10000)

    f = classFrequencies(som, wClasses, classes)

    res = sort( [String(x) for x in names(f)[5:end]])
    ori = sort(unique(iris.Species))

    return res == ori
end




function testDensityPlot(train, topol)

    xdim = 8
    ydim = 10
    fName = "density.png"

    som = initSOM(train, xdim, ydim, topol = topol)
    som = trainSOM(som, train, 10000)

    if MPL_INSTALLED
        plotDensity(som, fileName = fName)
        ok = isfile(fName)
    else
        result = plotDensity(som, fileName = fName)
        ok = typeof(result) == Symbol && result == :ERR_MPL
    end

    return ok
end

function testOtherDensityPlot(tr, pred)

    xdim = 8
    ydim = 10
    fName = "density.png"

    som = initSOM(tr, xdim, ydim)
    som = trainSOM(som, tr, 10000)

    vis = mapToSOM(som, pred)

    if MPL_INSTALLED
        plotDensity(som, predict = vis, fileName = fName)
        ok = isfile(fName)
    else
        result = plotDensity(som, predict = vis, fileName = fName)

        ok = typeof(result) == Symbol && result == :ERR_MPL
    end

    return ok
end



function testClassesPlot(train, wClasses, topol)

    xdim = 8
    ydim = 10
    fName = "classes.png"

    som = initSOM(train, xdim, ydim, topol = topol)
    som = trainSOM(som, train, 10000)

    freqs = classFrequencies(som, wClasses, :Species)
    if MPL_INSTALLED
        plotClasses(som, freqs, fileName = fName)
        ok = isfile(fName)
    else
        result = plotClasses(som, freqs, fileName = fName)

        ok = typeof(result) == Symbol && result == :ERR_MPL
    end

    return ok
end

function testClassesToFile(train, wClasses)

    xdim = 8
    ydim = 10
    fName = "classesfile"

    som = initSOM(train, xdim, ydim)
    som = trainSOM(som, train, 10000)

    freqs = classFrequencies(som, wClasses, :Species)
    if MPL_INSTALLED
        plotClasses(som, freqs, device = :svg, fileName = fName)
        ok = isfile(fName * ".svg")
    else
        result = plotClasses(som, freqs, device = :svg, fileName = fName)

        ok = typeof(result) == Symbol && result == :ERR_MPL
    end

    return ok
end
