base64Set: public(constant(String[64])) = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

@external
def base64Decode(base64String: DynArray[String[4], 333]) -> Bytes[1332]:
    result: Bytes[1332] = empty(Bytes[1332])
    _len: uint256 = len(base64String)
    assert _len % 4 == 0, "input string not multiple of 4"
    for i in range(1332):
        temp: uint256 = 0
        pass
    
    return result

@internal
def base64_encoding_value(a: String[1]) -> uint256:
    for i in range(64):
        if a == slice(base64Set, i, 1):
            return i
    return 64
