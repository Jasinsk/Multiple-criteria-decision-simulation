clc, clear all

objectsNum = 50;
criteriaNum = 8;
difLevel = 6;
data = dataSet(objectsNum, criteriaNum, difLevel);

figure
for i=1:criteriaNum
    subplot(2,4,i)
    if data.ansRight(i)==1
        histogram(data.arraySet(:,i));
        title(['Criterion #' num2str(i) ', R'])
    else
        histogram(data.arraySet(:,i));
        title(['Criterion #' num2str(i) ', L'])
    end
end
%% Unsupervised Approach
% option 1
% [Y,Xf,Af] = myNeuralNetworkFunction(inputs);
% option 2
% net = selforgmap([2 2]);
% [net,tr] = train(net,inputs); 
% input_neuron_mapping = vec2ind(net(inputs));

%% Supervised Approach
numRight=0;
numLeft=0;
usedForTrain=zeros(criteriaNum,1);
for i=1:criteriaNum
    if data.ansRight(i)==1 && numRight < 2
        usedForTrain(i)=1;
        numRight=numRight+1;
    elseif data.ansRight(i)==0 && numLeft < 2
        usedForTrain(i)=1;
        numLeft=numLeft+1;
    end
end
[XTrain,YTrain] = deal(mat2cell(data.arraySet(:,usedForTrain==1)',[1 1 1 1]),categorical(data.ansRight(usedForTrain==1)'));
[XValidation,YValidation] = deal(mat2cell(data.arraySet(:,usedForTrain==0)',[1 1 1 1]),categorical(data.ansRight(usedForTrain==0)'));
layers = [
    sequenceInputLayer(1,"Name","input")
    lstmLayer(100,"Name","lstm","OutputMode","last")
    fullyConnectedLayer(2,"Name","fc")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

miniBatchSize = 27;
options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',100, ...
    'MiniBatchSize',miniBatchSize, ...
    'ValidationData',{XValidation,YValidation}, ...
    'GradientThreshold',2, ...
    'Shuffle','every-epoch', ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(XTrain,YTrain,layers,options);
YPred = classify(net,XValidation,'MiniBatchSize',miniBatchSize);
acc = mean(YPred == YValidation);
