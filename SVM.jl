using Random, LinearAlgebra, Statistics


function train(trainX,trainY,validX,validY)
    lr=.0001
    n=length(trainX)
    println(size(trainX))
    println(size(trainY))
    weights = rand(-.1:.1, 30)
    w=length(weights)
    for epoch in 1:500
        trainX,trainY=shuffle!(MersenneTwister(1234),trainX,trainY)
        for instance in 1:369
            #print(instance)
            if trainY[instance]  * dot(weights,trainX[instance,:]) < 1
                weights += lr * (trainY[instance]  * trainX[instance,:] - 2 * weights)
            else
                weights += lr * (-2 * weights)
                end
            end
        acc=accuracy(validX,validY,weights)
        if acc>.98 
            break
            end
        if epoch%10==0
            println("Epoch: ", epoch, " | Accuracy: " , round(acc*100, digits=5), "%")
            end
        
        end
    return weights
    end


# Calculate Cost
function accuracy(x,y,w)
    correct=0
    n=length(x[:,1])
    for i in 1:n
        if y[i]  * dot(w,x[i,:]) >0
            correct+=1
            end
        end
    return correct/n
    end


