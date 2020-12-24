pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/payment/PullPayment.sol";
contract DigitalArt is ERC721, PullPayment{
 uint256 public _tokenIds;
 uint256 public _artItemIds;
 mapping(uint256 => ArtItem) private _artItems;

struct ArtItem {
 address seller;
 uint256 price;
 string tokenURI;
 bool exists;
}
    constructor() public ERC721("DigitalArt", "ART" ){}

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

function purchaseArtItem(uint256 artItemId) external payable artItemExist(artItemId) {
  ArtItem storage artItem = _artItems[artItemId];
  require(msg.value >= artItem.price, "Your bid is too low");
  _safeMint(msg.sender, _tokenIds);
  _setTokenURI(_tokenIds,artItem.tokenURI);
  _asyncTransfer(artItem.seller,msg.value);
}

function getPayments() external {
    withdrawPayments(msg.sender);
}
}