#include <iostream>
#include "CoordinateConverter.h"
#include "RotationXY.h"

int main() {
    // Coordinate Conversion
    std::cout << "1. Coordinate Conversion tests:" << std::endl; 
    // Define the image matrix (e.g., 4x4 matrix for simplicity)
    std::vector<std::vector<double>> image_matrix = {
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0}
    };

    std::vector<std::vector<double>> test_set = {
        // Input coord, pixel size (mm), Output coord
        { 6.0, 3.0, 5.0}, // Test 1
        { 0.0, 3.0, 3.0}, // Test 2
        {-7.5, 3.0, 0.5}, // Test 3
        { 0.0, 6.0, 3.0}, // Test 4
        {15.0, 6.0, 0.5}  // Test 5
    };

    std::vector<std::string> test_function = {
        {"x_c", "x_c", "x_c", "y_r", "y_r"}
    };

    CoordinateConverter converter(image_matrix); // create an object of CoordinateConverter

    for (int i = 0; i < 5; i++) {
        std::string test = "failed";
        double pos = test_set[i][0]; // set input coord
        double pixel_size_mm = test_set[i][1]; // set pixel size
        double guess = 0;
        double answer = test_set[i][2]; // set correct answer
        if (test_function[i] == "x_c") {
            guess = converter.x_to_c(pos, pixel_size_mm); // calculate the c-coordinate
        } else if (test_function[i] == "y_r") {
            guess = converter.y_to_r(pos, pixel_size_mm); // calculate the c-coordinate
        }
        if (guess == answer) {
            test = "Passed!";
        }
        std::cout << "Test " << i+1 << ": " << test << std::endl;
    }

    // Coordinate Rotation
    std::cout << "2. Coordinate Rotation tests:" << std::endl;
    // Create an instance of the Rotator class
    RotationXY rotator;

    // Original coordinates
    double x = 1.0;
    double y = 0.0;

    // Angle of rotation in degrees
    double angle_deg = 90.0;

    // Variables to hold the new coordinates
    double new_x, new_y;

    // Perform the rotation
    rotator.rotate(x, y, angle_deg, new_x, new_y);

    // Output the result
    std::cout << "Rotated coordinates: (" << new_x << ", " << new_y << ")" << std::endl;

    return 0;
}