#ifndef DETECTOR_POSITION_H
#define DETECTOR_POSITION_H

#include <vector>

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
};

#endif // DETECTOR_POSITION_H
