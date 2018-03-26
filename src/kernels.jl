using Distributions


"""
    bubbleKernel(x, r)

Return 1.0 if dist <= r, otherwise 0.0.
"""
function bubbleKernel(x, r)
    return x <= r ? 1.0 : 0.0
end


"""
    gaussianKernel(x, r)

Return Gaussian(x) for μ=0.0 and σ = r/3.
(a value of σ = r/3 makes the training results comparable between different kernels
for sample values or r).
"""
function gaussianKernel(x, r)
    return Distributions.pdf.(Distributions.Normal(0.0,r/3), x)
end
