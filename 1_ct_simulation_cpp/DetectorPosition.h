#ifndef DETECTOR_POSITION_H
#define DETECTOR_POSITION_H

#include <vector>
#include <cmath>

class DetectorPosition {
public:
    // Method to calculate the detector's x and y positions
    void calculate(
        double DCD_mm, 
        double angle_deg, 
        int n_dexel, 
        double dexel_size_mm, 
        std::vector<double>& det_x, 
        std::vector<double>& det_y) const;

private:
    // Helper method to perform rotation
    void rotate_xy(double x, double y, double angle_deg, double& new_x, double& new_y) const;
};

#endif // DETECTOR_POSITION_H
