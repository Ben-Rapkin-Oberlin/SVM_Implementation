using DelimitedFiles,CSV, DataFrames, PrettyTables, Statistics, StatsBase, Random

function standardize(x)
    return ((x .- mean(x)) ./ std(x))
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
    ds=copy(df)
    dg=copy(df)

    
    
    #for x in 3:32
    #    df[!,x] = standardize(df[1:end, x])
    #    end
    
    #ds=transform!(ds, Between(:3,:32) .=> standardize; renamecols=false)
    @time one(df)
    @time one(df)  
    @time one(df)  
    @time zero(df)
    @time zero(df)
    @time zero(df)
    @time two(df)
    @time two(df)
    @time two(df)
    @time three(df)
    @time three(df)
    @time three(df)

    dq=DataFrame([standardize(x) for x in eachcol(df[:,3:32])],:auto)

   print(df[1:4,1:4])
   # print(ds[1:4,1:4])
   # print(dg[1:4,1:4])
    #randomize
    shuffle!(MersenneTwister(1234), df)
    
    #split
    train=df[1:Int(floor(length(df[:,1])*.65)),:]
    valid=df[Int(floor(length(df[:,1])*.65)):Int(floor(length(df[:,1])*.85)),:]
    test=df[Int(floor(length(df[:,1])*.85)):end,:]
    #return

    return train, valid, test
    end

getData()













"""
function getData()
    @info "getting data"
    mat=readdlm("data.csv",',',header=true)[1]
    


    mat = mat[shuffle(1:end), :]
    #@info "read csv"
    rows=size(mat)[1]
    y_train=mat[1:Int64(rows*.8),1]
    first(y_train,3)
    x_train=mat[1:Int64(rows*.8),2:end]
    #@info "made train"
    y_test=mat[Int64(rows*.8):rows,1]
    x_test=mat[Int64(rows*.8):rows,2:end]
    #@info "made test"

    #println("y_train",y_train[1:7])
    b=[]
    for i in 1:3
        push!(b, sum(x_train[i,:]))
    end

    #println("x_train", b)
    #column major
    x_train=x_train'
    x_test=x_test'

    y_train, y_test = Flux.onehotbatch(y_train, 0:9), Flux.onehotbatch(y_test, 0:9)
    a=Flux.onecold(y_train, 0:9)
    #print(size(a))
    #println("ynew",a[1:7])

    loader = Flux.DataLoader((data=x_train, label=y_train), batchsize=bs, shuffle=true);
    test_loader = Flux.DataLoader((data=x_test, label=y_test), batchsize=bs, shuffle=true);
    #loader = Flux.DataLoader((data=x_train, label=y_train), shuffle=true);
    #test_loader = Flux.DataLoader((data=x_test, label=y_test), shuffle=true);
    @info "made loader" #load is where most of the time is spent
    
    return loader,test_loader, x_train, y_train, x_test, y_test
end
"""