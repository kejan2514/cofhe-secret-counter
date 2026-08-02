import { ethers } from "hardhat";

async function main() {
  console.log("Deploying SecretCounter...");

  const SecretCounter = await ethers.getContractFactory("SecretCounter");

  const counter = await SecretCounter.deploy(0);

  await counter.waitForDeployment();

  console.log("SecretCounter deployed to:");
  console.log(await counter.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
