clc
clear all

% 1.	Loading signal
[test_signal,sampling_frequency]=loading_signal;
%prediction_point=2404;

% 2.	Initialization

% for entire picture start= 4000 and end= 24000.. simulation takes 5 to 30 minutes
prediction_start=19000;
prediction_end=19500;
search_length=2000;
corr_length=20;
index_PI=1;
original_value=zeros(1,prediction_end-prediction_start+1);
low_PI=zeros(1,prediction_end-prediction_start+1);
high_PI=zeros(1,prediction_end-prediction_start+1);
Prediction_median=zeros(1,prediction_end-prediction_start+1);
Strength_PI=zeros(1,prediction_end-prediction_start+1);
PI_success = 0;
percent = 0.95;%discarding irrelevent values from corners

% 3.	Calling Point Correlation function in a loop 
tic
%Finding PI and original sample and counting total time
for prediction_point=prediction_start:prediction_end
    [Strength_PI(index_PI), Prediction_median(index_PI), PI2] = PI_point_corr(test_signal, prediction_point,search_length,corr_length,percent);
    low_PI(index_PI)=PI2(1);
    high_PI(index_PI)=PI2(2);
    original_value(index_PI) = test_signal(prediction_point);
    index_PI=index_PI+1;
end
toc

% 4.	Plotting Signals
figure(2)
clf
plot(low_PI)
hold on
plot(high_PI)
hold on
plot(original_value,'g')
%hold on
%plot(Prediction_median,'k')
hold on
plot(Strength_PI,'r')

% 5.	Finding PI Coverage
j=0;
for i=1:length(original_value)
    if original_value(i)>low_PI(i) && original_value(i)<high_PI(i)  
            j=j+1;
    end
end
PI_Coverage = j/length(original_value)
