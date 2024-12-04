#include "RotationXY.h"

void RotationXY::rotate(double x, double y, double angle_deg, double& new_x, double& new_y) const {
    // Convert angle from degrees to radians
    float pi = 3.14159;
    double angle_rad = angle_deg * pi / 180.0;

    // Calculate sine and cosine of the angle
    double sin_angle = std::sin(angle_rad);
    double cos_angle = std::cos(angle_rad);

    // Calculate the rotated coordinates using the rotation matrix
    new_x = x * cos_angle - y * sin_angle;
    new_y = x * sin_angle + y * cos_angle;
}