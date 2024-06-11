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
            ret_val = static_cast<std::vector<std::uint8_t>>(nil::crypto3::hash<nil::crypto3::hashes::sha2<256>>( data.begin(), data.end() ));
            break;
        case HashType::KECCAK:
            ret_val = static_cast<std::vector<std::uint8_t>>(nil::crypto3::hash<nil::crypto3::hashes::keccak_1600<256>>( data.begin(), data.end() ));
            break;
        default:
            break;
    }
    return ret_val;
}
