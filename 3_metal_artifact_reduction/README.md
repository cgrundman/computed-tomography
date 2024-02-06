# Metal Artifact Reduction

## Background - Metal Artifacts in CT Imaging

As X-rays pass through the human body, they are attenuated. The entire reason that CT Imaging works is that harder tissues attenuate X-rays more than soft tissues. X-rays do not interact with metal the same way. This interaction causes beam hardening, scattering, and aliasing. Though metal is not naturally found in the body, it is used in prosthetics, medical tools, and can be foreign objects. Two examples are used to exemplify this problem:

![Original - Hip Data](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/hip_sino_original_data.jpg)

![Original - Phantom Data](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/phantom_sino_original_data.jpg)

The first image is a CT reconstruction from a person with a double hip replacement. The second image is a diagnostic image when the sample has two small, round metal objects.

## Step 1: Creating a Mask

Obviously the metal has to be filtered out of the image. As seen in image space above, the regions where the metal is present is of very high intensity. However, the effects from these regions spreads out thorugh the cross-section. So the method used is to create the metal mask in image space, forward project that into sinogram space, and transform it into a binary array. For the hip data this is shown below:

![Metal Mask Creation - Hip Data](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/hip_sino_metal_mask_creation.jpg)

Below this mask is applied to the original data. The intersection between the mask and the original data is removed, and the resulting sinogram reconstructed:

![Metal Mask - Hip Data](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/hip_sino_original_data.jpg)

Well, that isn't ideal. So let's try the same procedure on the phantom data:

![Metal Mask Creation - Phantom Data](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/phantom_sino_metal_mask_creation.jpg)

And this mask is applied and the resulting sinogram reconstructed in the same way as above:

![Metal Mask - Phantom Data](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/phantom_sino_original_data.jpg)

Both of these results are not complete. Yes, the metal was removed from the image. However, the masked sinograms still do not produce usable images. How do we solve this?

## Step 2: Filling In Data

The answer is to then fill in the information removed from the mask with information that is closer to what would be expected. Two methods of doing this will be discussed: Smoothing and Interpolation. 

### Step 2a: Smoothing

Smoothing is taking all of the data and blending it together. Think of this as blurring, where objects in an image become less clearly defined. Though it would appear straight forward, this is a complicated procedure to implement. The data is smoothed with the smothing algorithm. Then the intersection is found between the mask and the smoothed data. This data is then combined with the masked sinogram. This procedure is visualized below:

![Smoothing Technique](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/smoothing_technique.jpg)

Three different smoothing techniques were implemented. Averaging and Median implentation were found to be the best at reducing the metal influence. Averaging targeted the top metal region, Median smoothing targeted the bottom metal region. A third smoothing technique simply averages the results of both of these smoothing to target both metal sections. The results of all three smoothings are shown below:

![Phantom Data Smoothing](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/phantom_sino_original_data.jpg)

This performed well on the phantom data. It however is only effective at images with relatively smaller metal reagions. That is why a second filling technique is shown on the hip data.

### Step 2b: Interpolation

Another option to regain lost information is interpolation. This process is where information is inferred mathematicaly based on surrounding information. In this project, ```regionfill()``` is used to show interpolation. ```regionfill()``` is an internal MATLAB function. Below, a ```regionfill()``` example is shown with quarters on a table top.

The function needs two inputs: an image and a mask. Below is the original Image for the example:

![Original Image](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/FillRegionsUsingMaskImageExample_01.png)

Now, the mask boundaries need to be defined. Here are the mask boundaries:

![Mask Boudaries](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/FillRegionsUsingMaskImageExample_02.png)

These bounaries are then interpreted into a mask as found below:

![Binary Mask](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/FillRegionsUsingMaskImageExample_03.png)

Now both the mask and the image can be passed into the ```regionfill()``` function. The result of this can be seen below:

![Interpolated Image](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/FillRegionsUsingMaskImageExample_04.png)

This is a very robust function that fills in missing information. The issue with CT data, is that it must be interpolated in sinogram space. This is difficult procedure because sinogram space is not intuitively percieved. When the sinogram is altered with interpolation, the image must then be reconstructed in order to see how the interpolation performed.

Given that the sinogram and the metal mask were already created, all that needs to be don is pass the imformation into the function. The results of this can be seen below:

![Hip Data Interpolation](https://github.com/cgrundman/CT-Imaging/blob/main/3_metal_artifact_reduction/figures/hip_interpolation_results.jpg)

This process obvisouly still has its flaws. THere is still noise that is not present in the real cross-section. But this image is much more interpretable and usable for diagnosis and teatment planning.

A full description of the ```regionfill()``` function can be found in [MATLAB documentation](https://de.mathworks.com/help/images/ref/regionfill.html).

## File structure:
metal_artifact_remove.m
  - hip_mask.m* (function file)
  - phantom_mask.m* (function file)
  - phantom_smooth.m* (function file)
  - hip_interpolation.m* (function file)

*forwardproject.m and reconstruct.m functions are used in every sub function of metal_artifact_removal.m.

## Authors

- [@cgrundman](https://github.com/cgrundman/)
- [@RiccardoCatena1](https://github.com/RiccardoCatena1/)


## Feedback

If you have any feedback, please reach out to me at https://github.com/cgrundman.
