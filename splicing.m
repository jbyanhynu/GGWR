function [betaF,ddF,actA,inactI] = splicing(betaIni,dIni,A,I,kmax,ts,n,p,y,x)
L=1/(2*n)*norm((y-x*betaIni),2)^2; 
Lo=L;%norm((y-x*betaIni),2)^2
deltaActive=zeros(1,p);
deltaInactive=zeros(1,p);
tempComp=(y-x*betaIni)/n;
for k1=1:p
    operator=x(:,k1)'*x(:,k1)/(2*n);
    deltaActive(k1)=operator*betaIni(k1)^2;
    tempK=x(:,k1)'*tempComp;
    deltaInactive(k1)=operator*(tempK/(operator*2))^2;
end

for k2=1:kmax
    if (length(A)>=k2)&&(length(I)>=k2)
        tempMatrix=deltaActive(A);
        [~,loc]=sort(tempMatrix);
        A_temp=A(loc(1:k2));
        tempMatrix=deltaInactive(I);
        [~,loc]=sort(tempMatrix,'descend');
        I_temp=I(loc(1:k2));
        Ak=union(setdiff(A,A_temp),I_temp);
        Ik=union(setdiff(I,I_temp),A_temp);
        x_temp=x(:,Ak);
        %xtx_inv_xt=(x_temp'*x_temp)\(x_temp');
        xtx_inv_xt=pinv(x_temp'*x_temp)*(x_temp');
        betaAk=xtx_inv_xt*y;
        beta=zeros(p,1);
        beta(Ak)=betaAk;
        d_temp=x'*(y-x*beta)/n;
        residual=(1/(2*n))*norm((y-x*beta),2)^2;
        if L>residual
            L=residual;
            betaF=beta;
            ddF=d_temp;
            actA=Ak;
            inactI=Ik;
        end
    else
        break;
    end
end
if (Lo-L)<=ts
    betaF=betaIni;
    ddF=dIni;
    actA=A;
    inactI=I;
end
end