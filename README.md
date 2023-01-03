# vyper_smartContracts
Collection of Vyper smart contracts

## How to use https://github.com/vyperlang/titanoboa to verify contracts

```
# simple.vy
@external
@view
def rough() -> bytes32:
    addr: address = 0x1aD91ee08f21bE3dE0BA2ba6918E714dA6B45836
    hash:bytes32 = convert(addr, bytes32)
    hash = keccak256(slice(hash, 12, 20))
    return hash
```
Python terminal
```
>>> import boa
>>> simple = boa.load("./simple.vy")
>>> a = simple.rough()
>>> hex(int.from_bytes(a, "big"))
'0x38b74bc12b97e00aeca693680c257c2a2a8a3ee73b03e5c72dd1e9fb838007f8'
>>> 
```
