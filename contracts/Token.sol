pragma solidity >=0.4.22 <0.9.0;

import "./ERC20.sol";

contract Token is ERC20 {

  /*** EVENTS ***/
  event Transfer(address indexed _from, address indexed _to, uint256 _value);

  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  /*** DATA TYPES ***/

  /// Token Name
  string internal tokenName;

  /// Token Symbol
  string internal tokenSymbol;

  /// Number of decimals.
  uint8 internal tokenDecimals;

  /// Total Supply of Tokens
  uint256 internal tokenTotalSupply;

  /// Balance Information Map.
  mapping (address => uint256) internal ownershipBalance;

  /// Token Allowance Mapping.
  mapping (address => mapping (address => uint256)) internal allowed;

  /*** METHODS ***/

  /// @dev Returns the name of the token.
  function name()
    public
    view
    returns (string memory _name)
  {
    _name = tokenName;
  }

  /// @dev Returns the symbol of the token.
  function symbol()
    public
    view
    returns (string memory _symbol)
  {
    _symbol = tokenSymbol;
  }

  /// @dev Returns the number of decimals the token uses.
  function decimals()
    public
    view
    returns (uint8 _decimals)
  {
    _decimals = tokenDecimals;
  }

  /// @dev Returns the total token supply.
  function totalSupply()
    public
    view
    returns (uint256 _totalSupply)
  {
    _totalSupply = tokenTotalSupply;
  }

  /// @dev Returns the account balance of another account with address _owner.
  /// @param _owner The address from which the balance will be retrieved.
  function balanceOf(
    address _owner
  )
    public
    view
    returns (uint256 _balance)
  {
    _balance = ownershipBalance[_owner];
  }

  /// @dev Transfers _value amount of tokens to address _to, and MUST fire the Transfer event. The
  ///  function SHOULD throw if the _from account balance does not have enough tokens to spend.
  /// @param _to The address of the recipient.
  /// @param _value The amount of token to be transferred.
  function transfer(
    address _to,
    uint256 _value
  )
    public
    returns (bool _success)
  {
    require(_value <= ownershipBalance[msg.sender]);

    ownershipBalance[msg.sender] = ownershipBalance[msg.sender] - _value;
    ownershipBalance[_to] = ownershipBalance[_to] + _value;

    emit Transfer(msg.sender, _to, _value);
    _success = true;
  }

  /**
   * @dev Transfers _value amount of tokens from address _from to address _to, and MUST fire the
   * Transfer event.
   * @param _from The address of the sender.
   * @param _to The address of the recipient.
   * @param _value The amount of token to be transferred.
   */
  function transferFrom(
    address _from,
    address _to,
    uint256 _value
  )
    public
    returns (bool _success)
  {
    require(_value <= ownershipBalance[_from]);
    require(_value <= allowed[_from][msg.sender]);

    ownershipBalance[_from] = ownershipBalance[_from] - _value;
    ownershipBalance[_to] = ownershipBalance[_to] + _value;
    allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;

    emit Transfer(_from, _to, _value);
    _success = true;
  }

  /**
   * @dev Allows _spender to withdraw from your account multiple times, up to the _value amount. If
   *  this function is called again it overwrites the current allowance with _value,
   * @param _spender The address of the account able to transfer the tokens.
   * @param _value The amount of tokens to be approved for transfer.
   */
  function approve(
    address _spender,
    uint256 _value
  )
    public
    returns (bool _success)
  {
    require(
        (_value == 0) || (allowed[msg.sender][_spender] == 0)
    );

    allowed[msg.sender][_spender] = _value;

    emit Approval(msg.sender, _spender, _value);
    _success = true;
  }

  /**
   * @dev Transfers _value amount of tokens from address _from to address _to, and MUST fire the
   *  Transfer event.
   * @param _owner The address of the account owning tokens.
   * @param _spender The address of the account able to transfer the tokens.
   */
  function allowance(
    address _owner,
    address _spender
  )
    public
    view
    returns (uint256 _remaining)
  {
    _remaining = allowed[_owner][_spender];
  }
}
