import "@cofhe/hardhat-plugin";
import "@nomicfoundation/hardhat-ethers";

import { HardhatUserConfig } from "hardhat/config";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.25",
    settings: {
      evmVersion: "cancun",
    },
  },

  networks: {
    hardhat: {
      hardfork: "cancun",
    },
  },
};

export default config;
