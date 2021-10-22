// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./Bases.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    event NewEpicNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721 ("ACM-HacKards","SQUARE") {
        console.log("This is my NFT contract. whassup!");
    }

    function getTotalNFTsMintedSoFar() public view returns (uint256) {
        return _tokenIds.current() + 1;
    }

    function pickRandomSVG(uint256 tokenId) public pure returns (string memory){
        uint256 rand = random(string(abi.encodePacked("Rand_SVG", Strings.toString(tokenId))));
        rand = rand % 100;
        if(rand < 5){
            return "https://jsonkeeper.com/b/SI77";
        } else if (rand < 15){
            return "https://jsonkeeper.com/b/R8E8";
        } else if (rand < 35){
            return "https://jsonkeeper.com/b/WLW8";
        } else if (rand < 60){
            return "https://jsonkeeper.com/b/GW8F";
        } else {
            return "https://jsonkeeper.com/b/7KOJ";
        }
    }

    function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        require(getTotalNFTsMintedSoFar()<150, "Max NFTs minted!");
        require(balanceOf(msg.sender) < 3, 'Each address may only own three HacKards');
        uint256 newItemId = _tokenIds.current();

        _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, pickRandomSVG(newItemId));
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        
        _tokenIds.increment();
        emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}