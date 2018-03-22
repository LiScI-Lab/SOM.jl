function testTrain(train, topol, toroidal)

    xdim = 8
    ydim = 10

    som = initSOM(train, xdim, ydim, norm = :zscore,
    topol = topol, toroidal = toroidal)
    som = trainSOM(som, train, 10000)

    ntrain = nrow(train)
    npopul = sum(som.population)

    return ntrain == npopul
end




function testVisual(train, topol, toroidal)

    xdim = 8
    ydim = 10

    tr  = train[1:50,:]
    val = train[51:100,:]

    som = initSOM(tr, xdim, ydim, norm = :zscore,
    topol = topol, toroidal = toroidal)

    vis = mapToSOM(som, tr)

    ntr    = nrow(tr)
    npopul = nrow(vis)

    return ntr == npopul
end


function testFreqs(train, topol, toroidal)

    xdim = 8
    ydim = 10

    som = initSOM(train, xdim, ydim, norm = :zscore,
    topol = topol, toroidal = toroidal)

    vis = mapToSOM(som, tr)

    ntr    = nrow(tr)
    npopul = nrow(vis)

    return ntr == npopul
end
