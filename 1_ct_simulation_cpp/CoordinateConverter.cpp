#include "CoordinateConverter.h"

// Constructor
CoordinateConverter::CoordinateConverter(const std::vector<std::vector<double>>& data, double pixel_size_mm) 
    : data(data), pixel_size_mm(pixel_size_mm) {}

// Method to convert x position to c coordinate
double CoordinateConverter::x_to_c(double pos_x) {
    // Extract x-coordinates of data matrix
    int data_x = data.size(); // Number of rows in the matrix

    // Calculate shift in coordinate systems
    double shift = (static_cast<double>(data_x) / 2.0) + 0.5;

    // Calculate new coordinate
    return (pos_x / pixel_size_mm) + shift;
}

// Method to convert y position to r coordinate
double CoordinateConverter::y_to_r(double pos_y) {
    int data_y = data.empty() ? 0 : data[0].size(); // Number of columns in the matrix

    // Calculate shift in coordinate systems
    double shift = (static_cast<double>(data_y) / 2.0) + 0.5;

    // Calculate new coordinate
    return pos_y / -pixel_size_mm + shift;
}