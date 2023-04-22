// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .3 ether);
        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(block.difficulty, block.timestamp, players)
                )
            );
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    function pickWinner() public restricted {
        uint index = random() % players.length;
        payable(players[index]).transfer(address(this).balance);
        players = new address[](0);
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
}

//contract Nested {
//string[] public myArray;

//constructor(){
//    myArray.push('Hi');
// }

// function getMyArray() public view returns (string[] memory) {
//     return myArray;
//  }
//}
