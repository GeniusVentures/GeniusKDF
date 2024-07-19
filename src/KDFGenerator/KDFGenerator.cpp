/**
 * @file       KDFGenerator.cpp
 * @brief      
 * @date       2024-06-07
 * @author     Henrique A. Klein (hklein@gnus.ai)
 */

#include <nil/crypto3/hash/algorithm/hash.hpp>
#include <nil/crypto3/hash/sha2.hpp>
#include <nil/crypto3/hash/keccak.hpp>
#include "KDFGenerator.hpp"

std::vector<uint8_t> KDFGenerator::GenerateKDF( const std::vector<uint8_t> &data, const HashType &type )
{
    std::vector<std::uint8_t> ret_val;
    switch ( type )
    {
        case HashType::SHA256:
        {
            auto hash_result = nil::crypto3::hash<nil::crypto3::hashes::sha2<256>>(data.begin(), data.end());
            std::array<uint8_t, 32> hash_array = hash_result;
            ret_val = std::vector<std::uint8_t>(hash_array.begin(), hash_array.end());
            break;
        }
        case HashType::KECCAK:
        {
            //auto hash_result = nil::crypto3::hash<nil::crypto3::hashes::keccak_1600<256>>(data.begin(), data.end());
            //std::array<uint8_t, 32> hash_array = hash_result; // Assuming KECCAK outputs 32 bytes
            //ret_val = std::vector<std::uint8_t>(hash_array.begin(), hash_array.end());
            break;
        }
        default:
            break;
    }
    return ret_val;
}
