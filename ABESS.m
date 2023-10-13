function finalBeta = ABESS(x,y,pentalyCoe,bw)
zeroPosition=(y==0);
temp=find(zeroPosition==1);
y(temp)=[];
x(temp,:)=[];
n=bw;
[~,p]=size(x);
Smax=min(floor(n/(log(p)*log(log(n)))),p);
SICtotal=zeros(Smax,1);
totalBeta=zeros(Smax,p);
for s=1:Smax
    [beta,~,As,~]=bess_fixed(y,x,s,n,p);
    totalBeta(s,:)=beta';
    SIC=n*log((y-x*beta)'*(y-x*beta)/(n-length(As)))+length(As)*log(n)*pentalyCoe;%BIC0Ö¸±ê
    SICtotal(s)=SIC;
end
position=(SICtotal==min(SICtotal));
finalBeta=totalBeta(position,:);
end