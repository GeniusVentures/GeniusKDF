/**
 * @file       KDFGenerator.hpp
 * @brief      Key Derivation Function Generator
 * @date       2024-01-08
 * @author     Henrique A. Klein (henryaklein@gmail.com)
 */

#ifndef _KDF_GENERATOR_HPP_
#define _KDF_GENERATOR_HPP_

#include <vector>
#include <string>

/**
 * @brief       KDF Generator class
 */
class KDFGenerator
{
public:
    enum HashType
    {
        SHA256 = 0,
        KECCAK,
    };

    /**
     * @brief       Generates a shared secret with a new derived key
     * @param[in]   data Seed to generate the new key
     * @param[in]   type Type of hash 
     * @return      The new key in vector form
     */
    static std::vector<uint8_t> GenerateKDF( const std::vector<uint8_t> &data, const HashType &type );

private:
};

#endif
