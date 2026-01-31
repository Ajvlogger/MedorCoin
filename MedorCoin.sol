// SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

/*
    MedorCoin (MEDOR)
    - Fixed supply: 21,000,000
    - No owner
    - No minting after deployment
    - No taxes
    - Immutable after deployment
*/

contract MedorCoin {
    string public name = "MedorCoin";
    string public symbol = "MEDOR";
    uint8 public constant decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Constructor: mint fixed supply to deployer
    constructor() {
        uint256 initialSupply = 21_000_000 * 10 ** decimals;
        totalSupply = initialSupply;
        balanceOf[msg.sender] = initialSupply;
        emit Transfer(address(0), msg.sender, initialSupply);
    }

    // Transfer tokens
    function transfer(address to, uint256 amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    // Approve spender
    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // Transfer tokens from another account
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        require(balanceOf[from] >= amount, "Insufficient balance");
        require(allowance[from][msg.sender] >= amount, "Allowance exceeded");
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }
}
