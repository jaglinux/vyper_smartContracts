staked: public(HashMap[address, uint256])

@internal
def _deposit(_depositer: address, _value: uint256):
    self.staked[_depositer] += _value
    
@payable
@external
def deposit():
    assert msg.value > 0, "wei cannot be 0"
    self._deposit(msg.sender, msg.value)

@external
def withdraw(_amount: uint256):
    assert _amount > 0, "withdrawal cannot be 0"
    assert self.staked[msg.sender] >= _amount, "not enough balance"
    self.staked[msg.sender] -= _amount
    send(msg.sender, _amount)

@external
def totalBalance() -> uint256:
    return self.balance

@payable
@external
def __default__():
    assert msg.value > 0, "wei cannot be 0"
    self._deposit(msg.sender, msg.value)
