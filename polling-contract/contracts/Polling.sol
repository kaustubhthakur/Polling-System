// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract Polling {
    address public owner;

    constructor() {
        owner = msg.sender;
        console.log("welcome to polling system ,Fellas!!!!!!");
    }

    uint256 public totalvotes;
    struct Voter {
        uint256 Id;
        bool voted;
        uint256 timestamp;
    }
    mapping(address => Voter) public voters;
    struct Decision {
        uint256 Id;
        string query;
        uint256 votes;
    }
    modifier onlyOwner() {
        require(owner == msg.sender, "not owner");
        _;
    }
    uint256 public totalQueries;
    uint256 public queryId;
    Decision[] public decisions;
    event PollCreated(uint256 timestamp, uint256 totalqueries);

    function createPoll(string memory _query) public onlyOwner {
        Decision memory decision = Decision({
            Id: queryId,
            query: _query,
            votes: 0
        });
        decisions.push(decision);
        queryId++;
        totalQueries++;
        emit PollCreated(block.timestamp, queryId);
    }

    function vote(uint256 _Id) public {
        Voter storage voter = voters[msg.sender];
        require(!voter.voted, "voter already votes");

        decisions[_Id].votes++;
        totalvotes++;
        voter.voted = true;
    }

    uint256[] private QueryId;

    function getQueryWithMaxVotes()
        public
        view
        returns (uint256, uint256, string memory)
    {
        uint256 maxAns = 0;
        uint256 Id = 0;
        string memory query;
        for (uint256 i = 0; i < decisions.length; i++) {
            if (maxAns < decisions[i].votes) {
                query = decisions[i].query;
                maxAns = decisions[i].votes;
                Id = i;
            }
        }

        return (maxAns, Id, query);
    }

    function getTotalVotes() public view returns (uint256) {
        return totalvotes;
    }
}
