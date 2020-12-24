import { ethers } from "ethers";
import { inject } from "vue";

import DigitalArt from "../../../build/contracts/DigitalArt.json";

const ETHERS_INJECTION_KEY = "ETHERS";

const newEthers = () => {
	const provider = new ethers.providers.Web3Provider(window.ethereum);
	const signer = provider.getSigner();

	return new ethers.Contract(
		DigitalArt.networks[5777].address,
		DigitalArt.abi,
		signer
	);
};

function UseEthers() {
	const ethers = inject(ETHERS_INJECTION_KEY);

	if (!ethers) {
		throw new Error("Ethers contract instance not found");
	}

	return ethers;
}

export { ETHERS_INJECTION_KEY, newEthers, UseEthers };
