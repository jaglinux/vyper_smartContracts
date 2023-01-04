# Example is from https://vyper.readthedocs.io/en/stable/built-in-functions.html?highlight=extract#extract32
# ExampleContract.foo("0x0000000000000000000000009f8F72aA9304c8B593d555F12eF6589cC3A579A2") is numbers in bytes format and not string,
# check 0x at the beginning.
# The equivalent code is below. Here the argument is passed in the contract itself.

# In Vyper, to assign numbers in Bytes[]
# number: Bytes[1] = b"\x0a"
# In Vyper, to assign string in Bytes[]
#       stores ascii value of 'a'
# str: Bytes[1] = b"a"

result: public(address)
a: public(Bytes[32])

@internal
@view
def foo(b: Bytes[32]) -> address:
    return extract32(b, 0, output_type=address)

@external
def work():
    self.a= b"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9f\x8F\x72\xaA\x93\x04\xc8\xB5\x93\xd5\x55\xF1\x2e\xF6\x58\x9c\xC3\xA4\x57\x9A"
    self.result = self.foo(self.a)
