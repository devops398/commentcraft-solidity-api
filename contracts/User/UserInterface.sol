pragma solidity ^0.4.0;


contract UserInterface {
    function setUsername(string username);

    function getUsername(address acc) constant returns (string);
}
