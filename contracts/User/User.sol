pragma solidity ^0.4.0;


import './UserInterface.sol';


contract User is UserInterface {
    mapping (address => string) public userNames;

    function setUsername(string username) {
        if (bytes(username).length < 6) {// не даем поставить логин меньше 6 байтов
            throw;
        }
        userNames[msg.sender] = username;
    }

    function getUsername(address acc) constant returns (string) {
        return userNames[acc];
    }
}

