pragma solidity 0.8.13;

contract Jalese4 {

    uint minimumSeneUser = 18;
    uint256 price;
    uint changingNameUsers = 0;
    struct dataman{
        string esm;
        uint sen;
    }
    enum State {offline,online}
    State public state; // state.online

    mapping(address => dataman) private _dataHeiUser;
    mapping(address => bool) private listOwner;
    mapping(address => bool) private listUsers;

    constructor(address _owner, uint256 _price){
        listOwner[_owner] = true;
        price = _price * 1 ether; // 100000000000000000
        state = State.offline;
    }
    modifier onlyOwner(){
        require(listOwner[msg.sender],"you are not the owner");
        _; // true
    }
    function addOwner(address _owner) public onlyOwner{
        listOwner[_owner] = true;
    }
    function removeOwner(address _owner) public onlyOwner{ // moshkel security
            listOwner[_owner] = false;
    }
    function makeOnline() public onlyOwner{
        state = State.online;
    }
    function isOwnerCheck(address _owner) public view returns(bool){
        return listOwner[_owner];
    }
    function taghirEsm(string memory _esm, uint _sen) public payable {
        require(state == State.online,"contract is offline");
        require(listUsers[msg.sender] == false,"You alredy changed your name");
        require(_sen >= minimumSeneUser,"Sene user ghabel ghabul nist!");
        require(msg.value >= price ,"Ehter ke ferestadid kam hast!");
        incrementPeople();

        listUsers[msg.sender] = true;
        _dataHeiUser[msg.sender].esm = _esm;
        _dataHeiUser[msg.sender].sen = _sen;
    }

    function incrementPeople() internal{
        changingNameUsers += 1;
    }
    function getEsm() public view returns(string memory){
        return _dataHeiUser[msg.sender].esm;
    }

    function getSen() public view returns(uint){
        return _dataHeiUser[msg.sender].sen;
    }
    function withdraw() public onlyOwner{
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

}
