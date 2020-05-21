classdef dataObject

   properties
      criteriaValues = [];
   end

   methods
        function obj = dataObject(chosenCriteria)

            % generate controlled random criteria values
            for i = 1:7
               if chosenCriteria(i) == true
                   criteriaValues(i) = 1;
               else 
                   criteriaValues(i) = 0;
               end
            end
            
            criteriaValues
        end
    end
end