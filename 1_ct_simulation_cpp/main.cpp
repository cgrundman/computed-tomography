#include <iostream>
#include "CoordinateConverter.h"

int main() {
    // Define the image matrix (e.g., 4x4 matrix for simplicity)
    std::vector<std::vector<double>> image_matrix = {
        { 0,  1,  2,  3},
        { 4,  5,  6,  7},
        { 8,  9, 10, 11},
        {12, 13, 14, 15}
    };

    // Define pixel size in mm
    double pixel_size_mm = 0.5;

    // Create an object of CoordinateConverter
    CoordinateConverter converter(image_matrix, pixel_size_mm);

    // Define an x-coordinate position
    double pos_x = 10.0;

    // Define a y-coordinate position
    double pos_y = 10.0;

    // Calculate the c-coordinate
    double pos_c = converter.x_to_c(pos_x);

    // Calculate the c-coordinate
    double pos_r = converter.y_to_r(pos_y);

    // Print the result
    std::cout << "The c-coordinate is: " << pos_c << std::endl;
    std::cout << "The r-coordinate is: " << pos_r << std::endl;

    return 0;
}