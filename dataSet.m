classdef dataSet
    
    properties
        set = []
        ansRight = []
        ansLeft = []
        ans = [false, false, false, false, false, false, false]
        arraySet = []
    end
    
    methods
        function obj = dataSet(objectNum, criteriaNum)
            % We would like to add criteriaNum and randomness parameters
            % into this function
            
            % Dividing parameters into groups
            N = randperm(criteriaNum);
            obj.ansRight = [N(1), N(2), N(3)];
            obj.ansLeft = [N(4), N(5), N(6), N(7)];
            
            obj.ans(N(1)) = true;
            obj.ans(N(2)) = true;
            obj.ans(N(3)) = true;
            
            % Generating objects with these parameters
            for i = 1:1:objectNum
                newDataObject = dataObject(obj.ans);
                obj.set = [obj.set newDataObject];
                obj.arraySet = [obj.arraySet; newDataObject.criteriaValues];
            end
            
        end
    end
end


