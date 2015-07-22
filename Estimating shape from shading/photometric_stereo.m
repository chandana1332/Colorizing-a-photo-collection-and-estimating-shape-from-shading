function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs)
% imarray: h x w x Nimages array of Nimages no. of images
% light_dirs: Nimages x 3 array of light source directions
% albedo_image: h x w image
% surface_normals: h x w x 3 array of unit surface normals


%% <<< fill in your code below >>>
[h,w,n]=size(imarray);
albedo_image=zeros(h,w);
g=zeros(h,w,3);
surface_normals=zeros(h,w,3);

for i= 1:h
    for j=1:w
        I=reshape(imarray(i,j,:),n,1);
        g(i,j,:) = mldivide(light_dirs,I);
        albedo_image(i,j)=sqrt((g(i,j,1))^2+(g(i,j,2))^2+(g(i,j,3))^2);
        surface_normals(i,j,:)=g(i,j,:)/albedo_image(i,j);
    end
end

        
        
    
end


