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

  }

}
