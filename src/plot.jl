# DEPRECATED! Use plotPyPlot.jl instead
#
# Methods for SOM visualisation
#
using Plots

"""
   makeSquare(x, y, a = 1.0)

 Defines a Shape square with side length a, centered around x,y.
 """
function makeSquare(x, y, a = 1.0)

    x_li = x - a/2
    x_re = x + a/2
    y_lo = y - a/2
    y_hi = y + a/2
    square = Shape([(x_li,y_lo), (x_li,y_hi), (x_re,y_hi),
                    (x_re,y_lo), (x_li,y_lo)])

    return square
end

function drawNeurons(p, som::Som, lcol = :black, lwd = 1,
                    fillcol = :white)

    println("$(show(IOContext(STDOUT, limit=true), "text/plain", grid))")

    for x in som.grid[:,1], y in som.grid[:,2]
        plot!(p, makeSquare(x,y),
                 linewidth=lwd, linecolor=lcol, fillcolor=fillcol)
    end
end


#
#
#
#
#    savefig("plot.svg").
#
#
#
#

function makeCanvas(som::Som, margin = 1.0)

    x_li = -margin
    x_re = som.xdim + margin
    y_lo = -margin
    y_hi = som.ydim + margin
    square = Shape([(x_li,y_lo), (x_li,y_hi), (x_re,y_hi),
                    (x_re,y_lo), (x_li,y_lo)])

    return square
end

function drawCanvas(som::Som, bckcol = :white)

    pyplot(leg = false, grid = false, ticks = nothing, border = nothing,
           aspect_ratio = :equal, size=(1000,1000))
    p = plot(makeCanvas(som), linewidth = 0.0, fillcolor = bckcol)
    #savefig(p, "plot.png")

    return(p)

end


function somPlot(som::Som)

    p = drawCanvas(som)

    plot!(p, makeSquare(5,5,1),
             linewidth=1, linecolor=:red, fillcolor=:blue)
    drawNeurons(p, som)
    savefig(p, "plot.png")
    # display(p)
end
