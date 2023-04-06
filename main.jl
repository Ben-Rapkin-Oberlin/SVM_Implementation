include("ReadData.jl")
include("SVM.jl")
using DataFrames
#Get Data
trainX,trainY,validX,validY,testX,testY = getData() 

#train SVM
weights=train(trainX,trainY,validX,validY)

#test SVM
print(accuracy(testX,testY,weights))


#plot results