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

  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    // makes sure before we run function to check if zombie belongs to address
    require(msg.sender == zombieToOwner[_zombieId]);
    // We grab the zombie Dna and set it to myZombie
    Zombie storage myZombie = zombies[_zombieId];
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
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    // use the kittyContract interface to use the function getKitty to grab the last item in return
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    // call the feed function with zombie and kittydna
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }
}
