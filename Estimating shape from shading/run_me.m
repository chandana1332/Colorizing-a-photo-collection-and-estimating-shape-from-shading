% CSE 473/573 Programming Assignment 1, starter Matlab code
%% Credits: Arun Mallya and Svetlana Lazebnik

% path to the folder and subfolder
root_path = 'croppedyale/';
subject_name = 'yaleB01';

save_flag = 0; % whether to save output images

%% load images
full_path = sprintf('%s%s/', root_path, subject_name);
[ambient_image, imarray, light_dirs] = LoadFaceImages(full_path, subject_name, 64);
image_size = size(ambient_image);


%% preprocess the data: 

%% subtract ambient_image from each image in imarray
%% make sure no pixel is less than zero
for i=1:64
    imarray(:,:,i)=imarray(:,:,i)-ambient_image;
end
%% rescale values in imarray to be between 0 and 1
imarray(imarray<0)=0;
%% <<< fill in your preprocessing code here (if any) >>>
imarray=imarray/255;
%% get albedo and surface normals (you need to fill in photometric_stereo)
[albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs);

%% reconstruct height map (you need to fill in get_surface for different integration methods)
height_map = get_surface(surface_normals, image_size);

%% display albedo and surface
display_output(albedo_image, height_map);

%% plot surface normal
plot_surface_normals(surface_normals);

%% save output (optional) -- note that negative values in the normal images will not save correctly!
if save_flag
    imwrite(albedo_image, sprintf('%s_albedo.jpg', subject_name), 'jpg');
    imwrite(surface_normals, sprintf('%s_normals_color.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,1), sprintf('%s_normals_x.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,2), sprintf('%s_normals_y.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,3), sprintf('%s_normals_z.jpg', subject_name), 'jpg');    
end

