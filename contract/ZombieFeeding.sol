pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}


contract ZombieFeeding is ZombieFactory {
  // using the crypto kitty contract
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  // using an interface to connect with the kitty contract
  KittyInterface kittyContract  = KittyInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    // makes sure before we run function to check if zombie belongs to address
    require(msg.sender == zombieToOwner[_zombieId]);
    // We grab the zombie Dna and set it to myZombie
    Zombie storage myZombie = zombies[_zombieId];
    // Make sure its 16 digits
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // Call function from zombieFactory
    _createZombie("NoName", newDna);
}
