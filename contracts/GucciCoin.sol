pragma solidity >=0.4.22 <0.9.0;

import "./Token.sol";

contract GucciCoin is Token {

  constructor()
    public
  {
    tokenName = "GucciCoin";
    tokenSymbol = "GCC";
    tokenDecimals = 18;
    tokenTotalSupply = 300000000000000000000000000;
    ownershipBalance[msg.sender] = tokenTotalSupply;
  }
}
