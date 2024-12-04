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

    std::vector<std::vector<double>> test_set = {
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

    return 0;
}