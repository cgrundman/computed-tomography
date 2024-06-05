# CT-Imaging
This is the home for an ongiong project to showcase how CT imaging works and provide MATLAB code.

<em>Currently a work in progress, new sections will be added and reorganized on a rolling basis.</em>.

This Project has 3 sections, found in 3 folders from the main directory.

## Section 1: CT Simulation

This section shows how a collection of different views are compiled into an image called a sinogram. This code simulates a CT machine. It should be noted that the simulation excludes many other real world issues, like noise and X-Ray beam distribution. This idealization approximates how a CT machine works to serve as an educational tool.

![CT Simulation](https://github.com/cgrundman/CT-Imaging/blob/main/1_ct_simulation/figures/ct_machine_simulation.gif)

## Section 2: Algebraic Reconstruction Technique

This is a full demonstration of CT Data Reconstruction. The code from previous sections creates the data, where this code rebuilds ot into images we can interpret. It should be noted, this is an old algorithm that is not in use. For a more current CT Example search for Fourier Transform.

![Reconstruction](https://github.com/cgrundman/CT-Imaging/blob/main/2_algebraic_reconstruction_technique/figures/iteration.gif)

## Section 3: Metal Artifact Removal

This section deals with metal artifacts in CT Imaging. Metal creates a lot of issues for creating CT Images. X-rays react much differently to metal than biological tisues. CT Images are given with Metal Artifacts present, and methods of removing these artifacts are described. 

![Metal Artifact Reduction](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/hip_sino_metal_mask_creation.jpg)

TODO: Make in c++
TODO: Make a more common reconstruction

## Authors

- [@cgrundman](https://github.com/cgrundman/)
- [@RiccardoCatena1](https://github.com/RiccardoCatena1/)

## Feedback

If you have any feedback, please reach out to me at https://github.com/cgrundman.
