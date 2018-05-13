function [new_data] = sortPoints(data)
mean_value = mean(data);

x = data(:,1)-mean_value(1);
y = data(:,2)-mean_value(2);
radial_data =  cart2pol(x,y);
[~,ind] = sort(radial_data);
new_data = data(ind,:);

%debug
%figure
%plot(new_data(:,1),new_data(:,2),'b');
%hold on
%plot(0,0,'ro');
end

