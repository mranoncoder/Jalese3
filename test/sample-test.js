const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Jalese 3", function () {
  let Jalese3;
  let owner;
  let address1;
  let address2;

  beforeEach(async function () {
    Jalese3 = await ethers.getContractFactory("Jalese3");
    [owner, address1,address2] = await ethers.getSigners();
    Jalese3 = await Jalese3.deploy();
    await Jalese3.deployed();
  })

  it("esme user hast Abolfazl!", async function () {
    const options = {value: ethers.utils.parseEther("2.0")};
    await Jalese3.taghirEsm("Abolfazl", 19, options);
    console.log("Balance of Owner: ", ethers.BigNumber.from(await owner.getBalance()).toString());
    const jaleseAddress = Jalese3.address;

    console.log("Balance: ", ethers.BigNumber.from(await ethers.provider.getBalance(jaleseAddress)).toString());
    await Jalese3.withdraw();
    console.log("Balance: ", ethers.BigNumber.from(await owner.getBalance()).toString());
    expect(await Jalese3.getEsm()).to.equal("Abolfazl");


  });


});
