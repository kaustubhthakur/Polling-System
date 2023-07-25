const { expect } = require("chai");

describe("Polling", (async) => {
  let polling;
  let owner;
  let addr1;
  it("polling contract deployment", async function () {
    owner = await ethers.getSigners();
   polling = await ethers.deployContract("Polling");
  });
  it("should create a poll by owner", async () => {
    const tx = await polling.createPoll("No colleges");
    const ans = await tx.wait();
    /*const poll = ans.events.find(
      (e) => e.event == "PollCreated");
    expect(poll).to.not.be.undefined;
    expect(poll.args.totalqueries).to.equal(1);*/
  })
  it("should vote on a query",async () => {
    await polling.createPoll("TEST POLL")
   await polling.connect(addr1).vote(0);
  })
})