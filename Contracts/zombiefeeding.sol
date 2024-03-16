pragma solidity pragma >=0.5.0 < 0.6.0;

import "./zombiefactory.sol"

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
	
	address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
	KittyInterface kittyContract = KittyInterface(ckAddress);

	function feedAndMultiply(uint _zombie, uint _targetDna, string memory _specie) public {
		require(msg.sender == zombieToOwner[_zombieId]);
		Zombie storage myZombie = zombies[_zombieId];
		_targetDna = _targetDna % dnaModulus;
		uint newDna = (myZombie.dna + _targetDna) / 2;
		if (keccak256(abi.encodePacked(_specie)) == keccak256(abi.encodePacked("kitty")) {
			newDna = newDna - newDna % 100 + 99;
		}
		_createZombie("noName" ,newDna);
	}

	function feedOnKitty(uint _zombieId, uint kittyId) public {
		uint kittyDna;
		(,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
		feedAndMultiply(_zombieId, kittyId, "kitty");
	}
}
