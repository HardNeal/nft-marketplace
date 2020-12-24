const DigitalArts = artifacts.require("DigitalArt");

module.exports = function (deployer) {
  deployer.deploy(DigitalArts);
};
