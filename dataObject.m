classdef dataObject

   properties
      criteriaValues = [];
   end

   methods
        function obj = dataObject(chosenCriteria, defaultValues)
            mean = 1;
            sigma = 0.1;

            % put ones and zeros as left and right
            obj.criteriaValues = chosenCriteria;
            
            % generating values with randomized trends
%             rightMultiplier = rand + 0.5; %these will have to be changes to give these trends different characteristics
%             leftMultiplier = rand + 0.5;
%             
%             for i = 1:7
%                 if chosenCriteria(i) == 1
%                     obj.criteriaValues(i) = defaultValues(i) * (rightMultiplier * normrnd(mean,sigma));
%                 else
%                     obj.criteriaValues(i) = defaultValues(i) * (leftMultiplier * normrnd(mean,sigma));
%                 end
%             end
        end
    end
end