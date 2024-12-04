#ifndef COORDINATE_CONVERTER_H
#define COORDINATE_CONVERTER_H

#include <vector>

class CoordinateConverter {
private:
    std::vector<std::vector<double>> data; // Image matrix
    double pixel_size_mm;                  // Pixel size in mm

public:
    // Constructor
    CoordinateConverter(const std::vector<std::vector<double>>& data);

    // Method to convert x position to c coordinate
    double x_to_c(double pos_x, double pixel_size_mm);

    // Method to convert y position to r coordinate
    double y_to_r(double pos_y, double pixel_size_mm);
};

#endif // COORDINATE_CONVERTER_H