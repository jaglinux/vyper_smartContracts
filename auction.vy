beneficiary: public(address)
winner: public(address)
winning_bid: public(uint256)
end_time: public(uint256)
ended: public(bool)

refunds: public(HashMap[address, uint256])

@external
def __init__(_ben: address, _duration: uint256):
    assert _ben != empty(address)
    self.beneficiary = _ben
    self.end_time = block.timestamp + _duration

@payable
@external
def bid():
    assert self.ended == False
    assert block.timestamp < self.end_time
    assert msg.value > self.winning_bid
    self.refunds[self.winner] += self.winning_bid
    self.winner = msg.sender
    self.winning_bid = msg.value

@external
def end():
    assert self.ended == False
    assert block.timestamp > self.end_time
    self.ended = True
    if self.winner != empty(address):
        send(self.beneficiary, self.winning_bid)

@external
def refund():
    assert self.ended == True
    _refund: uint256 = self.refunds[msg.sender]
    assert _refund > 0
    self.refunds[msg.sender] = 0
    send(msg.sender, _refund)
