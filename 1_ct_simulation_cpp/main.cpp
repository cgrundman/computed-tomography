#include <iostream>
#include "CoordinateConverter.h"

int main() {
    // Define the image matrix (e.g., 4x4 matrix for simplicity)
    std::vector<std::vector<double>> image_matrix = {
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0}
    };

    // x_to_c( 6.0, data, 3.0) % result: 5
    // x_to_c( 0.0, data, 3.0) % result: 3
    // x_to_c(-7.5, data, 3.0) % result: 0.5
    // y_to_r( 0.0, data, 6.0) % result: 3
    // y_to_r(15.0, data, 6.0) % result: 0.5

    // Test conditions for x,y to r,c conversion
    // Test 1
    std::string test_1;
    double pos_x_1 = 6.0; // set X-coord
    double pixel_size_mm_1 = 3.0; // set pixel size
    CoordinateConverter converter(image_matrix, pixel_size_mm_1); // create an object of CoordinateConverter
    double pos_c_1 = converter.x_to_c(pos_x_1); // calculate the c-coordinate
    if (pos_c_1 == 5.0)
        test_1 = "Passed";
    else
        test_1 = "Failed";
    std::cout << "Test 1: " << test_1 << std::endl;

    // Test 2
    std::string test_2;
    double pos_x_2 = 0.0; // set X-coord
    double pos_c_2 = converter.x_to_c(pos_x_2); // calculate the c-coordinate
    if (pos_c_2 == 3.0)
        test_2 = "Passed";
    else
        test_2 = "Failed";
    std::cout << "Test 2: " << test_2 << std::endl;

    return 0;
}