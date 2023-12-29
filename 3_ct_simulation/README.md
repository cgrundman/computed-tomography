# CT Simulation

This folder contains files implementing a CT Simulation.

## Description of task

### Start Point

1) ct_simulation.m is the main file and the starting point. All of the other files are functions that are referenced. This is an 8-part file that walks through the building of a CT Scanner simulation.

### Simulate the CT Scanner

These functions create the initial Sinogram. This is an image in Radon Space. The subsequent funtions after these are all involved in reconstruction of the image back to real space.

2) simulation.m is a function file that compiles all views and outputs sinogram of the patient's cross section. This file calls view.m to create the sinogram.

3) view.m is a function file that compiles line integrals for a single column of the sinogram. This file calls tube_position_xy.m, detector_position_xy, and line_integral_xy.m.

### Create vector of attenuation values

4) line_integral_xy.m performs a line integral of attenuation values. Calls x_to_c.m and y_to_r.m to convert to (r,c) space and line_integral_rc.m for the attenuation vector.

![CT Detector Array]
(https://github.com/cgrundman/CT-Imaging/blob/main/3_ct_simulation/CT%20Detector%20Array.jpg)

5) line_integral_rc.m creates a vector containing the series of attenuation values for the current position or view.

### Generate important physical devices (X-ray source and detectors)

CT scanners have physical devices whose location is crucial to reconstruction.

6) tube_position_xy.m is a function file that creates a x_y coordinate of the x-ray source.

7) detector_position_xy.m is a function file that creates a x_y coordinate of the x-ray detectors.

![CT Projection]
(https://github.com/cgrundman/CT-Imaging/blob/main/3_ct_simulation/CT%20Projection.jpg)

### Convert between coordinate systems

(r,c) space is the geometric representation of the x-ray source and detector rotating around the patient, whereas (x,y) is stationary.

8) x_to_c.m is a function file that converts an x coordinate in (x,y) space to an r coordinate in (r,c) space. 

9) y_to_r.m is a function file that converts a y coordinate in (x,y) space to a c coordinate in (r,c) space.

10) rotate_xy.m rotates through a series of discrete and defined views.

### Create a sinogram through rotation of the image.

11) projection.m
![CT Complete Simulation]
(https://github.com/cgrundman/CT-Imaging/blob/main/3_ct_simulation/CT%20Complete%20Simulation.jpg)





## Files:

### Project Files
ct_simulation.m 
  - main executable file
detector_position_xy.m
  - function file - detector location calculator
line_integral_rc.m
  - function file - calculates a single angle of CT Projection (see <em>CT Projection.jpg</em>), using rc coordinates
line_integral_xy.m
  - function file - calculates a single angle of CT Projection (see <em>CT Projection.jpg</em>), using xy coordinates
projection.m
  - function file - creates a full sinogram from an input image, only a simulation from inbuilt library files
rotate_xy.m
  - function file - calculates new x and y coordniates from a rotation angle and original coordinates
simulation.m
  - function file - calculates sinogram through image data, and other inputs from the outputs of other files
tube_position_xy.m
  - function file - calculates tube position from focus center distance and rotation.
view.m
  - function file - view image data
x_to_c.m
  - function file - convert x-space coordination to c-space coordinate
y_to_r.m
  - function file - convert y-space coordination to r-space coordinate

### Image Files
CTLab-Introduction3.jpg
  - The starting sample image
CT Complete Simulation.jpg
  - Complete sinogram creation of the sample image
CT Detector Array.jpg
  - A plot of the X-ray detector array
CT Initial Image.jpg
  - A plot of the initial image
CT Projection.jpg
  - A 1 dimensional projection, single angle CT


# CT-2-Simulation

Complete CT Scanner Simulator

Purpose: Create a sinogram representaion of a given crossection.

