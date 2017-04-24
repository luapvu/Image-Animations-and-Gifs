%*******************************************


%disclaimer: This script takes about ~1 minute to run since I am making 3
%gifs each with 10 frames.


%*******************************************

close all;

addpath(genpath('../Images'));
addpath(genpath('functions'));

%load in all the images
originalImg = readImg('../Images/original.jpg');
smileImg = readImg('../Images/smile.jpg');

% ask user to select landmarks
%[p0,q0] = cpselect(originalImg, smileImg, 'wait', true);
%[p1,q1] = cpselect(originalImg, smileImg, 'wait', true);
%[p2,q2] = cpselect(originalImg, smileImg, 'wait', true);  

p0 =[245.375000000000,360.375000000000;365.875000000000,357.875000000000;305.375000000000,380.875000000000;307.375000000000,410.875000000000];
q0 = [234.375000000000,362.625000000000;374.875000000000,354.625000000000;301.875000000000,369.625000000000;301.375000000000,387.625000000000];

p1 = [254.875000000000,304.875000000000;348.375000000000,301.375000000000];
q1 = [237.375000000000,362.375000000000;370.875000000000,354.375000000000];

p2 = [192.875000000000,261.625000000000;400.375000000000,256.125000000000];
q2 = [237.875000000000,360.625000000000;371.875000000000,353.625000000000];


[ux1, uy1, lowSigmaImg] = nonRigidTransform(originalImg, p0, q0, 5 ,1,1); %performing a non-rigid transform with a small standard deviation
[ux2, uy2, highSigmaImg] = nonRigidTransform(originalImg, p0, q0, 60 ,1,1); %performing a non-rigid transform with a large standard deviation
[ux3, uy3, reasonableSigmaImg] = nonRigidTransform(originalImg, p0, q0, 20.5 ,1,1); %performing a non-rigid transform with an optimal standard deviation
[x, y, iTransform] = invTransform( reasonableSigmaImg{1}, p0, q0, 20.5, 1, 1); % using the output of the previous transform as the input of the inverse transform
differenceImg = iTransform{1} - originalImg; %subtracting the inverse transform's output with the original image to see how accurate our inverse transform is

[ux4, ux4, frames1]= nonRigidTransform(originalImg, p0, q0, 20.5, 10, 1); % creating animation 1 with a smile
[ux5, ux5, frames2]= nonRigidTransform(originalImg, p1, q1, 20.5, 10, 1); % creating animation 2 with squinted eyes
[ux6, ux6, frames3]= nonRigidTransform(originalImg, p2, q2, 20.5, 10, 1); % creating animation 3 with a squinted nose

figure %displaying results of varying sigmas
subplot(1,3,1); printImg(lowSigmaImg{1}, 'Low sigma: s = 5');
subplot(1,3,2); printImg(highSigmaImg{1}, 'High sigma: s = 60');
subplot(1,3,3); printImg(reasonableSigmaImg{1}, 'Reasonable sigma: s = 20.5');


figure %displaying results of non-rigid transform with vector field of u(x)
subplot(1,3,1); printImg(originalImg, 'Input Original Img');
subplot(1,3,2); printImg(reasonableSigmaImg{1}, 'Output Transformed Img');
subplot(1,3,3); quiver(ux3, uy3);
title('u(x) vector field '); % Attaches specified title to the image


figure %displaying results of inverse Transform 
subplot(1,4,1); printImg(reasonableSigmaImg{1}, 'Input Transformed Img');
subplot(1,4,2); printImg(iTransform{1}, 'Output Approx Original Img');
subplot(1,4,3); printImg(originalImg, 'Actual Original Img');
subplot(1,4,4); printImg(differenceImg, 'Difference between Inverse and Actual');

figure %displaying results of unnatural nose
subplot(1,3,1); printImg(originalImg, 'Original Selfie');
subplot(1,3,2); printImg(smileImg, 'Smile Selfie');
subplot(1,3,3); printImg(frames2{10}, '1st Unnatural Nose Selfie');

figure %displaying results of unnatural eyes
subplot(1,3,1); printImg(originalImg, 'Original Selfie');
subplot(1,3,2); printImg(smileImg, 'Smile Selfie');
subplot(1,3,3); printImg(frames3{10}, '2nd Unnatural Eyes Selfie');

gifMaker(frames1);  %gif of animated smile
gifMaker(frames2);  %gif of animated eye squint
gifMaker(frames3);  %gif of animated nose squint
  
  
