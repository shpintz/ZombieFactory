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

  // Declareing a kittyContract to be within the Kitty interface
  KittyInterface kittyContract;

  // modifer
  modifier ownerOf(uint _zombieId){
    require(msg.sender == zombieToOwner[_zombieId]);
    _;
  }

  // Add setKittyContractAddress method here
  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  // passing a struct as argument
  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Zombie storage _zombie) internal view returns (bool) {
    return (_zombie.readyTime <= now);
  }


  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal ownerOf(_zombieId) {
    // makes sure before we run function to check if zombie belongs to address
    // require(msg.sender == zombieToOwner[_zombieId]);


    // We grab the zombie Dna and set it to myZombie
    Zombie storage myZombie = zombies[_zombieId];
    // We make sure the cooldown is ready and we can feed with require statement
    require(_isReady(myZombie));
    // Make sure its 16 digits
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // Checks to see if species is equal to kitty
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
        // this will add 99 to the end of the DNA
        newDna = newDna - newDna % 100 + 99;
    }
    // Call function from zombieFactory
    _createZombie("NoName", newDna);

    // Zombie feeding cooldown triggers
    _triggerCooldown(myZombie);

  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    // use the kittyContract interface to use the function getKitty to grab the last item in return
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    // call the feed function with zombie and kittydna
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }
}
