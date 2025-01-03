// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {ClawdiaNFT} from "../src/ClawdiaNFT.sol";
import "forge-std/Script.sol";

contract DeployClawdiaNFT is Script {
    function run() external returns (ClawdiaNFT) {
        vm.startBroadcast();
        ClawdiaNFT clawdiaNFT = new ClawdiaNFT();

        vm.stopBroadcast();
        return clawdiaNFT;
    }
}
