function AICc = get_AICc(bw,px,py,x,y,pentalyCoe,type)% aims to get the minimum AICc
[row_px,col_x]=size(x);
bw=round(bw);
list_influ=zeros(1,row_px);%freedom of matrix
list_resid=zeros(1,row_px);
onesMatrix=ones(row_px,1);
if type==1
    order=3;
else
    order=6;
end
distance_matrix=pdist2([px,py],[px,py],'euclidean');
temp_distance_matrix=sort(distance_matrix);
parfor k2=1:row_px
    u0=px(k2);
    v0=py(k2);
    if type==1
        newxMatrix=[onesMatrix (px-u0) (py-v0)];%first-order
    else
        newxMatrix=[onesMatrix (px-u0) (py-v0) (((px-u0)).^2)/2 (((py-v0)).^2)/2 (px-u0).*(py-v0)];%second order
    end
    newX=zeros(row_px,order*col_x);
    for k1=1:col_x
        newX(:,(k1-1)*order+1:k1*order)=x(:,k1).*newxMatrix;
    end
    temp=temp_distance_matrix(:,k2);% sorting of the distance
    bandWidth=temp(bw)*1.0000001;
    kernel=(1 - (distance_matrix(:,k2)/bandWidth).^2).^2;%kernel:bi-square
    kernel(distance_matrix(:,k2)>=bandWidth)=0;

    %kernel=exp(-1/2*((distance_matrix(:,k2)/bandWidth).^2));%kernel: truncation gauss
    %kernel(distance_matrix(:,k2)>=bandWidth)=0;
    
    %constructing the new x and new y.
    sqrtKernel=sqrt(kernel);
    Xnew=newX.*sqrtKernel;
    Ynew=y.*sqrtKernel;
    betas = ABESS(Xnew,Ynew,pentalyCoe,bw);%ABESS
    tempbeta=betas';
    position=(tempbeta~=0);
    xxx=Xnew(:,position);
    xtx_inv_xt=(xxx'*xxx)\xxx';
    %xtx_inv_xt=pinv(xxx'*xxx)*xxx';
    list_influ(k2)=xxx(k2,:)*xtx_inv_xt(:,k2);%hat matrix
    predy=newX(k2,:)*betas;
    list_resid(k2) =y(k2,:) - predy;
end
tr_S=sum(list_influ);
SSE=list_resid*list_resid';
sigma_hat=sqrt(SSE/row_px);
AICc=2*row_px*log(sigma_hat)+row_px*log(2*pi)+row_px*((row_px+tr_S)/(row_px-2-tr_S));
end
