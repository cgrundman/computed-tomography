# CT Machine Simulation

This folder contains files implementing a CT Simulation.

## How a CT Machine Works

This repo is meant to teach how a CT Machine works and collects data, as well as the structure of the data it produces. 

### Visualization of CT Machine

Below the functioning of a CT machine is visualized:

![CT Machine Visualization](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/ct_machine_geometry.gif)

In Reality the detector array is arranged in a circular pattern. Aranging them linearly, simplifies the calulations later. Also this assumes all X-ray beams are uniform and simultaneous. This is not the case. This would include added noice and further interpolation that is done in real machines. This may be shown in another repo.

### Simulate the CT Scanner

Let's get into actual coding of this project.

TODO Add information about the project here.

### Vizualization of the simulation

As the machine spins, data is collected. This procedure is illustrated in the following gif, as each view is added one by one.

![Sinogram Creation](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/sinogram_creation.gif)

With the full simulation completed, a visualization of the data can be found below:

![CT Projection](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/head_sinogram.jpg)

This image is called a sinogram, and it is a representation of the crossection of the body in radon space. Later sections of this repo will discuss reconstruction of this image, as that is where much of the challenge in creating accurate images.

### Start Point

ct_simulation.m is the main file and the starting point. If you would like to play around with the simulation and the geometry, start here and play around with settings.

## Files:

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

## File structure (for simulation):
ct_simulation.m
  - simulation.m (function file)
    - view.m
      - tube_position_xy.m
      - detector_position_xy.m
      - line_integral_xy.m
        - x_to_c.m
        - y_to_r.m
        - line_integral_rc.m

## Authors

- [@cgrundman](https://github.com/cgrundman/)
- [@RiccardoCatena1](https://github.com/RiccardoCatena1/)

## Feedback

If you have any feedback, please reach out to me at https://github.com/cgrundman.
