% This function is sending Median value and PI

% Taking input- Bar boundaries and bar values
% Percent amount of total weight interval will be PI

function [Median_bar, Prediction_interval]= M_PI_CI(boundaries,bar_out, percent)
sum_bar=0;
median_point=0;
for iter=1:length(bar_out)
    sum_bar=sum_bar+bar_out(iter);
    if sum_bar>.5
       Median_bar=(boundaries(iter)+boundaries(iter+1))/2;
       median_point=iter;
       break;
    end
end

initial_point=1;
end_point=length(bar_out);

for iter=1:length(bar_out)
    if median_point> (initial_point+end_point)/2
        if sum(bar_out(initial_point+1:end_point))>=percent
            initial_point=initial_point+1;
        else
            if sum(bar_out(initial_point:end_point-1))>=percent
                end_point=end_point-1;
            else
                break;
            end
        end
    else 
        if sum(bar_out(initial_point:end_point-1))>=percent
            end_point=end_point-1;
        else
            if sum(bar_out(initial_point+1:end_point))>=percent
                initial_point=initial_point+1;
            else
                break;
            end
        end
    end
%accuracy= sum(bar_out(initial_point:end_point))
end
Prediction_interval=[boundaries(initial_point) boundaries(end_point)];
end