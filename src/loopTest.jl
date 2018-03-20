using ProgressMeter

x = zeros(10,10)

@time @showprogress 1 for i in 1:10000
        for j in 1:10000
            for k in 1:10
                for l in 1:10
                    x[k,l] = l
                end
            end
        end
    end

print()
