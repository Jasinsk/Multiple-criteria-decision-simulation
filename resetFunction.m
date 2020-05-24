function [initialObs, loggedSignal] = resetFunction()

observations = dataSet(50, 7);
loggedSignal.State = reshape(observations.arraySet,size(observations.arraySet,1),size(observations.arraySet,2),1);
initialObs = loggedSignal.State;

global oracleAction
oracleAction = observations.ansLeft;
end