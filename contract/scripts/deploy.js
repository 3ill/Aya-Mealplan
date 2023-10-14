const { ethers } = require('hardhat');

const main = async () => {
  let name = 'Meal Plan';
  let options = ['Rice', 'Beans', 'Garri'];

  const Week3 = await ethers.getContractFactory('Wk3');
  const wk3 = await Week3.deploy(name, options);
  await wk3.waitForDeployment();

  console.log(`Contract deployed at ${await wk3.getAddress()}`);
};

main().catch((error) => {
  console.error(error, 'An error occurred');
  process.exitCode = 0;
});
