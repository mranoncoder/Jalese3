pragma solidity 0.8.13;

contract Jalese3 {

    uint minimumSeneUser = 18;
    uint256 price = 1 ether; // 100000000000000000
    address owner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266; //0x78748dSijdwji

    struct dataman{
        string esm;
        uint sen;
    }
    mapping(address => dataman) private _dataHeiUser;

    function taghirEsm(string memory _esm, uint _sen) public payable {
        require(_sen >= minimumSeneUser,"Sene user ghabel ghabul nist!");
        require(msg.value >= price ,"Ehter ke ferestadid kam hast!");

        _dataHeiUser[msg.sender].esm = _esm;
        _dataHeiUser[msg.sender].sen = _sen;
    }

    function getEsm() public view returns(string memory){
        return _dataHeiUser[msg.sender].esm;
    }

    function getSen() public view returns(uint){
        return _dataHeiUser[msg.sender].sen;
    }
    function withdraw() public {
        require(msg.sender == owner,"you are not the owner");
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

}
