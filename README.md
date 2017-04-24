In this project I designed an algorithm to perform non-rigid transformations of an image. I take a stationary image and map it to a moving image where I can then perform transforms on the stationary image to model the moving image. I prove that going forward with the non-rigid transformation can be reverted to a nearly identical inverse image through my inverse transform function. 

In the second part of my project, I perform 10 frames of non-rigid transformations creating several gifs of my face moving rigidly. 

To execute the function run the main.m script and select the landmarks for both images. In the supplied code, the landmarks have been hardcoded in with the values used in the report, to test your own landmark values uncomment the 3 lines of “cpselect” commands in the main.m file, and comment out the hardcoded values for p0, p1, p2, q0, q1, q2.

Further details can be found in the pdf report.
