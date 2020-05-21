classdef dataObject

   properties
      criteriaValues = [];
   end

   methods
        function obj = dataObject(chosenCriteria)

            % generate controlled random criteria values
            for i = 1:7
               if chosenCriteria(i) == true
                   obj.criteriaValues(i) = 1;
               else 
                   obj.criteriaValues(i) = 0;
               end
            end
        end
    end
end