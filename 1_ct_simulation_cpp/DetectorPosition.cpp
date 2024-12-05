#include "DetectorPosition.h"
#include "RotationXY.cpp"

void DetectorPosition::calculate(
    double DCD_mm, 
    double angle_deg, 
    int n_dexel, 
    double dexel_size_mm, 
    std::vector<double>& det_x, 
    std::vector<double>& det_y) const {

    // Calculate the width of the detector
    double det_width = n_dexel * dexel_size_mm;

    // Initialize x and y coordinates of the detector
    std::vector<double> x(n_dexel), y(n_dexel);
    for (int i = 0; i < n_dexel; ++i) {
        x[i] = -det_width / 2 + i * dexel_size_mm;
        y[i] = -DCD_mm;
    }

    // Resize output vectors
    det_x.resize(n_dexel);
    det_y.resize(n_dexel);

    // Create rotation object
    RotationXY rotation;

    // Calculate new x and y values after rotation
    for (int i = 0; i < n_dexel; ++i) {
        rotation.rotate(x[i], y[i], -angle_deg, det_x[i], det_y[i]); // Use external rotate_xy
    }
}
