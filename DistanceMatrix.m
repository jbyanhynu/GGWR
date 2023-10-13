function [disMatrix,adjacentMatrix] = DistanceMatrix( TRI,px,py )
[m,~]=size(TRI);
disMatrix=zeros(length(px),length(px));
adjacentMatrix=zeros(length(px),length(py));
for i=1:m
    if disMatrix(TRI(i,1),TRI(i,2))==0&&disMatrix(TRI(i,2),TRI(i,1))==0
        if TRI(i,1)<TRI(i,2)
            disMatrix(TRI(i,1),TRI(i,2))=sqrt((px(TRI(i,1))-px(TRI(i,2)))^2+(py(TRI(i,1))-py(TRI(i,2)))^2);%计算两点之间的欧氏距离
            adjacentMatrix(TRI(i,1),TRI(i,2))=1;
        else
            disMatrix(TRI(i,2),TRI(i,1))=sqrt((px(TRI(i,1))-px(TRI(i,2)))^2+(py(TRI(i,1))-py(TRI(i,2)))^2);%计算两点之间的欧氏距离
            adjacentMatrix(TRI(i,2),TRI(i,1))=1;
        end
    end
    
    if disMatrix(TRI(i,1),TRI(i,3))==0&&disMatrix(TRI(i,3),TRI(i,1))==0
        if TRI(i,1)<TRI(i,3)
            disMatrix(TRI(i,1),TRI(i,3))=sqrt((px(TRI(i,1))-px(TRI(i,3)))^2+(py(TRI(i,1))-py(TRI(i,3)))^2);
            adjacentMatrix(TRI(i,1),TRI(i,3))=1;
        else
            disMatrix(TRI(i,3),TRI(i,1))=sqrt((px(TRI(i,1))-px(TRI(i,3)))^2+(py(TRI(i,1))-py(TRI(i,3)))^2);
            adjacentMatrix(TRI(i,3),TRI(i,1))=1;
        end
    end
    if disMatrix(TRI(i,2),TRI(i,3))==0&&disMatrix(TRI(i,3),TRI(i,2))==0
        if TRI(i,2)<TRI(i,3)
             disMatrix(TRI(i,2),TRI(i,3))=sqrt((px(TRI(i,2))-px(TRI(i,3)))^2+(py(TRI(i,2))-py(TRI(i,3)))^2);
             adjacentMatrix(TRI(i,2),TRI(i,3))=1;
        else
            disMatrix(TRI(i,3),TRI(i,2))=sqrt((px(TRI(i,2))-px(TRI(i,3)))^2+(py(TRI(i,2))-py(TRI(i,3)))^2);
            adjacentMatrix(TRI(i,3),TRI(i,2))=1;
        end
    end 
end
end

