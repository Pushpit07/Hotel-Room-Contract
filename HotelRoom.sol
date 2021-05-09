pragma solidity ^0.6.0;

contract HotelRoom {
    
    enum Statuses { Vacant, Occupied }
    Statuses currentStatus;
    
    address payable public owner;
    
    constructor() public {
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }
    
    event Occupy(address _occupant, uint _value);
    
    modifier onlyWhileVacant() {
        // Check Status
        require(currentStatus == Statuses.Vacant, "Currently occupied!");
        _;
    }
    
    modifier costs(uint _amount) { 
        // Check Price
        require(msg.value >= _amount, "Not enough Ether");
        _;
    }
    
    receive() external payable onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);  
        emit Occupy(msg.sender, msg.value);
    }
}
