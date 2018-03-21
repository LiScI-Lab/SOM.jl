using Documenter, SOM

makedocs(modules=[SOM],
         doctest=true)

deploydocs(deps   = Deps.pip("mkdocs", "python-markdown-math"),
           repo   = "github.com/andreasdominik/SOM.jl.git",
           target = build,
           julia  = "0.6.2",
           osname = "linux")
