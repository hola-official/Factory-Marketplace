// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

interface Imarketplace {
    function listItem(string memory _name, uint256 _price) external;

    function buyItem(uint256 _itemId) external payable;

    function getItem(
        uint256 _itemId
    )
        external
        view
        returns (
            string memory name,
            uint256 price,
            address seller,
            bool isAvailable
        );

    function getItemCount() external view returns (uint256);

    function getAvailableItems() external view returns (uint256[] memory);
}
