
%taken from the manual page for imwrite of a gif from MATLAB.
%takes a 1xN cell of frames and creates a gif out of them
function gifMaker( frames )
filename = 'myGif.gif'; % Specify the output file name

[x, numFrames] = size(frames); %finding number of frames
for n = 1:numFrames
      [img,colorMap] = gray2ind(frames{n},256); 
      if n == 1
          imwrite(img, colorMap ,filename,'gif', 'Loopcount',inf);
      else
          imwrite(img, colorMap ,filename,'gif','WriteMode','append');
      end
end

%displaying the gif using mov 
[X, map]= imread('myGif.gif', 'frames', 'all');
mov = immovie(X, map);
implay(mov)
end

