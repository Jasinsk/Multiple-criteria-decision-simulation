clearvars
clc

addpath ./permn/

% custom environment
observationInfo = rlNumericSpec([50 7]);
observationInfo.Name = 'Objects';
actionInfo = rlFiniteSetSpec(num2cell(permn([0 1],7),2)); % Possible actions (0/1) for each of seven criteria
actionInfo.Name = 'Action on Criteria';

env = rlFunctionEnv(observationInfo,actionInfo,'stepFunction','resetFunction');

% custom agent
actInfo = getActionInfo(env);
actDimensions = actInfo.Dimension;

obsInfo = getObservationInfo(env);
obsDimensions = obsInfo.Dimension;

% create the network to be used as approximator in the critic
criticNetwork = [
    sequenceInputLayer([50 7 1],"Name","obs")
    fullyConnectedLayer(7,"Name","fc_1")
    reluLayer("Name","relu")
    fullyConnectedLayer(7,"Name","fc_2")];

opt = rlRepresentationOptions('LearnRate',5e-2,'GradientThreshold',1);
critic = rlValueRepresentation(criticNetwork,obsInfo,...
        'Observation',{'obs'},opt);

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
