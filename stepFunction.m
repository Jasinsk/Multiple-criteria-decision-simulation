function [nextObs,reward,isDone,loggedSignals] = stepFunction(action,loggedSignals)
% Define the environment constants.
rewardValue = 1; % Reward each time criterion is appropriately classified
penaltyValue = -10; % Penalty each time criterion is wrongly classified

observations = dataSet(50, 7);
nextObs =  reshape(observations.arraySet,size(observations.arraySet,1),size(observations.arraySet,2),1);
global oracleAction
oracleAction = observations.ansLeft;

reward = sum(action==oracleAction)*rewardValue + sum(action~=oracleAction)*penaltyValue;

if sum(action==oracleAction)>5
    isDone = true;
else
    isDone = false;
end

end