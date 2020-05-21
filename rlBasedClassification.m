clearvars
clc

% custom environment
observationInfo = rlNumericSpec([50 1]);
observationInfo.Name = 'Objects States';
actionInfo = rlFiniteSetSpec({[0 1]},{[0 1]},{[0 1]},{[0 1]},{[0 1]},{[0 1]},{[0 1]}); % Possible actions (0/1) for each of seven criteria
actionInfo.Name = 'Action on Criteria';

env = rlFunctionEnv(observationInfo,actionInfo,'stepFunction','resetFunction');

% custom agent
actInfo = getActionInfo(env);
actDimensions = actInfo.Dimensions;

obsInfo = getObservationInfo(env);
obsDimensions = obsInfo.Dimensions;

% create the network to be used as approximator in the critic
criticNetwork = [
    sequenceInputLayer([50 7 1],"Name","observation")
    fullyConnectedLayer(7,"Name","fc_1")
    reluLayer("Name","relu")
    fullyConnectedLayer(7,"Name","fc_2")];

opt = rlRepresentationOptions('LearnRate',0.0001);
critic = rlValueRepresentation(criticNetwork,obsInfo,actInfo,...
        'Observation',{'observation'},opt);

% create the network to be used as approximator in the actor
actorNetwork = [
    sequenceInputLayer([50 7 1],"Name","observation")
    fullyConnectedLayer(7,"Name","fc_1")
    reluLayer("Name","relu")
    fullyConnectedLayer(7,"Name","fc_2")];

opt = rlRepresentationOptions('LearnRate',0.0001);
actor = rlStochasticActorRepresentation(actorNetwork,obsInfo,actInfo,...
        'Observation',{'observation'},opt);

% create the agent
agent = rlACAgent(actor,critic);

opt = rlTrainingOptions(...
    'MaxEpisodes',1000,...
    'MaxStepsPerEpisode',1000,...
    'StopTrainingCriteria',"AverageReward",...
    'StopTrainingValue',480);
trainStats = train(agent,env,opt);
    
function [initialObservation, loggedSignal] = resetFunction()

loggedSignal.State = createObjects();
initialObservation = loggedSignal.State;

end

function [nextObs,reward,loggedSignals] = stepFunction(action,loggedSignals,oracleAction)
% Define the environment constants.
rewardValue = 1; % Reward each time criterion is appropriately classified
penaltyValue = -10; % Penalty each time criterion is wrongly classified

nextObs = createObjects();

if action == oracleAction
    reward = rewardValue;
else
    reward = penaltyValue;
end

end