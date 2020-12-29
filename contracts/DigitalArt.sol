pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/payment/PullPayment.sol";

/// @title An NFTMarketplace for digital art
/// @author Kayode Okunlade
/// @notice This project stores art files on IPFS
/// @dev Implements the circuit breaker design pattern
contract DigitalArt is ERC721, PullPayment{
 uint256 public _tokenIds;
 uint256 public _artItemIds;
 bool private stopped = false;
address private owner;
 mapping(uint256 => ArtItem) private _artItems;

struct ArtItem {
 address seller;
 uint256 price;
 string tokenURI;
 bool exists;
}
    constructor() public ERC721("DigitalArt", "ART" ){
        owner = msg.sender;
    }

    modifier isOwner() {
    require(msg.sender == owner, "You are not the owner");    
    _;
}

modifier stopInEmergency() {
    require(stopped, "Work in Progress");    
    _;
}
modifier onlyInEmergency() {
    require(!stopped, "Emergency function");    
    _;
}

/// circuit breaker function
function circuitBreaker() isOwner public {
    stopped = !stopped;
}

    modifier artItemExist(uint256 id){
        require(_artItems[id].exists, "Item Not Found" );
        _;
    }

function addArtItem(uint256 price, string memory tokenURI )public{
require(price > 0, "Price cannot be 0");
  _artItemIds++;
  _artItems[_artItemIds] = ArtItem(msg.sender, price, tokenURI, true);
}

function getArtItem(uint256 id) public view artItemExist(id) returns (uint256, uint256, string memory){
ArtItem memory artItem = _artItems[id];
return (id, artItem.price, artItem.tokenURI);
}

function purchaseArtItem(uint256 artItemId)
        external
        payable
        stopInEmergency
        artItemExist(artItemId)
    {
        ArtItem storage artItem = _artItems[artItemId];

        require(msg.value >= artItem.price, "Your bid is too low");

        _tokenIds++;

        _safeMint(msg.sender, _tokenIds);
        _setTokenURI(_tokenIds, artItem.tokenURI);
        _asyncTransfer(artItem.seller, msg.value);
    }

function getPayments() external stopInEmergency {
    withdrawPayments(msg.sender);
}
}