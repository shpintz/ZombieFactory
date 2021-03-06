pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory{

  // Event that allows us to know when a zombie is created
  event NewZombie(uint zombieId, string name, uint dna);

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

  // we'll store and look up the zombie based on its id
  mapping (uint => address) public zombieToOwner;
  // We'll see how many zombies owner has
  mapping (address => uint) ownerZombieCount;

  // Function Create Zombie
  function _createZombie(string memory _name, uint _dna) internal {
    uint id = zombies.push(Zombie(_name, _dna)) - 1;
    // Adds the zombie ID to the ETH address
    zombieToOwner[id] = msg.sender;
    // Updates Eth address with amount of zombies it owns
    ownerZombieCount[msg.sender]++;

    // Everytime this function is run the event will fire here
    emit NewZombie(id, _name, _dna);

  }

  // Private genereateRandomDna
  function _generateRandomDna(string memory _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  // CreateRandomZombie = using private function to generate random DNA + createZombie function with name and dna
  function createRandomZombie(string memory _name) public {
    // This make it so person can run this function once if they have zombie it wont run
    require(ownerZombieCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    _createZombie(_name, randDna);
  }

}

