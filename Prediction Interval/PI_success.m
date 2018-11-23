j=0;
for i=1:length(original_value)
    if original_value(i)>low_PI(i) && original_value(i)<high_PI(i)  
            j=j+1;
    end
end
j/length(original_value)