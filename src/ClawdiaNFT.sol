// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ClawdiaNFT is ERC721 {
    uint256 private s_tokenCounter;

    mapping(uint256 => string) private s_tokenIdToUri;
    mapping(string => uint256) private s_uriToTokenId;
    constructor() ERC721("Clawdia", "CLAW") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public {
        require(bytes(tokenUri).length > 0, "Token URI cannot be empty");

        // require(
        //     bytes(s_tokenIdToUri[s_tokenCounter]).length == 0,
        //     "Token ID already minted"
        // );
        require(s_uriToTokenId[tokenUri] == 0, "Token URI already minted");

        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        s_uriToTokenId[tokenUri] = 1;

        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        require(
            bytes(s_tokenIdToUri[_tokenId]).length > 0,
            "ERC721: invalid token ID"
        );
        require(
            ownerOf(_tokenId) != address(0),
            "ERC721: owner query for nonexistent token"
        );

        return s_tokenIdToUri[_tokenId];
    }
}
