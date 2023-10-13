function [beta_result,d_result,A_result,I_result] = bess_fixed(y,x,s,n,p)
kmax=s;
ts=0.01*s*log(p)*log(log(n))/n;
rho =abs(corr(y,x,'type','Pearson'));
[~,location]=sort(rho,'descend');
A_initial=location(:,1:s);
I_initial=location(:,s+1:end);
tempx_initial=x(:,A_initial);
xtx_initial=pinv(tempx_initial'*tempx_initial)*(tempx_initial');
% xtx_initial=(tempx_initial'*tempx_initial)\(tempx_initial');
BetaA=xtx_initial*y;
betaInitial=zeros(p,1);
betaInitial(A_initial)=BetaA;
dInitial=zeros(p,1);
inactiveD=x(:,I_initial)'*(y-x*betaInitial)/n;
dInitial(I_initial)=inactiveD;
iterations=100;
for k1=1:iterations
    [betaT,dT,activeA,inactiveI]=splicing(betaInitial,dInitial,A_initial,I_initial,kmax,ts,n,p,y,x);
    if isequal(activeA,A_initial)&&isequal(inactiveI,I_initial)
        beta_result=betaT;
        d_result=dT;
        A_result=activeA;
        I_result=inactiveI;
        break;
    end
    betaInitial=betaT;
    dInitial=dT;
    A_initial=activeA;
    I_initial=inactiveI;
end
end