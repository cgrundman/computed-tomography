#ifndef ROTATIONXY_H
#define ROTATIONXY_H

#include <cmath>

class RotationXY {
public:
    // Method to rotate coordinates
    void rotate(double x, double y, double angle_deg, double& new_x, double& new_y) const;
};

#endif // ROTATOR_H