using Distributions


"""
    bubbleKernel(x, r)

Return 1.0 if dist <= r, else 0.0.
"""
function bubbleKernel(x, r)
    return x <= r ? 1.0 : 0.0
end


"""
    gaussianKernel(x, r)

Return the Gaussian for x  and σ = r/3.
"""
function gaussianKernel(x, r)
    return Distributions.pdf.(Distributions.Normal(0.0,r/3), x)
end
