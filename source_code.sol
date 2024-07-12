// Token details
string public name;
string public symbol;
uint256 public totalSupply;

// Owner of the contract
address public owner;

// Balances for each address
mapping(address => uint256) public balances;

// Modifier to restrict access to the owner
modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can call this function");
    _;
}

// Constructor to initialize the token details and set the owner
constructor(string memory _name, string memory _symbol) {
    name = _name;
    symbol = _symbol;
    owner = msg.sender;
    totalSupply = 0;
}

// Mint function to create new tokens, only callable by the owner
function mint(address _to, uint256 _amount) public onlyOwner {
    totalSupply += _amount;
    balances[_to] += _amount;
    emit Transfer(address(0), _to, _amount); // Emitting transfer event from zero address
}

// Burn function to destroy tokens, only callable by the owner
function burn(address _from, uint256 _amount) public onlyOwner {
    require(balances[_from] >= _amount, "Insufficient balance to burn");
    totalSupply -= _amount;
    balances[_from] -= _amount;
    emit Transfer(_from, address(0), _amount); // Emitting transfer event to zero address
}

// Transfer event to log minting and burning
event Transfer(address indexed from, address indexed to, uint256 value);