pragma solidity ^0.5.0;

import "./Token.sol";

contract CryptoExchange {
  string public name = "Light Exchange";
  Token public token;
  uint public rate = 300;

  event TokenPurchased(
    address account,
    address token,
    uint amount,
    uint rate
  );

  event TokenSold(
    address account,
    address token,
    uint amount,
    uint rate
  );

  constructor(Token _token) public {
    token = _token;
  }

  function buyTokens(uint _value) public payable {
    uint tokenAmount = _value;
    tokenAmount = msg.value * rate;


    token.transfer(msg.sender, tokenAmount);

    emit TokenPurchased(msg.sender, address(token), tokenAmount, rate);
  }

  function sellTokens(uint _amount) public {
    require(token.balanceOf(msg.sender) >= _amount);

    uint etherAmount = _amount / rate;

    require(address(this).balance >= etherAmount);

    token.transferFrom(msg.sender, address(this), _amount);
    msg.sender.transfer(etherAmount);

    emit TokenSold(msg.sender, address(token), _amount, rate);
  }

}
