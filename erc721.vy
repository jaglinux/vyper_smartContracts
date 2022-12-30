tokenId: public(uint256)
totalSupply: public(uint256)
name: public(String[20])
symbol: public(String[20])
tokenIdtoAddress: public(HashMap[uint256, address])
tokensPerAddress: public(HashMap[address, uint256])
getApproved: public(HashMap[uint256, address])
isApprovedForAll: public(HashMap[address, HashMap[address, bool]])

@external
def __init__(_name: String[20], _symbol: String[20]):
    self.name = _name
    self.symbol = _symbol

@external
#Anyone can mint
def mint():
    _tokenId: uint256 = self.tokenId
    self.tokenIdtoAddress[_tokenId] = msg.sender
    self.tokensPerAddress[msg.sender] += 1
    self.tokenId = _tokenId + 1
    self.totalSupply += 1

@internal
def ownerOf(_tokenId: uint256) -> address:
    return self.tokenIdtoAddress[_tokenId]

@external
def setApprover(_spender: address, _tokenId: uint256):
    assert _spender != empty(address), "zero Address"
    _owner: address = self.ownerOf(_tokenId)
    assert msg.sender == _owner, "only Owner"
    self.getApproved[_tokenId] = _spender

@external 
def setApprovalForAll(_spender: address, status: bool):
    self.isApprovedForAll[msg.sender][_spender] = status

@internal
def _transfer(_owner: address, _dest: address, _tokenId: uint256):
    self.tokenIdtoAddress[_tokenId] = _dest
    self.tokensPerAddress[_owner] -= 1
    self.tokensPerAddress[_dest] += 1
    self.getApproved[_tokenId] = empty(address)

@external
def transfer(_dest: address, _tokenId: uint256):
    _owner: address = self.ownerOf(_tokenId)
    self._transfer(_owner, _dest, _tokenId)

@internal
def checkOwnerorSpenders(_sender: address, _tokenId: uint256) -> bool:
    _owner: address = self.ownerOf(_tokenId)
    return _owner == _sender or self.getApproved[_tokenId] == _sender or self.isApprovedForAll[_owner][_sender]

@external
def transferFrom(_source: address, _dest: address, _tokenId: uint256):
    _sender: address = msg.sender
    assert self.checkOwnerorSpenders(_sender, _tokenId), "not owner or approved"
    self._transfer(_source, _dest, _tokenId)

@external
#only owner can burn
def burn(_tokenId: uint256):
    _owner: address = self.ownerOf(_tokenId)
    assert msg.sender == _owner, "not owner"
    self.tokenIdtoAddress[_tokenId] = empty(address)
    self.getApproved[_tokenId] = empty(address)
    self.totalSupply -= 1
