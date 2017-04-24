%performs non-rigid transform on an image given p landmarks, q landmarks,
%an image, a standard deviation, T # of frames and a specified stepsize for
%each frame.
function [xArr, yArr,frames] = nonRigidTransform( img, landmarkP, landmarkQ, sigma, T, stepSize)

[imgRowLength, imgColLength ] = size(img); % read in n samples
outputImg = zeros(size(img)); %initialize outputImg to be of same size as the input img
xArr = zeros(size(img));
yArr = zeros(size(img));

for p = 1:T %perform for T frames
    deltaT = stepSize*p;
    for i = 1:imgColLength
        for j = 1: imgRowLength
            x = [i j]; % the 2x1 representation of the pixel's x and y coordinates
            ux = displacementVector(landmarkP, landmarkQ, x, sigma); %phi will hold the x and y coordinates of the non-rigid transform
            phi_x =   x(1,1) + deltaT*ux(1,1)/T; % x coordinate of the phi function
            phi_y =   x(1,2) + deltaT*ux(1,2)/T ; % y coordinate of the phi function
            outputImg(j,i) = bilinearInterpolation(phi_x, phi_y, img); %interpolates based on the returned x and y coordiantes 
            xArr(j,i) = ux(1,1); %stores all the x components of displacement vector into x-array
            yArr(j,i) = ux(1,2); %stores all the y components of displacement vector into y-array

        end
    end
    
    frames(p) = {outputImg}; %save into frames cell, which will hold each output frame 
end


end

