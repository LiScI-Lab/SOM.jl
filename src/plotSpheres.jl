
# @pyimport mpl_toolkits.mplot3d as mp3

"""
    buildSphere(detail, r)

# Arguments:
- `detail`: quality of sphere: 360 == 1 degree patches
- `r`: radius of sphere
"""
function buildSphere(detail, r)

    α = collect(linspace(0, 2π, detail))
    ϕ = collect(linspace(0, π, detail))

    # a .* b.' ist the tensor-product (deprecated)
    # better with Tensor-Pkg \otimes
    x = cos.(α) ⊗ sin.(ϕ)
    y = sin.(α) ⊗ sin.(ϕ)
    z = ones(length(α)) ⊗ cos.(ϕ)

    x = x .* r
    y = y .* r
    z = z .* r

    return x, y, z
end


"""
    assignSphereColours(grid, detail, x, y, z)
"""
function assignSphereColours(detail, x, y, z, grid, codeCols)

    sphereCols = zeros(Float64, detail, detail, 4)
    winners = zeros(Int, detail, detail)
    for j in 1:detail
        for i in 1:detail

            winner = findWinner(grid, [x[i,j], y[i,j], copy(transpose(z[i,j]))])
            sphereCols[i, j, 1] = codeCols[winner][1]
            sphereCols[i, j, 2] = codeCols[winner][2]
            sphereCols[i, j, 3] = codeCols[winner][3]
            sphereCols[i, j, 4] = codeCols[winner][4]
            winners[i,j] = winner
        end
    end

    return sphereCols
end



"""
    drawSphereDesity(som::Som, population, detail, colormap)

Draw the population of neurons as colors on a sphere.
"""
function drawSphereColour(som::Som, population, detail, colourMap)

    # set 85%-percentile to 1.5 for scale colour with tanh:
    #
    perc85 = percentile(population, 85)
    cmap = get_cmap(colourMap)

    # make vector of colours, one for each code
    # use population vector
    #
    codeCols = Array{Any,1}(undef, som.nCodes)
    for i in 1:som.nCodes
        colNum = sigmoidScale( population[i], perc85)
        col = colNum > 0 ? cmap(colNum) : (1.0, 1.0, 1.0, 1.0)
        codeCols[i] = col
    end

    x, y, z = buildSphere(detail, norm(som.grid[1,:]))
    sphereCols = assignSphereColours(detail, x, y, z, som.grid, codeCols)

    # plot sphere:
    #
    █[:plot_surface](x, y, z, rstride=1, cstride=1, color = "w",
                     facecolors=sphereCols, shade=true)
end



"""
    drawSphereClasses(som::Som, frequencies, detail, colours)

Draw the neurons  on a sphere with colour of class with highest count
in each neuron.
"""
function drawSphereClasses(som::Som, frequencies, detail, colours)

    freqs = frequencies[:,5:end]
    classNames = names(freqs)
    codeCols = Array{Any,1}(undef, som.nCodes)

    for i in 1:som.nCodes

        maxVal, idx = findmax(convert(Array, freqs[i,:]))
        if maxVal == 0
            col = (1.0, 1.0, 1.0, 1.0)
        else
            col = colours[classNames[idx]]
        end
        codeCols[i] = col
    end

    x, y, z = buildSphere(detail, norm(som.grid[1,:]))
    sphereCols = assignSphereColours(detail, x, y, z, som.grid, codeCols)

    # plot sphere:
    #
    █[:plot_surface](x, y, z, rstride=1, cstride=1, color = "w",
                     facecolors=sphereCols, shade=true)
end
