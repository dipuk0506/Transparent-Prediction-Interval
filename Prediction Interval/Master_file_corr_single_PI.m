clc
clear all
clf

% 1.	Loading signal
[test_signal,sampling_frequency]=loading_signal;
prediction_point=2401;
corr_length=30;
search_length=2000;
% 2.	Correlation of recent samples over certain length
[result_corr,ratio_factor] = norm_corr_mn(test_signal(1:prediction_point), search_length, corr_length);

%%%%%%%%%%%%%%%%%%%%%%% Observe
figure(1)
clf
plot(test_signal(prediction_point-2000:prediction_point))
figure(2)
clf
plot(result_corr)
hold on
plot(ratio_factor,'g')
%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3.	Finding highest correlation values (up to certain number or higher than certain threshold, whichever is lower)
best_match_count=300;
[max_value,max_point] = get_max_value_point(result_corr,best_match_count,0.5);

% 4.	Normalizing the signal with ratio and calculating the prediction weight 
for iter=1:length(max_point)
forecast_point(iter)=test_signal(prediction_point-max_point(iter))*ratio_factor(max_point(iter));
prediction_weight(iter)= (max_value(iter)^5)*2/(ratio_factor(max_point(iter))+(1/ratio_factor(max_point(iter))));
end


%%%%%%%%%%%%%%%%%%%%%%% Observe
figure(3)
clf
plot(forecast_point)
hold on
plot(max_value,'g')
value=test_signal(prediction_point)
%%%%%%%%%%%%%%%%%%%%%%%

% 5.	Drawing bar chart
bar_number=50;
[boundaries,bar_out]=bar_forecast_prediction(forecast_point,prediction_weight,bar_number);

%%%%%%%%%%%%%%%%%%%%%%% Observe
figure(4)
bar((boundaries(1:end-1)+boundaries(2:end))/2,bar_out);
%%%%%%%%%%%%%%%%%%%%%%%


% 6.	Discarding less relevant regions from corners.
[Median_bar, Prediction_interval]=M_PI_CI(boundaries,bar_out,.95)

% 7.	Calculating the prediction strength.
Prediction_Strength = sum(prediction_weight)/best_match_count
