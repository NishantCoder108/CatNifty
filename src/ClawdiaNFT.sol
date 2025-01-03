// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ClawdiaNFT is ERC721 {
    uint256 private s_tokenCounter;

    mapping(uint256 => string) private s_tokenIdToUri;
    constructor() ERC721("Clawdia", "CLAW") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;

        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[_tokenId];
    }
}
