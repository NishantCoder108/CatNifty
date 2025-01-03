//SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import {ClawdiaNFT} from "../src/ClawdiaNFT.sol";
import {DeployClawdiaNFT} from "../script/DeployClawdiaNFT.s.sol";

contract ClawdiaNFTTest is Test {
    ClawdiaNFT public clawdiaNFT;
    DeployClawdiaNFT public deployer;

    address public user = makeAddr("user");
    string public constant TOKENURI =
        // "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
        "https://ipfs.io/ipfs/bafybeibvh5omk6v5mjpi6chrv32argabppynruxvzgdrkjm53rjamp4v2i/1188.json";

    // Setup of test
    function setUp() public {
        //Deployed contract
        deployer = new DeployClawdiaNFT();
        clawdiaNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Clawdia";
        string memory actualName = clawdiaNFT.name();

        // assertEq(actualName, expectedName);

        //abi.encodePacked will convert to bytes
        //keccak256 will hash the bytes into bytes32

        assert(
            keccak256(abi.encodePacked(actualName)) ==
                keccak256(abi.encodePacked(expectedName))
        );
    }

    function testCanMintAndBalance() public {
        address account1 = makeAddr("Ram");
        address account2 = makeAddr("shayam");

        //minting token for account
        vm.prank(account1);
        clawdiaNFT.mintNFT(TOKENURI);

        vm.prank(account2);
        clawdiaNFT.mintNFT(TOKENURI);

        assert(clawdiaNFT.balanceOf(account1) == 1);
        assert(clawdiaNFT.balanceOf(account2) == 1);
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(user);
        clawdiaNFT.mintNFT(TOKENURI);

        assert(clawdiaNFT.balanceOf(user) == 1);
        assert(
            keccak256(abi.encodePacked(TOKENURI)) ==
                keccak256(abi.encodePacked(clawdiaNFT.tokenURI(0)))
        );
    }

    function testOwnerOfMintedToken() public {
        vm.prank(user);
        clawdiaNFT.mintNFT(TOKENURI);

        assertEq(clawdiaNFT.ownerOf(0), user);
    }

    function testCannotMintSameTokenIdTwice() public {
        vm.prank(user);
        clawdiaNFT.mintNFT(TOKENURI);

        vm.expectRevert("ERC721: token already minted");
        vm.prank(user);
        clawdiaNFT.mintNFT(TOKENURI); // Attempt to mint same token ID
    }

    function testTokenUriMatchesMintedToken() public {
        vm.prank(user);
        clawdiaNFT.mintNFT(TOKENURI);

        string memory actualTokenUri = clawdiaNFT.tokenURI(0);
        assertEq(
            keccak256(abi.encodePacked(actualTokenUri)),
            keccak256(abi.encodePacked(TOKENURI))
        );
    }

    function testBalanceIncreasesAfterMinting() public {
        vm.prank(user);
        uint256 initialBalance = clawdiaNFT.balanceOf(user);

        clawdiaNFT.mintNFT(TOKENURI);
        uint256 newBalance = clawdiaNFT.balanceOf(user);

        assertEq(newBalance, initialBalance + 1);
    }

    function testCannotQueryNonExistentToken() public {
        vm.expectRevert("ERC721: invalid token ID");
        clawdiaNFT.tokenURI(999); // Query a non-existent token ID
    }

    function testMintedTokenOwnershipIsTransferred() public {
        address minter = makeAddr("Minter");
        vm.prank(minter);
        clawdiaNFT.mintNFT(TOKENURI);

        assertEq(clawdiaNFT.ownerOf(0), minter);
    }

    function testTokenCounterIncrements() public {
        vm.prank(user);
        clawdiaNFT.mintNFT(TOKENURI);

        vm.prank(user);
        clawdiaNFT.mintNFT(TOKENURI);

        assertEq(clawdiaNFT.balanceOf(user), 2);
    }

    function testCannotMintFromZeroAddress() public {
        vm.expectRevert("ERC721: mint to the zero address");
        vm.prank(address(0));
        clawdiaNFT.mintNFT(TOKENURI);
    }
}
