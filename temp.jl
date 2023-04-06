using DelimitedFiles,CSV, DataFrames, PrettyTables, Statistics, StatsBase, Random

function standardize(x)
    return ((x .- mean(x)) ./ std(x))
    end

function one(df)
    for x in 1:3
        df[!,x] = standardize(df[1:end, x])
        end
    end

function zero(df)
    transform!(df,All() .=> standardize; renamecols=false)
    end

function three(df)
    DataFrame([standardize(x) for x in eachcol(df[:,1:3])],:auto)
    end

function getData()
    df=CSV.read("a.csv",DataFrame)
    print(df[1:4,1:4])
    #df.diagnosis = replace.(df.diagnosis, "M" => 1, "B" => -1)
    

    
    
    for x in 1:4
        df[!,x] = standardize(df[1:end, x])
        end
    
    #ds=transform!(ds, Between(:3,:32) .=> standardize; renamecols=false)


   print(df[1:4,1:4])
   # print(ds[1:4,1:4])
   # print(dg[1:4,1:4])
    #randomize
    shuffle!(MersenneTwister(1234), df)
    print(df[1:4,1:4])
    #split
    end

getData()