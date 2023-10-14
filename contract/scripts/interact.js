const { ethers } = require('hardhat');
require('dotenv').config();

const { URL, PRIVATE_KEY, CONTRACT_ADDRESS } = process.env;

const provider = new ethers.JsonRpcProvider(URL);
const signer = new ethers.Wallet(PRIVATE_KEY, provider);

const main = async () => {
  const wk3 = await ethers.getContractAt('Wk3', CONTRACT_ADDRESS, signer);

  const getMenus = await wk3.getMenuItems();
  getMenus.map((menu) => console.log(menu.name, menu.voteCount));
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
