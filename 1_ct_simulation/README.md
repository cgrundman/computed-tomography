# CT Machine Simulation

This folder contains files implementing a CT Simulation.

## What a Computed Tomography Machine Does

X-rays are simply fast moving electrons. They are used i medical imaging because they can pass through solid materials. At the same time different materials attenuate x-rays differently from each other. Harder tissues like bone block more x-rays than the softer tissues comprising organs. However it is only possible to send a beam through multiple materials. In some cases, an x-ray image is not enough to diagnose or understand what is happening inside of the body. CT-Images create cross-sections that are much more detailed and reveal what is happening inside the body.

Because, of their nature, the x-ray readings have to be collected and then reconstructed into images. This code reviews how a ct machine works and creates ct data, refered to as sinograms because of the structures the create.

## The Initial Data

For this project, a CT machine is approximated. The starting point will be an actual CT image and transforming it into CT data to be transformed by later sections of the project. The image used in this section, a head CT scan, can be seen below:

![Initial Image](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/initial_image.png)

This is just a starting point. Now to build the machine around it.

## The CT Machine

THe CT machine has two crucial components. The X-ray emitter, or source, and the detectors. The x-rays travel from the source to the detectors while passing through the body. This is visualized below:

![Single Beam](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/single_beam.png)

However, the x-rays are generated in a fan beam shape. And each detector reads values for a small area opposite the source. This geometry is show below:

![Full Beam Array](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/ct_machine_geometry.png)

## CT Data Creation

Remember how x-rays work? When they pass through the human body, different tissues block different amounts of x-rays. Softer tissues allow more to pass through, while harder tissues block more x-rays. In CT imaging, attenuation is the amount of x-rays that are blocked. This means that the more x-rays that the detectors read, the lower the attenuation.

Now, this happens in a very short period of time. A single view as seen above is measured in a small instant. As all the detectors detect x-rays, the number of strikes are recorded and turned into attentuation values. Again, these are inversely related. Beams passing through more bone are seen to have higher values. From a single view, a collection of detector values can be seen below:

![Single Sinogram View](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/sino_view.png)

With the values collected, more information is needed to see inside the human body. The attenuation values are all of different value, but that does not tell about the structure of the body. So more data has to be taken from different views. This is why CT machines spin. They are taking views from all around the coss section of the body. This results in a series of views. If these values are collected and stitched together, they apear as below:

![Sinogram](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/head_sinogram.jpg)

See anything interesting? Most importantly, notice the shapes in the image. They should look like sinewaves. And it should look like a lot of sine waves. This is the reason this image is called a sinogram. Points in 3D space appear as sinewaves in a sinogram. The center point of machine rotation is simply a vertical line in the middle of the sinogram.

Does this still not make sense? You can read that a few more times (recomended), find better sources that explain this topic better (even more recomended), or even take a look at the gif below. This visualizes the process.

![Full Simulation Visualization](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/ct_machine_simulation.gif)

On the left, is the position of the machine, as it spins around the patient. In the middle is the attenuation plot from the data picked up by detectors. On the right is the sinogram as vews are added with the different angles.

However this process happens even faster than this. In the gif below, a CT machine without te protective covering is pictured. Here is the true speed of a CT Machine:

![Actual CT Machine](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/spinning_machine.gif)

## Files:

- ct_simulation.m  - main executable file
- detector_position_xy.m - function file - detector location calculator
- line_integral_rc.m - function file - calculates a single angle of CT Projection (see <em>CT Projection.jpg</em>), using rc coordinates
- line_integral_xy.m - function file - calculates a single angle of CT Projection (see <em>CT Projection.jpg</em>), using xy coordinates
- projection.m - function file - creates a full sinogram from an input image, only a simulation from inbuilt library files
- rotate_xy.m - function file - calculates new x and y coordniates from a rotation angle and original coordinates
- simulation.m - function file - calculates sinogram through image data, and other inputs from the outputs of other files
- tube_position_xy.m - function file - calculates tube position from focus center distance and rotation.
- sim_view.m - function file - view image data
- x_to_c.m - function file - convert x-space coordination to c-space coordinate
- y_to_r.m - function file - convert y-space coordination to r-space coordinate

## File structure (for simulation):

ct_simulation.m
  - simulation.m (function file)
    - sim_view.m
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
