#pragma once

/**
 * @brief This is a dummy class
 * a
 */
class Dummy 
{
	public:

  /**
   * @brief Construct a new Dummy object
   * 
   */
  Dummy();
  
  /**
   * @brief This is a boost dummy function
   * 
   * @return true 
   * @return false 
   */
  const bool useBoost();

  /**
   * @brief This is a linalg dummy function
   * 
   * @return true 
   * @return false 
   */
  const bool useLinalg();

  /**
   * @brief This is loguru dummy function
   * 
   * @return true 
   * @return false 
   */
  const bool useLoguru();
};
