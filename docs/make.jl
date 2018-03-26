# using Documenter, SOM
#
# makedocs(modules=[SOM],
#          doctest=true)
#
# deploydocs(deps   = Deps.pip("mkdocs", "python-markdown-math"),
#            repo   = "github.com/andreasdominik/SOM.jl.git",
#            julia  = "0.6",
#            osname = "linux")
#
using Documenter, SOM

makedocs(modules=[SOM],
         clean = false,
         format = :markdown,
         assets = ["assets/favicon.ico"],
         sitename = "SOM.jl",
         authors = "Andreas Dominik",
         pages = [
                  "Introduction" => "index.md",
                  "Tutorials" => Any[
                            "Quick Start" => "tutorials/firstTutorial.md"
                                     ],
                   "API" => Any[
                            "Types" => "api/types.md",
                            "Training" => "api/soms.md",
                            "Visualisation" => "api/visualisations.md"
                               ],
                    "License" => "LICENSE.md"
                  ],
                  # Use clean URLs, unless built as a "local" build
          html_prettyurls = !("local" in ARGS),
          html_canonical = "https://andreasdominik.github.io/SOM.jl/stable/",
         )

deploydocs(repo   = "github.com/andreasdominik/SOM.jl.git",
           julia  = "0.6",
           osname = "linux",
           target = "build",
           deps = nothing,
           make = nothing)
