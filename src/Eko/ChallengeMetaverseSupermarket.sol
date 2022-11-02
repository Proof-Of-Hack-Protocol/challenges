// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "openzeppelin-contracts/utils/cryptography/EIP712.sol";

struct OraclePrice {
    uint256 blockNumber;
    uint256 price;
}

struct Signature {
    uint8 v;
    bytes32 r;
    bytes32 s;
}

abstract contract InflaStoreEIP712 is EIP712 {
    bytes32 public constant ORACLE_PRICE_TYPEHASH = keccak256("OraclePrice(uint256 blockNumber,uint256 price)");

    function _hashOraclePrice(OraclePrice memory oraclePrice) internal view returns (bytes32 hash) {
        return _hashTypedDataV4(
            keccak256(abi.encode(ORACLE_PRICE_TYPEHASH, oraclePrice.blockNumber, oraclePrice.price))
        );
    }
}

/// @title Metaverse Supermarket
/// @author https://twitter.com/adrianromero
/// @notice We are all living in the Inflation Metaverse, a digital world dominated by the INFLA token. You are out of INFLAs and you are starving, can you defeat the system?
/// @custom:url https://www.ctfprotocol.com/tracks/eko2022/metaverse-supermarket
contract InflaStore is InflaStoreEIP712 {
    Meal public immutable meal;
    Infla public immutable infla;

    address private owner;
    address private oracle;

    uint256 public constant MEAL_PRICE = 1e6;
    uint256 public constant BLOCK_RANGE = 10;

    constructor(address player) EIP712("InflaStore", "1.0") {
        meal = new Meal();
        infla = new Infla(player, 10);
        owner = msg.sender;
    }

    function setOracle(address _oracle) external {
        require(owner == msg.sender, "!owner");
        oracle = _oracle;
    }

    function buy() external {
        _mintMeal(msg.sender, MEAL_PRICE);
    }

    function buyUsingOracle(OraclePrice calldata oraclePrice, Signature calldata signature) external {
        _validateOraclePrice(oraclePrice, signature);
        _mintMeal(msg.sender, oraclePrice.price);
    }

    function _mintMeal(address buyer, uint256 price) private {
        infla.transferFrom(buyer, address(this), price);
        meal.safeMint(buyer);
    }

    function _validateOraclePrice(OraclePrice calldata oraclePrice, Signature calldata signature) private view {
        require(block.number - oraclePrice.blockNumber < BLOCK_RANGE, "price too old!");

        bytes32 oracleHash = _hashOraclePrice(oraclePrice);
        address recovered = _recover(oracleHash, signature.v, signature.r, signature.s);

        require(recovered == oracle, "not oracle!");
    }

    function _recover(bytes32 digest, uint8 v, bytes32 r, bytes32 s) internal pure returns (address) {
        require(v == 27 || v == 28, "invalid v!");
        return ecrecover(digest, v, r, s);
    }
}

import "solmate/tokens/ERC721.sol";

contract Meal is ERC721("Meal", "MEAL") {
    address private immutable _owner;
    uint256 private _tokenIdCounter;

    constructor() {
        _owner = msg.sender;
    }

    function safeMint(address to) external {
        require(_owner == msg.sender, "Only owner can mint");
        uint256 tokenId = _tokenIdCounter;
        unchecked {
            ++_tokenIdCounter;
        }
        _safeMint(to, tokenId);
    }

    function tokenURI(uint256) public pure override returns (string memory) {
        return "ipfs://QmQqCFY7Dt9SFgadayt8eeTr7i5XauiswxeLysexbymGp1";
    }
}

import "solmate/tokens/ERC20.sol";

contract Infla is ERC20("INFLA", "INF", 18) {
    constructor(address player, uint256 amount) {
        _mint(player, amount);
    }
}
