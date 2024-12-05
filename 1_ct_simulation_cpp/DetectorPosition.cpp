#include "DetectorPosition.h"

// Helper method to rotate a point
void DetectorPosition::rotate_xy(double x, double y, double angle_deg, double& new_x, double& new_y) const {
    float pi = 3.14159;
    double angle_rad = angle_deg * pi / 180.0;
    double neg_angle_rad = -angle_rad;

    new_x = x * std::cos(neg_angle_rad) - y * std::sin(neg_angle_rad);
    new_y = x * std::sin(neg_angle_rad) + y * std::cos(neg_angle_rad);
}

// Method to calculate the detector's positions
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

    // Calculate new x and y values after rotation
    for (int i = 0; i < n_dexel; ++i) {
        rotate_xy(x[i], y[i], -angle_deg, det_x[i], det_y[i]);
    }
}
