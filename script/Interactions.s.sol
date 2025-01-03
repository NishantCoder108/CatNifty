//SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {ClawdiaNFT} from "../src/ClawdiaNFT.sol";

contract MintClawdiaNFT is Script {
    string public constant tokenURI =
        "ipfs://bafybeibvh5omk6v5mjpi6chrv32argabppynruxvzgdrkjm53rjamp4v2i/1188.json";
    // "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    // "https://ipfs.io/ipfs/bafybeibvh5omk6v5mjpi6chrv32argabppynruxvzgdrkjm53rjamp4v2i/1188.json";
    // "ipfs://bafybeibvh5omk6v5mjpi6chrv32argabppynruxvzgdrkjm53rjamp4v2i/1188.json";
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "ClawdiaNFT",
            block.chainid
        );

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();

        ClawdiaNFT(contractAddress).mintNFT(tokenURI);

        vm.stopBroadcast();
    }
}
