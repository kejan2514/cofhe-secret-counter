// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {
    FHE,
    euint64,
    InEuint64
} from "@fhenixprotocol/cofhe-contracts/FHE.sol";

/**
 * @title SecretCounter
 * @notice A privacy-preserving encrypted counter built with CoFHE.
 * @dev The counter remains encrypted while arithmetic operations are performed.
 */
contract SecretCounter {
    address public owner;

    euint64 private counter;
    euint64 private delta;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the owner can access this function"
        );
        _;
    }

    constructor(uint64 initialValue) {
        owner = msg.sender;

        counter = FHE.asEuint64(initialValue);
        FHE.allowThis(counter);
        FHE.allow(counter, owner);

        // Store encrypted 1 once and reuse it.
        delta = FHE.asEuint64(1);
        FHE.allowThis(delta);
    }

    /**
     * @notice Increase the encrypted counter by one.
     */
    function increment() external onlyOwner {
        counter = FHE.add(counter, delta);

        FHE.allowThis(counter);
        FHE.allow(counter, owner);
    }

    /**
     * @notice Decrease the encrypted counter by one.
     */
    function decrement() external onlyOwner {
        counter = FHE.sub(counter, delta);

        FHE.allowThis(counter);
        FHE.allow(counter, owner);
    }

    /**
     * @notice Replace the counter with a client-side encrypted value.
     */
    function reset(InEuint64 calldata encryptedValue) external onlyOwner {
        counter = FHE.asEuint64(encryptedValue);

        FHE.allowThis(counter);
        FHE.allow(counter, owner);
    }

    /**
     * @notice Return the encrypted counter handle.
     * @dev The authorized owner can decrypt it privately using decryptForView.
     */
    function getEncryptedCounter() external view returns (euint64) {
        return counter;
    }

    /**
     * @notice Allow the current counter value to be publicly decrypted.
     * @dev Once revealed and published, the plaintext becomes public.
     */
    function allowPublicDecryption() external onlyOwner {
        FHE.allowPublic(counter);
    }

    /**
     * @notice Verify and publish a public decryption result.
     */
    function revealCounter(
        uint64 decryptedValue,
        bytes calldata signature
    ) external {
        FHE.publishDecryptResult(
            counter,
            decryptedValue,
            signature
        );
    }

    /**
     * @notice Read the publicly revealed counter value.
     */
    function getRevealedCounter() external view returns (uint256) {
        (uint256 value, bool decrypted) =
            FHE.getDecryptResultSafe(counter);

        require(decrypted, "Counter has not been revealed");

        return value;
    }
}
