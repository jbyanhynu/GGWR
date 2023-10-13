function ics = ICS(betas,type)
%ICS is primarily used to evaluate the level of consistency --
% in the signs of regression coefficients within a model.
[~,n]=size(betas);
if type==1
    tt=betas(:,1:3:n);
else
    tt=betas(:,1:6:n);
end
[numberSample,colx]=size(tt);
positiveNumber=sum(tt>0)/numberSample*100;%the number of positive
zeroNumber=sum(tt==0)/numberSample*100;%the number of zero
negativeNumber=sum(tt<0)/numberSample*100;%the number of negative
ics=sum(abs(positiveNumber-negativeNumber)+zeroNumber)/colx;
end

