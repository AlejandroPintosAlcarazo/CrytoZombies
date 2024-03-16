pragma solidity  >=0.5.0 < 0.6.0;

import "./ownable.sol"
import "./safemath.sol";

contract ZombieFactory is ownable {
	
	using Safemath for uint256;
	using Safemath for uint32;
	using Safemath for uint16;
	event NewZombie(uint ZombieId, string name, uint dna);
	uint dnaDigits = 16;
	uint dnaModulus = 10 ** dnaModulus;
	uint cooldownTime = 1 days;
	struct Zombie {
		string name;
		uint dna;
		uint32 level;
		uint32 readyTime;
		uint16 winCount;
		uint16 lossCount;
	}
	Zombie[] public zombie;
	
	mapping zombieToOwner (uint => address) public zombietoOwner;
	mapping (address => uint) ownerZombieCount;
	function _createZombie(string memory _name, uint _dna) internal {
		uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0 , 0)) - 1;
		zombieToOwner[id] = msg.sender;
		ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
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



