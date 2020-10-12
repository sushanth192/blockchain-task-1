pragma solidity ^0.5.0;

contract SalaryDemo {
    
    address payable owner;
    uint salary;
    address payable[] employee;
    mapping (address  => uint) eSalary;
    event LogDeposit(uint hello, address accountAddress) ;
    event strr(string mess);
    
    constructor() public payable {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function setSalary(address payable addr, uint amount) public onlyOwner {
        employee.push(addr);
        eSalary[addr] = amount;
    }
    
    function getSalary() payable public{
        uint sum = 0;
        for(uint i=0; i<employee.length; i++) {
            sum += eSalary[employee[i]];
            emit LogDeposit(eSalary[employee[i]], employee[i]);   
        }
        emit strr("sum is");
        emit LogDeposit(sum, msg.sender);
    }
    
    function payout() public payable {  
        for(uint i=0; i<employee.length; i++) {
            employee[i].transfer(convertToEther(eSalary[employee[i]]));
        }
    }
    
    function getOwner() public view returns(address) {
        return owner;
    }
    
    function convertToEther(uint amount) private pure returns(uint) {
        return amount * 1000000000000000000;    //1 Ether = 1000000000000000000 Wei
    }
}
