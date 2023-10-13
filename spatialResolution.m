function sR = spatialResolution(px,py)
TRI=delaunay(px,py);%delaunay
[disMatrix,~]=DistanceMatrix(TRI,px,py);
sR=min(disMatrix(disMatrix>0));
end

