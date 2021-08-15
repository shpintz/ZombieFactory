pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {
  // makes sure before we run function to check if zombie belongs to address
  require(msg.sender == zombieToOwner[_zombieId]);
  // We grab the zombie Dna and set it to myZombie
  Zombie storage myZombie = zombies[_zombieId];
}
