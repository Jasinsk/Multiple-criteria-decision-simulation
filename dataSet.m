classdef dataSet
    
    properties
        set = []
        ansRight = [false, false, false, false, false, false, false]
        ansLeft = [false, false, false, false, false, false, false]
        defaultValues = []
        arraySet = []
    end
    
    methods
        function obj = dataSet(objectNum, criteriaNum)
            % We would like to add criteriaNum and randomness parameters
            % into this function
            
            % Dividing parameters into groups
            N = randperm(criteriaNum);

            obj.ansRight(N(1)) = true;
            obj.ansRight(N(2)) = true;
            obj.ansRight(N(3)) = true;
            
            obj.ansLeft(N(4)) = true;
            obj.ansLeft(N(5)) = true;
            obj.ansLeft(N(6)) = true;
            obj.ansLeft(N(7)) = true;
            
            % Generating default values for set
            defaultValues = randi(100, 1, 7);
            
            % Generating objects with these parameters
            for i = 1:objectNum
                newDataObject = dataObject(obj.ansRight, defaultValues);
                obj.set = [obj.set newDataObject];
                obj.arraySet = [obj.arraySet; newDataObject.criteriaValues];
            end
            
        end
    end
end


