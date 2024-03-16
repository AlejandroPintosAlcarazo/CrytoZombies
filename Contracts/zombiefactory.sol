pragma solidity  >=0.5.0 < 0.6.0;

contract ZombieFactory {
	
	event NewZombie(uint ZombieId, string name, uint dna);
	uint dnaDigits = 16;
	uint dnaModulus = 10 ** dnaModulus;
	
	struct Zombie {
		string name;
		uinit dna;
	}
	Zombie[] public zombie;
	
	mapping zombieToOwner (uint => address) public zombietoOwner;
	mapping (address => uint) ownerZombieCount;
	function _createZombie(string memory _name, uint _dna) internal {
		uint id = zombies.push(Zombie(_name, _dna)) - 1;
		zombieToOwner[id] = msg.sender;
		ownerZombieCount[msg.sender]++;
		emit NewZombie(id, _name, _dna);
	}
	
	function _generateRandomDna(string memory _str) private view return (uint) {
		require(zombietoOwner[msg.sender] == 0);
		uint rand = keccak256(abi.encodePacked(_str));
		return rand % dnaModulus;
	}
	
	function createRandomZombie(string memory _name) public {
		uint randDna = _generateRandomDna(_name);
		_createRandomZombie(_name, randDna);
	}
}



