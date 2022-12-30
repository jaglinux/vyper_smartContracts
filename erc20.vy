totalSupply: public(uint256)
decimals: public(uint256)
name: public(String[20])
symbol: public(String[20])
owner: public(address)
balances: public(HashMap[address, uint256])
allowances: public(HashMap[address, HashMap[address, uint256]])

@external
def __init__(_name: String[20], _symbol: String[20], _decimals: uint256):
    self.name = _name
    self.symbol = _symbol
    self.decimals = _decimals
    self.owner = msg.sender

@internal
def _mint(receiver:address, amount:uint256):
    self.balances[receiver] += amount
    self.totalSupply += amount

@external
# mint function is dev or user specific implementation
# this is one such implementation
def mint(_receiver:address, _amount:uint256):
    #Only Owner can mint
    assert self.owner == msg.sender, "Only Owner can mint"
    self._mint(_receiver, _amount)


@internal
def _transfer(_sender:address, _receiver:address, _amount:uint256):
    self.balances[_sender] -= _amount
    self.balances[_receiver] += _amount

@external 
def transfer(_receiver:address, _amount:uint256):
    assert self.balances[msg.sender] >= _amount, "Not enough balance"
    self._transfer(msg.sender, _receiver, _amount)

@view
@external
def balanceOf(_owner:address) -> uint256:
    return self.balances[_owner]
    
@external
def setAllowance(_spender:address, _amount:uint256):
    assert self.balances[msg.sender] >= _amount, "Not enough balance"
    self.allowances[msg.sender][_spender] += _amount

@external
def transferFrom(_approver:address, _receiver:address,  _amount:uint256):
    assert self.allowances[_approver][msg.sender] >= _amount, "Not enough allowances"
    assert self.balances[_approver] >= _amount, "Not enough balances"
    self._transfer(_approver, _receiver, _amount)
    self.allowances[_approver][msg.sender] -= _amount
