%%% GGWR
clear;
tic;
[y,px,py,x]=ReadData('demoData.xlsx');
sR=spatialResolution(px,py);
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
options.TolX=1e-2;
band_width=fminbnd('get_AICc',qmin,qmax,options,px,py,x,y,pentalyCoe,type,sR);

[R2,adj_R2,list_betas,AICc]=calcR2GWR(px,py,x,y,round(band_width),pentalyCoe,type,sR);
ics=ICS(list_betas,type);
disp('GGWR finished!');
toc;