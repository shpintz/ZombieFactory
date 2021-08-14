pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory{

  // state varibales
  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;

  // Complex Data that have mulitple properies
  struct Zombie{
    string name;
    uint dna;
  }

  // Array of zombies inside zombies
  Zombie[] public zombies;

  // Function Create Zombie
  function _createZombie(string memory _name, uint _dna) private {
    zombies.push(Zombie(_name, _dna));
  }

  // Private genereateRandomDna
  function _generateRandomDna(string memory _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  // CreateRandomZombie = using private function to generate random DNA + createZombie function with name and dna
  function createRandomZombie(string memory _name) public {
      uint randDna = _generateRandomDna(_name);
      _createZombie(_name, randDna);
  }

}
