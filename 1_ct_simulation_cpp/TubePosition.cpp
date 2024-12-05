#include "TubePosition.h"

void TubePosition::calculate(double FCD_mm, double angle_deg, double& tube_x, double& tube_y) const {
    // Convert angle from degrees to radians
    float pi = 3.14159;
    double angle_rad = angle_deg * pi / 180.0;
    double neg_angle_rad = -angle_rad;

    // Calculate x and y positions
    tube_x = FCD_mm * std::sin(angle_rad);
    tube_y = FCD_mm * std::cos(neg_angle_rad);
}
