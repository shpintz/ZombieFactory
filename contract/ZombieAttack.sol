pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {

  uint randNonce = 0;
  uint attackVictoryProbability = 70;



  // Funtion that generates random numbers with keccak (no secure)
   function randMod(uint _modulus) internal returns (uint){
    randNonce++;
    return uint(keccak256(abi.encodePacked(now , msg.sender, randNonce))) % _modulus;
  }

  // attack function
  function attack( uint _zombieId, uint _targetId ) external {

  }

}