%takes in p which is a nx2 array of template (stationary img) landmarks
%takes in q which is a nx2 array of target (moving img) landmarks
%takes in x which is a 2x1 array where the (1,1) element is the x
%sigma the desired standard deviation for the non-rigid transform

%returns the x and y coordinate of the non-rigid transformation
function ux = displacementVector(p, q, x, sigma)
[N, colLength ] = size(p); % read in N samples of landmarks
diff = x - p; % holds a nx2 array containing the difference between the x coordinate and the p landmark coordinates
magnitude = p(:,1); %temporarily initialize magniutde vector to be of the same length as N
alpha = p(:,1); %temporarily initialize alpha vector to be of the same length as N

%for every pixel's coordiante, we calculate the exponential factor which
%will be used to scale  the N landmarks 
for i = 1: N 
    magnitude(i,1) = diff(i,1)^2 + diff(i,2)^2;
    alpha(i,1) = exp(-magnitude(i,1)/(2*sigma^2));
end

qpDiff = q -p; % a Nx2 array containing the differences between each of the q and p landmarks x and y coordinates
uxArr = alpha.*qpDiff; % a Nx2 array where each difference landmark is scaled by it's corresponding alpha factor
ux = sum(uxArr); % Holds a 2x1 array, with the x and y coordinates of the displacement. The displacement of point x is the summation of the Nx2 array, 

end

