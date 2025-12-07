%%% GGWR
clear;
tic;
[y,px,py,x]=ReadData('demoData.xlsx');
% [y,px,py,x]=ReadData('gdata_utm.csv');
p=size(x,2);

type=2;%default value
if type==1
    qmin=40+2*3*p;
    pentalyCoe=log(log(3*p));
else
    qmin=40+2*6*p;
    pentalyCoe=log(log(6*p));
end

qmax=length(px);

%1.search the optimal bandwidth
options=optimset('fminbnd');
options.Display='iter';
% options.TolX=1e-3;
band_width=fminbnd('get_AICc',qmin,qmax,options,px,py,x,y,pentalyCoe,type);

[R2,adj_R2,list_betas,AICc]=calcR2GWR(px,py,x,y,round(band_width),pentalyCoe,type);
% Plot the gradient field of the regression coefficients
subplot(1,3,1);
quiver(px,py,list_betas(:,2),list_betas(:,3));
subplot(1,3,2);
quiver(px,py,list_betas(:,8),list_betas(:,9));
subplot(1,3,3);
quiver(px,py,list_betas(:,14),list_betas(:,15));
ics=ICS(list_betas,type);
disp('GGWR finished!');
toc;

