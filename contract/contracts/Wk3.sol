// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Wk3 {
    event NewMenu(uint256 indexed id, string name);

    address public owner;
    uint256 public idCounter = 0;
    uint256[] private keys;

    mapping(address => mapping(uint => bool)) public hasVoted;
    mapping(uint256 => Menu) private allMenus;

    constructor() {
        owner = msg.sender;
    }

    struct Menu {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier hasNotVoted(uint _id) {
        require(!hasVoted[msg.sender][_id], "You have already voted");
        _;
    }

    modifier validKey(uint256 _id) {
        require(_id >= 0 && _id < keys.length, "Invalid option");
        _;
    }

    modifier blankCompliance(string memory _option) {
        require(bytes(_option).length > 0, "Field cannot be empty");
        _;
    }

    function createMenu(
        string memory _name
    ) external blankCompliance(_name) onlyOwner {
        uint256 id = idCounter++;
        Menu memory newMenu = Menu({id: id, name: _name, voteCount: 0});

        allMenus[id] = newMenu;
        keys.push(id);

        emit NewMenu(id, _name);
    }

    function getMenuItems() external view returns (Menu[] memory) {
        uint256 menuCount = idCounter;
        Menu[] memory menus = new Menu[](menuCount);

        for (uint256 i = 0; i < menuCount; i++) {
            menus[i] = allMenus[i];
        }

        return menus;
    }

    function vote(uint256 _id) external validKey(_id) hasNotVoted(_id) {
        allMenus[_id].voteCount++;
        hasVoted[msg.sender][_id] = true;
    }

    function endVoting() external onlyOwner {
        // Consider alternative contract termination or ownership transfer logic
        // selfdestruct(payable(owner));
    }
}
