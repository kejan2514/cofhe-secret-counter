import "@cofhe/hardhat-plugin";
import "@nomicfoundation/hardhat-ethers";

import { HardhatUserConfig } from "hardhat/config";

const config: HardhatUserConfig = {
  solidity: "0.8.25",

  networks: {
    hardhat: {
      hardfork: "cancun",
    },
  },
};

export default config;
