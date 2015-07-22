% CSE 473/573 Programming Assignment 1, starter Matlab code
% Adapted from A. Efros
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)
% and R. Fergus
% http://cs.nyu.edu/~fergus/teaching/vision/assign1.pdf

% name of the input file
function [colorim] = part1(fullim)
imname = 'part1_6.jpg';

% read in the image
fullim = imread(imname);

% convert to double matrix 
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

B = B(31:end-30, 31:end-30);
G = G(31:end-30, 31:end-30);
R = R(31:end-30, 31:end-30);

IB=edge(B,'canny');
nB=zeros(size(B));
nB=IB;

IG=edge(G,'canny');
nG=zeros(size(G));
nG=IG;

IR=edge(R,'canny');
nR=zeros(size(R));
nR=IR;
% Align the images
% Functions that might be useful to you for aligning the images include: 
% "circshift", "sum"


aR = align(nR,nB);
R=circshift(R,aR);
aG = align(nG,nB);
G=circshift(G,aG);



% open figure
%% figure(1);

% create a color image (3D array)
% ... use the "cat" command
BGR = cat(3,R,G,B);
imshow(BGR);
% show the resulting image
% ... use the "imshow" command

% save result image
imwrite(BGR,'result-6.jpg');

end 
function [output] = align(img1, img2)

output = offset(img1, img2);
disp(output);

end


function [output] = offset(img1, img2)

min = inf;
for x = -15:15
    for y = -15:15 
        tmp = circshift(img1, [x y]);
        ssd = sum(sum((img2-tmp).^2));
        if ssd < min
            min = ssd;
            output = [x y];
            
        end
    end
end
end



