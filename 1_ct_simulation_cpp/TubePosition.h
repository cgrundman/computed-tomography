#ifndef TUBE_POSITION_H
#define TUBE_POSITION_H

#include <cmath>

class TubePosition {
public:
    // Method to calculate the tube's x and y position
    void calculate(double FCD_mm, double angle_deg, double& tube_x, double& tube_y) const;
};

#endif // TUBE_POSITION_H
