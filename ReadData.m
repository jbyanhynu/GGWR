function [y,px,py,x] = ReadData(path)
data=xlsread(path,1); %#ok<XLSRD> 
y=data(:,1);% dependent variable 
px=data(:,2);% x-axis coordinates

py=data(:,3);% y-axiscoordinates
delta=max(max(px)-min(px),max(py)-min(py));%
px=(px-min(px))./delta;
py=(py-min(py))./delta;
x=data(:,4:6);%independent variables
% y=(y-mean(y))./std(y);
%% Variable standardization
% intercept=ones(length(px),1);
% xx=(x-mean(x))./std(x);
% x=[intercept,xx];

end
