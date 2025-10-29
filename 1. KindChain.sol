// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KindChain {
    address public owner;

    struct Appreciation {
        address from;
        string message;
        uint256 value;
    }

    mapping(address => Appreciation[]) public receivedNotes;
    uint256 public totalNotes;

    event Appreciated(address indexed from, address indexed to, uint256 value, string message);

    constructor() {
        owner = msg.sender;
    }

    function sendAppreciation(address _to, string calldata _message) public payable {
        require(msg.value > 0, "Please send some tCORE to show appreciation");
        Appreciation memory note = Appreciation(msg.sender, _message, msg.value);
        receivedNotes[_to].push(note);
        totalNotes++;
        emit Appreciated(msg.sender, _to, msg.value, _message);
    }

    function getReceivedNotes(address _user) public view returns (Appreciation[] memory) {
        return receivedNotes[_user];
    }

    function getTotalNotes() public view returns (uint256) {
        return totalNotes;
    }
}