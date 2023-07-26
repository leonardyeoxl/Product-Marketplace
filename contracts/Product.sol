// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Product {
  struct Item {
    uint id;
    address owner;
    string name;
    string description;
    uint price;
    bool purchased;
  }

  mapping(uint => Item) public items;
  uint public itemCount;

  function createItem(string memory _name, string memory _description, uint _price) public {
    items[itemCount] = Item(itemCount, msg.sender, _name, _description, _price, false);
    itemCount++;
  }

  function buyItem(uint _id) public payable {
    require(msg.value >= items[_id].price, "Not enough Ether sent");
    require(!items[_id].purchased, "Item already purchased");

    items[_id].owner = msg.sender;
    items[_id].purchased = true;
  }
}
