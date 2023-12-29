# CT-Imaging
This is the home for an ongiong project to showcase how CT imaging works and provide MATLAB code.

<em>Currently a work in progress, new sections will be added and reorganized on a rolling basis.</em>.

## Starting Point

sinogram_generator.m is the main file, start there. The sinogram iscreated by projection.m

## Section 1: Introduction

TBD

## Section 2: Exercise 1

TBD

## Section 3: Exercise 2

TBD

## Section 4: ART

TBD

## Section 5: Metal Artifact Removal

TBD


# CT-2-Simulation

Complete CT Scanner Simulator

Purpose: Create a sinogram representaion of a given crossection.

## Description of files

### Start Point

1) ct_simulation.m is the main file and the starting point. All of the other files are functions that are referenced. This is an 8-part file that walks through the building of a CT Scanner simulation.

### Simulate the CT Scanner

These functions create the initial Sinogram. This is an image in Radon Space. The subsequent funtions after these are all involved in reconstruction of the image back to real space.

2) simulation.m is a function file that compiles all views and outputs sinogram of the patient's cross section. This file calls view.m to create the sinogram.

3) view.m is a function file that compiles line integrals for a single column of the sinogram. This file calls tube_position_xy.m, detector_position_xy, and line_integral_xy.m.

### Create vector of attenuation values

4) line_integral_xy.m performs a line integral of attenuation values. Calls x_to_c.m and y_to_r.m to convert to (r,c) space and line_integral_rc.m for the attenuation vector.

5) line_integral_rc.m creates a vector containing the series of attenuation values for the current position or view.

### Generate important physical devices (X-ray source and detectors)

CT scanners have physical devices whose location is crucial to reconstruction.

6) tube_position_xy.m is a function file that creates a x_y coordinate of the x-ray source.

7) detector_position_xy.m is a function file that creates a x_y coordinate of the x-ray detectors.

### Convert between coordinate systems

(r,c) space is the geometric representation of the x-ray source and detector rotating around the patient, whereas (x,y) is stationary.

8) x_to_c.m is a function file that converts an x coordinate in (x,y) space to an r coordinate in (r,c) space. 

9) y_to_r.m is a function file that converts a y coordinate in (x,y) space to a c coordinate in (r,c) space.

10) rotate_xy.m rotates through a series of discrete and defined views.

### Create a sinogram through rotation of the image.

11) projection.m 

### Image Files

CT Initial Image is the image used for the simulation. 

CT Detector Plot is the plot for where the detectors are located.

CT Complete Simulation is both the sinogram resulting from the simulation and the mathematical reconstruction.
