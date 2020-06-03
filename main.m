clc, clear all

objectsNum = 50;
criteriaNum = 8;
difLevel=7;
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
[XTrain,YTrain] = data.arrayset;
[XValidation,YValidation] = data.arrayset;
layers = [
    sequenceInputLayer(4,"Name","input")
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
