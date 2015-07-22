function  height_map = get_surface(surface_normals, image_size)
% surface_normals: h x w x 3 array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object of dimensions [h, w]


[h,w,n]=size(surface_normals);
height_map=zeros(h,w);

    
%% <<< fill in your code below >>> 
for i=2:h
    q=surface_normals(i,1,2)/surface_normals(i,1,3);
    height_map(i,1)=height_map(i-1,1)+q;
    
end

for i=1:h
    for j=2:w
    p=surface_normals(i,j,1)/surface_normals(i,j,3);
    height_map(i,j)=height_map(i,j-1)+p;
    end
end    
end

