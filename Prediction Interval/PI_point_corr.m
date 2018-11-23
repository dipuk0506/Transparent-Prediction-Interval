% Function for finding PI of 1 sample
% Returns Strength, Meadian of probability density (point prediction), PI (2 by 1 matrix)

% Inputs are Test signal=long string  
% Prediction point = PI for the point needs to be determined using previous values
% Search length = length over which similarities are searched
% n = length of correlation sample (closest 10 to 30 samples)
% Percent = how much weight we need to cover (95%)


function [Strength, Median_bar, PI] = PI_point_corr(test_signal, prediction_point,search_length,n, percent)
[result_corr,ratio_factor] = norm_corr_mn(test_signal(1:prediction_point), search_length, n);
%corrrelating over length and finding nornalized correlation values and the
%ratio of the signal 

best_match_threshold=0.5;
% If correlation value is smaller than threshold, the point will not be considered 

best_match_count=300;
% "best match count" number of samples will be considered in case of too
% many high correlation values

[max_value,max_point] = get_max_value_point(result_corr,best_match_count,best_match_threshold);
% getting top correlation values and corresponding point number


for iter=1:length(max_value)
    forecast_point(iter)=test_signal(prediction_point-max_point(iter))*ratio_factor(max_point(iter));
% Getting max point and multiplying it with the ratio to receive a
% predictive value
    prediction_weight(iter)=(max_value(iter)^5)*2/(ratio_factor(max_point(iter))+1/ratio_factor(max_point(iter)));
% Weight of the point (How relevent the point is)
% Weight = corr_value* 2/(r+1/r)
end

bar_number=200;
% Making a bar distribution by dividing the range
[boundaries,bar_out]=bar_forecast_prediction(forecast_point,prediction_weight,bar_number);
% Finding distribution as bar chart values and bar boundaries



[Median_bar, PI]=M_PI_CI(boundaries,bar_out,percent); 
% Finding median and PI from bar-chart
%Region covering 95 percent of history (if the last value is 0.95)


Strength = sum(prediction_weight)/best_match_count;

end