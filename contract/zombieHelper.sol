pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  // Start here
  modifier aboveLevel(uint _level, uint _zombieId){
    require(zombies[_zombieId].level >= _level);
    _;
  }

  // uses modifier to check make sure zombie is higher than level 2 to change name
  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
    // make sure that person who called the function match the id of zombie
    require( msg.sender == zombieToOwner[_zombieId]);
    // grabs matching zombie id from zombie arry and changes the name
    zombies[_zombieId].name = _newName;
  }

  // uses modifier to check make sure zombie is higher than level 2 to change name
  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
    // make sure that person who called the function match the id of zombie
    require(msg.sender == zombieToOwner[_zombieId]);
    // grabs matching zombie id from zombie arry and changes the name
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

}
