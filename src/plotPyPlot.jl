#
# Methods for SOM visualisation via PyPlot, MatPlotLib:
#
# Plots are always in a range of (0,0) to (100,100) with the legends
# in the region between (100,0) and (150,100).
#
using PyPlot
using PyCall
@pyimport matplotlib.patches as patches
@pyimport matplotlib.cm as cm               # colourmap
@pyimport mpl_toolkits.axes_grid1 as ag1
@pyimport mpl_toolkits.mplot3d as mp3

ρ = 1.0                 # global scaling
fig = nothing           # the figure
█ = nothing             # \blockfull: the subplot into which everything is plotted






"""
    sigmoidScale(num, perc, min)

Return a non-linear scaled colour value. 85%-percentile is mapped to
tanh(1.5). Scaled values 0 < x < min are returned as min.
"""
function sigmoidScale(num, perc, min = 0.1)

    TANH_ANCHOR = 1.5     # perc is mapped to 1.5 on tanh-scale


    # keep precise 0:
    #
    if num == 0
        return 0.0
    end

    # set 85%-percentile to 1.5 for scale colour with tanh
    # modify so that 0->0.0, 1->min, oo->1.0:
    #
    perc = floor(perc) + 1
    colNum = (tanh((num-1) / perc * TANH_ANCHOR) * (1-min)) + min

    # start scale at MIN_VAL
    #
    if colNum < min
        colNum = min
    end

    return colNum
end



function getPaperSizes(paper::Symbol; margin = 1.0)

    if paper == :a4
        size = (8.3, 11.7)
    elseif paper == :a4r
        size = (11.7, 8.3)
    elseif paper == :letter
        size = (8.5, 11.0)
    elseif paper == :letterr
        size = (11.0, 8.5)
    else
        size = (10.0, 10.0)
    end

    size = size .- margin
    return size
end



function adjustLineWidth(som::Som, lwd)

    defaultSize = 10
    maxDim = max(som.xdim, som.ydim)

    return Int(ceil(defaultSize / maxDim * lwd))
end


function drawBackGround(som)

    if som.topol == :hexagonal
        x = (-0.75, som.xdim+0.5)
        y = (-0.75, (som.ydim-1)*0.866+0.75)
        █[:set_xlim](x)
        █[:set_ylim](y)
    elseif som.topol == :spherical
        minx, miny, minz = minimum(som.grid, 1)
        maxx, maxy, maxz = maximum(som.grid, 1)
        x = (minx - 0.5, maxx+0.5)
        y = (miny - 0.5, maxy+0.5)
        z = (minz - 0.5, maxz+0.5)
        █[:set_xlim](x)
        █[:set_ylim](y)
        █[:set_zlim](z)
    else
        x = (-0.75, som.xdim+0.5)
        y = (-0.75, som.ydim-1+0.75)
        █[:set_xlim](x)
        █[:set_ylim](y)
    end

    █[:axis]("off")
    █[:set_aspect]("equal")
    fig[:patch][:set_facecolor]("white")
end

function drawTitle(title)

    title = PyPlot.title(title)
    title[:set_position]([0.5, 1.05])
    # family = "sans-serif",
    # size = 15
end






function drawColorBar(som, population, colourMap)

    # set 85%-percentile to 1.5 for scale colour with tanh:
    #
    perc85 = percentile(population, 85)
    maxPop = maximum(population)

    # Generate fake ScalarMappable for colorbar:
    #
    sm = cm.ScalarMappable(cmap=colourMap)
    sm[:set_array]([])

    # # make new axws for colorbar (for better positioning, punt colourbar
    # # into extra axes):
    # #
    # cbAxes = fig[:add_axes]([0.9, 0.1, 0.03, 0.8])
    # cbAxes[:axis]("off")
    # cbar = PyPlot.colorbar(sm, cax = cbAxes)
    # # cbar = PyPlot.colorbar(sm)
    # cbar[:set_label]("Population of neurons")

    divider = ag1.make_axes_locatable(█)
    cax = divider[:append_axes]("right", size=0.25, pad=0.05)
    cbar = PyPlot.colorbar(sm, cax=cax)
    #cax[:axis]("off")

    # tick positions depend on absolute numbers of
    ticks = [1, Int(round(maxPop*0.25)), Int(round(maxPop*0.5)),
             Int(round(maxPop*0.75)), maxPop]
    tickLabels = ticks
    tickPos = sigmoidScale.(ticks, perc85)

    cbar[:set_ticks](tickPos)
    cbar[:set_ticklabels](ticks)
#    cbar[:set_ticklabels]([8, 4, 1], update_ticks = true)
    cbar[:update_ticks]()
end


function drawFreqLegend(colours)

    # create proxy patches for legend:
    #
    classes = sort(collect(keys(colours)))
    proxys = [patches.Patch(color=colours[c], label=string(c)) for c in classes]
    PyPlot.legend(handles = proxys,
                  bbox_to_anchor=(1.05, 0.1), loc=3, borderaxespad=0.,
                  frameon=false)
end


"""
    drawSquare(x, y, siz, lwd, fill::Bool, linCol, fillCol)

Draw a square with diameter size around (x,y).
"""
function drawSquare(x, y, siz, lwd, fill::Bool, linCol, fillCol)

    δ = siz / 2
    points = [x-δ y-δ;
              x-δ y+δ;
              x+δ y+δ;
              x+δ y-δ]
              points = points .* ρ

    poly = patches.Polygon(points, closed = true,
                                   fill = fill, facecolor = fillCol,
                                   linewidth = lwd, edgecolor = linCol)
    █[:add_artist](poly)
end



"""
    drawHexagon(x, y, siz, lwd, fill::Bool, linCol, fillCol)

Draw an hexagon with diameter size around (x,y).
"""
function drawHexagon(x, y, siz, lwd, fill::Bool, linCol, fillCol)

    δy = 0.5 * siz * tan(π/6)
    h  = 0.5 * siz / cos(π/6)
    δx = 0.5 * siz
    points = [x-δx y-δy;
              x-δx y+δy;
              x    y+h;
              x+δx y+δy;
              x+δx y-δy;
              x    y-h]
    points = points .* ρ

    poly = patches.Polygon(points, closed = true,
                                   fill = fill, facecolor = fillCol,
                                   linewidth = lwd, edgecolor = linCol)
    █[:add_artist](poly)
end





"""
    drawNeurons(som::Som, col, lwd::Number)

Draw all neurons as empty squares or hexagons.
"""
function drawNeurons(som::Som; col = "black", lwd = 1)

    # set shape to topol:
    #
    if som.topol == :hexagonal
        draw = drawHexagon
    else
        draw = drawSquare
    end

    # adjust linewidth:
    #
    lwd = adjustLineWidth(som, lwd)

    for i in 1:som.nCodes
        draw(som.grid[i,1], som.grid[i,2], 1.0, lwd, false, col, "none")
    end
end


"""
    drawDesity(som::Som, population, colormap)

Draw the population of neurons as colors.
"""
function drawDensity(som::Som, population, colourMap)

    # set shape to topol:
    #
    if som.topol == :hexagonal
        draw = drawHexagon
    else
        draw = drawSquare
    end

    # set 85%-percentile to 1.5 for scale colour with tanh:
    #
    perc85 = percentile(population, 85)

    cmap = get_cmap(colourMap)
    for i in 1:som.nCodes
        colNum = sigmoidScale( population[i], perc85)
        col = colNum > 0 ? cmap(colNum) : "white"
        # println("$i: pop: $(som.population[i]), $colNum, col: $col")
        draw(som.grid[i,1], som.grid[i,2], 1.0, 0, true, "none", col)
    end
end

function drawPieChart(x, y, freqs, colours, lwd, d)

    r = d / 2
    classes = names(freqs)
    pieStart = 0.0
    pieEnd = 0.0

    for c in sort(classes)

        pieStart = pieEnd
        pieEnd = pieStart + freqs[1,c] * 360
        wedge = patches.Wedge((x*ρ,y*ρ), r*ρ, pieStart, pieEnd,
                              fill = true, facecolor = colours[c],
                              linewidth = 0, edgecolor = "none")
        █[:add_artist](wedge)
    end

    circle = patches.Circle((x*ρ,y*ρ), radius = r*ρ,
                            fill = false,
                            linewidth = lwd, edgecolor = "0.5")
    █[:add_artist](circle)

end

function drawPieCharts(som::Som, frequencies::DataFrame, colours)

    # set 85%-percentile to 1.5 for scale pieChart with tanh:
    #
    perc85 = percentile(frequencies[:Population], 85)

    # loop neurons:
    #
    for i in 1:som.nCodes

        if frequencies[i, :Population] != 0

            r = sigmoidScale(frequencies[i, :Population], perc85)
            drawPieChart( som.grid[i,1], som.grid[i,2],
                          frequencies[i,5:end],
                          colours, adjustLineWidth(som, 1), r)
        end
    end
end

"""
    printToDevice(device, fName)

Print to file or display.

Prints the current plot to the device `device`. If fName ends with
`.png, .svg, .pdf` this overrides the setting in device.
"""
function printToDevice(device, fName)

    # select device from filename, rather than from device:
    #
    if ismatch(r"\.[a-zA-Z]{3}$", fName)
        println("Writing plot to file $fName")
        PyPlot.savefig(fName)
    elseif device != :display
        ext = string(device)
        fName = fName * "." * ext
        println("Writing plot to file $fName")
        PyPlot.savefig(fName)
    else
        PyPlot.show()
    end
end


function drawPopulation(som::Som, population, title, paper, colourMap, device, fName)

    paperSize = getPaperSizes(paper)
    global fig = PyPlot.figure(figsize=paperSize)
    global █ = fig[:add_subplot](1,1,1)
    drawBackGround(som)
    drawTitle(title)

    drawDensity(som, population, colourMap)
    drawNeurons(som, col = "0.5", lwd = 1)
    drawColorBar(som, population, colourMap)

    printToDevice(device, fName)
end

function drawFrequencies(som::Som, frequencies, title, paper,
                         colours, device, fName)

    paperSize = getPaperSizes(paper)
    global fig = PyPlot.figure(figsize=paperSize)
    global █ = fig[:add_subplot](1,1,1)
    drawBackGround(som)
    drawTitle(title)

    drawPieCharts(som, frequencies, colours)
    drawNeurons(som, col = "0.5", lwd = 1)
    drawFreqLegend(colours)

    printToDevice(device, fName)

end

function drawSpherePopulation(som::Som, population, detail, title, paper,
                              colourMap, device, fName)

    paperSize = getPaperSizes(paper)
    global fig = PyPlot.figure(figsize=paperSize)
    global █ = fig[:add_subplot](1,1,1, projection="3d")
    drawBackGround(som)
    # █[:axis]("off")
    # █[:set_aspect]("equal")
    # fig[:patch][:set_facecolor]("white")
    drawTitle(title)

    drawSphereColour(som, population, detail,colourMap)
    #drawColorBar(som, population, colourMap)

    printToDevice(device, fName)
end


function drawSphereFreqs(som::Som, frequencies, detail, title, paper,
                              colours, device, fName)

    paperSize = getPaperSizes(paper)
    global fig = PyPlot.figure(figsize=paperSize)
    global █ = fig[:add_subplot](1,1,1, projection="3d")
    █[:axis]("off")
    █[:set_aspect]("equal")
    fig[:patch][:set_facecolor]("white")
    drawTitle(title)

    drawSphereClasses(som, frequencies, detail, colours)
    drawFreqLegend(colours)

    printToDevice(device, fName)
end
