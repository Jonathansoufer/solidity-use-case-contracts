// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.4;

contract Voting {
    address public assignee;
    string public agenda;
    bool reEntrancyMutex = false;

    enum Options { AGREE, DISAGREE, NULL, ABSTENT }

    mapping(Options => address[]) vote;
    mapping(address => bool) residents;

    constructor(string memory _agenda){
        assignee = msg.sender;
        agenda = _agenda;
    }

    function voting(Option _option) public {
        require(!reEntrancyMutex);
        require(!residents[msg.sender], "A vote was already registered for this resident");
        residents[msg.sender] = true;
        reEntrancyMutex = true;
        vote[_option].push(msg.sender);
        reEntrancyMutex = false; 
    }

    function checkVotingResult(Option _option) public view returns (address[] memory){
        return (vote[_option]);
    }
}