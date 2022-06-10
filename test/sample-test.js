const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Jalese 3", function () {
  let Jalese4;
  let owner;
  let address1;
  let address2;

  beforeEach(async function () {
    Jalese4 = await ethers.getContractFactory("Jalese4");
    [owner, address1,address2] = await ethers.getSigners();
    Jalese4 = await Jalese4.deploy(owner.address, 10);
    await Jalese4.deployed();
  })

  it("esme user hast Abolfazl!", async function () {
    await Jalese4.makeOnline();
    const options = {value: ethers.utils.parseEther("10.0")};
    await Jalese4.taghirEsm("Abolfazl", 19, options);

    console.log("Balance of Owner: ", ethers.BigNumber.from(await owner.getBalance()).toString());
    const jaleseAddress = Jalese4.address;

    console.log("Balance: ", ethers.BigNumber.from(await ethers.provider.getBalance(jaleseAddress)).toString());
    await Jalese4.withdraw();
    console.log("Balance: ", ethers.BigNumber.from(await owner.getBalance()).toString());
    expect(await Jalese4.getEsm()).to.equal("Abolfazl");
  });


  it("Make the second account owner", async function () {
    await Jalese4.addOwner(address1.address);
    await Jalese4.addOwner(address2.address);
    expect(await Jalese4.isOwnerCheck(address2.address)).to.equal(true);
  });


});
