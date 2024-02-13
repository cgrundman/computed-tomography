
# Algebraic Reconstruction Technique Demonstration

This folder contains files implementing the Algebraic Reconstruction Technique (ART).

The code is structured as thus below:

## ART Algorithm
Starting file: reconstruction_art.m

This file performs full reconstruction on CT sinogram data by calling view_xy.m and backproject_view_xy.

### Forward Projection
1. View XY creates an entire view of the CT reconstruction. This function iterates through every row of the sinogram, which is a collection of detector attenuation readings. This calls tube_position_xy, detector_position_xy, and line_integral_xy while iteration 
2. Tube Position XY finds the x and y coordinates of the x-ray tube.
3. Detector Position XY finds the x and y coordinated of the detectors.
4. Line Integral XY performs forward projection on the on the detector array by calling line_integral_rc
5. Line Integral RC performs forward projection on the on the single detector array in r and c coordinates
   
### Backprojection
1. Backprojection XY returns the full reconstructed image, calling tube_position_xy, detector_position_xy, and iterating through backproject_xy
2. Backproject XY performs a single backprojection and calls backproject_rc
3. Backproject RC performs a single backprojection through r and c coordinates

![CT Detector Array](https://github.com/cgrundman/CT-Imaging/blob/main/2_algebraic_reconstruction_technique/figures/iteration.gif)

## Files:

- reconstruction_art.m - main function file that performs the overall reconstruction
- view_xy.m  - function file - view image data
- tube_position_xy.m - function file - calculates tube position from focus center distance and rotation.
- detector_position_xy.m - function file - detector location calculator
- line_integral_xy.m - function file - calculates a single angle of CT Projection (see <em>CT Projection.jpg</em>), using xy coordinates
- line_integral_rc.m - function file - calculates a single angle of CT Projection (see <em>CT Projection.jpg</em>), using rc coordinates
- backproject_view_xy.m - function file - performs backprojection for an entire view of detectors
- backproject_xy.m - function file - performs backprojection on single beam in xy space, calls backproject_rc
- backproject_rc.m - function file - performs back projection on single beam in rc space
- x_to_c.m - function file - convert x-space coordination to c-space coordinate
- y_to_r.m - function file - convert y-space coordination to r-space coordinate
- dist_point_line.m - function file - calculates the distance of a line within current pixel
- line_cell_intersection_rc.m - function file - calculate points of intersection of current pixel

## File structure:

reconstruction_art.m
  - view_xy.m (function file)
    - tube_position_xy.m (function file)
    - detector_position_xy.m (function file)
    - line_integral_xy.m (function file)
      - x_to_c.m (function file)
      - y_to_r.m (function file)
      - line_integral_rc.m (function file)
        - dist_point_line.m (function file)
        - line_cell_intersection_rc.m (function file)
  - backproject_view_xy.m (function file)
    - tube_position_xy.m (function file)
    - detector_position_xy.m (function file)
    - backproject_xy.m (function file)
      - backproject_rc.m (function file)


## Authors

- [@cgrundman](https://github.com/cgrundman/)
- [@RiccardoCatena1](https://github.com/RiccardoCatena1/)


## Feedback

If you have any feedback, please reach out to me at https://github.com/cgrundman.

