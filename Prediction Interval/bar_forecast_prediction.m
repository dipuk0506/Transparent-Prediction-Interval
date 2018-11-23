% Returning normalized bar chart values
% Bars are evaluated using forecast values and weight
% Steps = number of bars

function [boundaries,bar_out]=bar_forecast_prediction(forecast_point,prediction_weight, steps)
max_limit=max(forecast_point);
min_limit=min(forecast_point);
bar_out=zeros(1,steps);
boundaries=linspace(min_limit, max_limit, steps+1);
for iter=1:length(prediction_weight)
    if forecast_point(iter)== max_limit
         bar_out(steps)= bar_out(steps)+prediction_weight(iter);   
    end
    for iter2=1:steps
        if forecast_point(iter)>= boundaries(iter2) && forecast_point(iter)< boundaries(iter2+1)
            bar_out(iter2)= bar_out(iter2)+prediction_weight(iter);
            break;
        end
    end
end
bar_out=bar_out/sum(bar_out);
end