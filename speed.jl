#Test speed of Dataframe vs Matrix
using Base,DelimitedFiles,CSV, DataFrames, PrettyTables, Statistics, StatsBase, Random

function standardize(x)
    return ((x .- mean(x)) ./ std(x))
    end

function one(df)
    for x in 3:32
        df[!,x] = standardize(df[1:end, x])
        end
    end



function two(mat)
    for x in 3:32
        mat[1:end,x] = standardize(mat[1:end, x])
        end
    end

function three(mat)
    mat[:,3:32]=standardize.(mat[:,3:32])
    end

function four(df)
    df[:,3:32]=standardize.(df[:,3:32])
    end


    function one(df)
        for x in 3:32
            df[!,x] = standardize(df[1:end, x])
            end
        end
    
    function zero(df)
        transform!(df, Between(:3,:32) .=> standardize; renamecols=false)
        end
    
    function two(df)
        transform(df, Between(:3,:32) .=> standardize; renamecols=false)
        end
    function three(df)
        DataFrame([standardize(x) for x in eachcol(df[:,3:32])],:auto)
        end


function getData()
    df=CSV.read("data.csv",DataFrame)
    df.diagnosis = replace.(df.diagnosis, "M" => 1, "B" => -1)
    mat=Matrix(df)

    @time one(df)
    @time one(df)
    
    @time two(mat)
    @time two(mat)
        
    @time three(mat)
    @time three(mat)
    
    @time four(df)
    @time four(df)
    dq=DataFrame([standardize(x) for x in eachcol(df[:,3:32])],:auto)


    #print(df[1:4,1:4])
    #print(mat[1:4,1:4])
   
    end

getData()