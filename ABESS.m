function finalBeta = ABESS(x,y,pentalyCoe,bw)
zeroPosition=(y==0);
temp=find(zeroPosition==1);
y(temp)=[];
x(temp,:)=[];
n=bw;

ux=mean(x);
sigmax=std(x);
uy=mean(y);
sigmay=std(y);
x=(x-ux)./sigmax;
y=(y-uy)./sigmay;


[~,p]=size(x);
Smax=min(floor(n/(log(p)*log(log(n)))),p);
SICtotal=zeros(Smax,1);
totalBeta=zeros(Smax,p);
for s=1:Smax
    [beta,~,As,~]=bess_fixed(y,x,s,n,p);
    totalBeta(s,:)=beta';
    SIC=n*log((y-x*beta)'*(y-x*beta)/(n-length(As)))+length(As)*log(n)*pentalyCoe;
    SICtotal(s)=SIC;
end

position=(SICtotal==min(SICtotal));
finalBeta=totalBeta(position,:);

for k1=1:size(x,2)
    finalBeta(k1)=finalBeta(k1)*sigmay/sigmax(k1);
end
finalBeta=finalBeta';
end
