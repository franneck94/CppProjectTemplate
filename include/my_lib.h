#pragma once

#include <cstdint>

#include "linalg.h"

/**
 * @brief This function prints hello world.
 * 
 * @return true 
 * @return false 
 */
bool print_hello_world();

/**
 * @brief This function couts hello world.
 * 
 * @return true 
 * @return false 
 */
bool cout_hello_world();

/**
 * @brief This function prints the content of a vector.
 * 
 * @return linalg::aliases::float3 
 */
linalg::aliases::float3 print_linalg_vector();

/**
 * @brief This function prints the installed boost version.
 * 
 * @return true 
 * @return false 
 */
bool print_boost_version();

/**
 * @brief This function computes the integer average of two integers.
 * 
 * @param a The first integer value.
 * @param b The second integer value.
 * @return std::int32_t 
 */
std::int32_t compute_average(std::int32_t a, std::int32_t b);
