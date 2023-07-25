require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()
module.exports = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      url: process.env.API_KEY,//your api key
      accounts: [process.env.PRIVATE_KEY]//your address private key
    }
  }
};
