classdef dataObject

   properties
      criteriaValues = [];
   end

   methods
        function obj = dataObject(chosenCriteria, defaultValues, difLevel)
            mean = 1;
            sigma = 0.1;

            % put ones and zeros as left and right
            if difLevel == 1

                obj.criteriaValues = chosenCriteria;
            
            % puts default values as right and zeros as left
            elseif difLevel == 2

                for i = 1:7
                    if chosenCriteria(i) == 1
                        obj.criteriaValues(i) = defaultValues(i);
                    else
                        obj.criteriaValues(i) = 0;
                    end
                end
                
            % puts randomized trends as right and zeros as left
            elseif difLevel == 3
                rightMultiplier = rand + 0.5;

                for i = 1:7
                    if chosenCriteria(i) == 1
                        obj.criteriaValues(i) = defaultValues(i) * (rightMultiplier * normrnd(mean,sigma));
                    else
                        obj.criteriaValues(i) = 0;
                    end
                end
            
            % generating values with randomized trends on right and default
            % values on left
            elseif difLevel == 4
                rightMultiplier = rand + 0.5; 

                for i = 1:7
                    if chosenCriteria(i) == 1
                        obj.criteriaValues(i) = defaultValues(i) * (rightMultiplier * normrnd(mean,sigma));
                    else
                        obj.criteriaValues(i) = defaultValues(i);
                    end
                end
                
            % generating values with randomized trends on right and
            % minimized trends on left
            elseif difLevel == 5
                rightMultiplier = rand + 0.5; %these will have to be changes to give these trends different characteristics
                leftMultiplier = (rand + 0.5) * 0.05;

                for i = 1:7
                    if chosenCriteria(i) == 1
                        obj.criteriaValues(i) = defaultValues(i) * (rightMultiplier * normrnd(mean,sigma));
                    else
                        obj.criteriaValues(i) = defaultValues(i) * (leftMultiplier * normrnd(mean,sigma));;
                    end
                end
            
            % generating values with randomized trends on both right and
            % left
            elseif difLevel == 6
                rightMultiplier = rand + 0.5; %these will have to be changes to give these trends different characteristics
                leftMultiplier = rand + 0.5;

                for i = 1:7
                    if chosenCriteria(i) == 1
                        obj.criteriaValues(i) = defaultValues(i) * (rightMultiplier * normrnd(mean,sigma));
                    else
                        obj.criteriaValues(i) = defaultValues(i) * (leftMultiplier * normrnd(mean,sigma));
                    end
                end
            end
        end
    end
end