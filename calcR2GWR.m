function [R2,adj_R2,list_betas,AICc] = calcR2GWR(px,py,x,y,bw,pentalyCoe,type,sR)
if type==1
    order=3;
else
    order=6;
end
[row_px,col_x]=size(x);
list_influ=zeros(1,row_px);
list_betas=zeros(row_px,col_x*order);
list_resid=zeros(row_px,1);
onesMatrix=ones(row_px,1);
distance_matrix=pdist2([px,py],[px,py],'euclidean');
distance_matrix=distance_matrix/sR;
temp_distance_matrix=sort(distance_matrix);
parfor k2=1:row_px
    %distance_matrix=pdist2([px,py],[px(k2),py(k2)],'euclidean');
    u0=px(k2);
    v0=py(k2);
    if type==1
        newxMatrix=[onesMatrix (px-u0)/sR (py-v0)/sR];%first-order
    else
        newxMatrix=[onesMatrix (px-u0)/sR (py-v0)/sR (((px-u0)/sR).^2)/2 (((py-v0)/sR).^2)/2 (px-u0)/sR.*(py-v0)/sR];%second order
    end
    newX=zeros(row_px,order*col_x);
    for k1=1:col_x
        newX(:,(k1-1)*order+1:k1*order)=x(:,k1).*newxMatrix;
        %newX=[newX,x(:,k1).*newxMatrix];
    end
    temp=temp_distance_matrix(:,k2);
    %temp_distance_matrix=sort(distance_matrix);
    bandWidth=temp(bw)*1.0000001;
    kernel=(1 - (distance_matrix(:,k2)/bandWidth).^2).^2;%bi-square
    kernel(distance_matrix(:,k2)>=bandWidth)=0;

    %kernel=exp(-1/2*((distance_matrix(:,k2)/bandWidth).^2));%kernel: truncation gauss
    %kernel(distance_matrix(:,k2)>=bandWidth)=0;

    sqrtKernel=sqrt(kernel);
    Xw=newX.*sqrtKernel;
    Yw=y.*sqrtKernel;
    betas = ABESS(Xw,Yw,pentalyCoe,bw);
    tempbeta=betas';
    position=(tempbeta~=0);
    xxx=Xw(:,position);
    xtx_inv_xt=(xxx'*xxx)\xxx';
    list_influ(k2)=xxx(k2,:)*xtx_inv_xt(:,k2);
    list_betas(k2,:)=betas;
    predy=newX(k2,:)*betas';
    list_resid(k2)=y(k2,:) - predy;
end
tr_S=sum(list_influ);
SSE=list_resid'*list_resid;
SST=(y-mean(y))'*(y-mean(y));
R2=1-SSE/SST;
adj_R2=1 - (1 - R2) * ((row_px) - 1) / ((row_px) - tr_S - 1);
sigma_hat=sqrt(SSE/row_px);
AICc=2*row_px*log(sigma_hat)+row_px*log(2*pi)+row_px*((row_px+tr_S)/(row_px-2-tr_S));

for k1=1:row_px
    for k2=1:col_x
        if list_betas(k1,(k2-1)*order+1)==0
            list_betas(k1,(k2-1)*order+1:k2*order)=zeros(1,order);
        end
    end
end
end

