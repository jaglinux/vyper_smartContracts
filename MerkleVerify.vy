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


# >>> merkle = boa.load("./MerkleVerify.vy")
# >>> in1 = 0x835ba2995566015bd49e561c1210937952c6843e10010f333a65b51f69247b44
# >>> in1 = in1.to_bytes(32, 'big')

# >>> in2=0x97bcb6ec8d1a742a9e39be8bf20cd581d3af6b4faa63e4e72d67ff57a81b72e9
# >>> in2 = in2.to_bytes(32, 'big')

# >>> in3=0xdd1b8d11e7734e8c06816161afb24a5dfa82761dd92afaec2f037f0cd0e369f4
# >>> in3 = in3.to_bytes(32, 'big')

# >>> merkle.verify("0x1aD91ee08f21bE3dE0BA2ba6918E714dA6B45836", [in1, in2], in3)
# True
