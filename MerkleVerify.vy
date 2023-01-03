@pure
@external
def verify(leaf: address, proofs: DynArray[bytes32, 1024], merkleRoot: bytes32) -> bool:
    leaf_hash: bytes32 = keccak256(slice(convert(leaf, bytes32), 12, 20))

    for i in proofs:
        leaf_hash = self._verify(i, leaf_hash)

    return leaf_hash == merkleRoot

@pure
@internal
def _verify(left_hash: bytes32, right_hash: bytes32) -> bytes32:
    left_hash_temp: bytes32 = left_hash
    right_hash_temp: bytes32 = right_hash
    if convert(left_hash_temp, uint256) > convert(right_hash_temp, uint256):
        temp: bytes32 = left_hash_temp
        left_hash_temp = right_hash_temp
        right_hash_temp = temp

    return keccak256(concat(left_hash_temp, right_hash_temp))
