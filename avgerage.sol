// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AverageGasPrice {
uint256[] public gasPrices;
uint256 public startTime;
uint256 public endTime;
uint256 public averageGasPrice;

constructor(uint256 _startTime, uint256 _endTime) {
    startTime = _startTime;
    endTime = _endTime;
}

function addGasPrice(uint256 gasPrice) public {
    require(block.timestamp >= startTime && block.timestamp <= endTime, "Not within the specified time period");
    require(gasPrice > 0, "Gas price must be greater than 0");
    gasPrices.push(gasPrice);
}

function calculateAverageGasPrice() public {
    require(gasPrices.length > 0, "No gas prices added yet");
    uint256 totalGasPrice = 0;
    for (uint256 i = 0; i < gasPrices.length; i++) {
        totalGasPrice += gasPrices[i];
    }
    averageGasPrice = totalGasPrice / gasPrices.length;
}

function calculateGasPrice() private view returns (uint256) {
    return tx.gasprice;
}

function transfer(address recipient, uint256 amount) public {
    require(msg.sender != address(0), "Invalid sender address");
    require(amount > 0, "Invalid amount");

    // Calculate the gas price for the transfer.
    uint256 gasPrice = calculateGasPrice();

    // Transfer the amount to the recipient.
    payable(recipient).transfer(amount);

    // Add the gas price to the gas prices array.
    addGasPrice(gasPrice);
}

function deposit() public payable {
    require(msg.sender != address(0), "Invalid sender address");
    require(msg.value > 0, "Invalid amount");

    // Calculate the gas price for the deposit.
    uint256 gasPrice = calculateGasPrice();

    // Add the gas price to the gas prices array.
    addGasPrice(gasPrice);
}
}