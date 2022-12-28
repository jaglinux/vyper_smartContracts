balances: public(HashMap[address, uint256])

# Event name should start with CAPS
event Deposit:
    amount: uint256
    sender: indexed(address)

event Withdraw:
    amount: uint256
    withdrawer: indexed(address)

@payable
@external
def deposit():
    self.balances[msg.sender] += msg.value
    log Deposit(msg.value, msg.sender)

@external
def withdraw():
    _amount: uint256 = self.balances[msg.sender]
    if _amount > 0:
        self.balances[msg.sender] = 0
        send(msg.sender, _amount)
        log Withdraw(_amount, msg.sender)



