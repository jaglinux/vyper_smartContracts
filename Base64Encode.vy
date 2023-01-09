base64Set: public(constant(String[64])) = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

@pure
@external
def encode(ascii: Bytes[999]) ->DynArray[String[4], 333]:
    result: DynArray[String[4], 333] = []
    _len: uint256 = len(ascii)
    if _len == 0:
        return result
    pad: uint256 = _len % 3
    # note: ascii_pad will never exceed 999 even in case of padding !
    ascii_pad: Bytes[1001] = ascii
    if pad == 1:
        ascii_pad = concat(ascii, b"\x00\x00")
    elif pad == 2:
        ascii_pad = concat(ascii, b"\x00")

    for i in range(333):
        j: uint256 = i*3
        lastBlock: bool = False
        if j+3 >= _len:
            lastBlock = True
        _block: Bytes[3] = slice(ascii_pad,j,3)
        intBlock: uint256 = convert(_block, uint256)
        local1: String[1] = slice(base64Set, shift(intBlock, -18), 1)
        local2: String[1] = slice(base64Set, shift(intBlock, -12) & 63, 1)
        if lastBlock == True and pad == 1:
            result.append(concat(local1, local2, "=="))
            break
        local3: String[1] = slice(base64Set, shift(intBlock, -6) & 63, 1)
        if lastBlock == True and pad == 2:
            result.append(concat(local1, local2, local3, "="))
            break
        local4: String[1] = slice(base64Set, intBlock & 63, 1)
        result.append(concat(local1, local2, local3, local4))
        if lastBlock == True:
            break

    return result

# >>> c = boa.load("./base64_encode.vy")
# >>> c.encode(b)
# ('YQ==',)
# >>> b = b"aa"
# >>> c.encode(b)
# ('YWE=',)
# >>> c = boa.load("./base64_encode.vy")
# >>> c.encode(b)
# ('YWE=',)
# >>> 
