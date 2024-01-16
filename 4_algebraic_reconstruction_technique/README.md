
# Algebraic Reconstruction Technique Demonstration

This folder contains files implementing the Algebraic Reconstruction Technique (ART).

The code is structured as thus below:

## Step 1: Creating the Dataset
Starting file: dataset_creation.m 

This creates the data set used to showcase image reconstruction by calling function simulation.m.

1. Simulation iterates through every angle in the simulation by calling function view.m and collects all views into a single sinogram.
2. View finds a single view for the ct simulation. First, calling tube_position_xy and detector_position_xy to find start and end points for every x-ray beam. Then, this function iterates through detectors and calls line_integral_xy to find the reading for each detector.
3. Line Integral XY translates coordinated to r and c coordinate space and calls line_integral_rc.
4. Line Integral RC finds the detector value for the given detector, and returns the attenuation value and normalization term.

## Step 2: Algebraic Reconstruction Technique
Starting file: art.m

This file performs full reconstruction on CT sinogram data by calling view_xy.m. 

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

view_xy.m (function file)
tube_position_xy.m (function file)
detector_position_xy.m (function file)
line_integral_xy.m (function file)
line_integral_rc.m (function file)
backproject_view_xy.m (function file)
tube_position_xy.m (function file)
detector_position_xy.m (function file)
backproject_xy.m (function file)
backproject_rc.m (function file)
## File structure:

dataset_creation.m
  - simulation.m (function file)
    - view.m (function file)
      - tube_position_xy.m (function file)
      - detector_position_xy.m (function file)
      - line_integral_xy.m (function file)
        - line_integral_rc.m (function file)

art.m
  - view_xy.m (function file)
    - tube_position_xy.m (function file)
    - detector_position_xy.m (function file)
    - line_integral_xy.m (function file)
      - line_integral_rc.m (function file)
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

