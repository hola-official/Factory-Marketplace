// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;
import "./Imarketplace.sol";
import "./Marketplace.sol";

contract FactoryMarketplace {
    struct DeployedContractInfo {
        address deployer;
        address deployedContract;
    }

    mapping(address => DeployedContractInfo[]) allUserDeployedContracts;

    DeployedContractInfo[] allContracts;

    function deployMarketplace() external returns (address contractAdress_) {
        require(msg.sender != address(0), "Zero not allowed");
        address _address = address(new Marketplace());
        contractAdress_ = _address;

        DeployedContractInfo memory _deployedContract;
        _deployedContract.deployer = msg.sender;
        _deployedContract.deployedContract = _address;

        allUserDeployedContracts[msg.sender].push(_deployedContract);

        allContracts.push(_deployedContract);
    }

    function getAllContractDeployed()
        external
        view
        returns (DeployedContractInfo[] memory)
    {
        require(msg.sender != address(0), "Zero not allowed");
        return allContracts;
    }

    function getUserDeployedContracts()
        external
        view
        returns (DeployedContractInfo[] memory)
    {
        require(msg.sender != address(0), "Zero not allowed");
        return allUserDeployedContracts[msg.sender];
    }

    function getUserDeployedContractsByIndex(
        uint8 _index
    ) external view returns (address deployer_, address deployedContract_) {
        require(msg.sender != address(0), "Zero not allowed");
        require(
            _index < allUserDeployedContracts[msg.sender].length,
            "Out of bound"
        );

        DeployedContractInfo
            memory _deployedContract = allUserDeployedContracts[msg.sender][
                _index
            ];

        deployer_ = _deployedContract.deployer;
        deployedContract_ = _deployedContract.deployedContract;
    }

    function getLengthOfDeployedContracts() external view returns (uint256) {
        require(msg.sender != address(0), "Zero not allowed");
        uint256 lens = allContracts.length;

        return lens;
    }

    function listItemFromContract(
        address _contractAddr,
        string memory _name,
        uint256 _price
    ) external {
        return Imarketplace(_contractAddr).listItem(_name, _price);
    }

    function buyItemFromContract(
        address _contractAddr,
        uint256 _itemId
    ) external payable {
        return Imarketplace(_contractAddr).buyItem(_itemId);
    }

    function getItemFromContract(
        address _contractAddr,
        uint256 _itemId
    )
        external
        view
        returns (
            string memory name,
            uint256 price,
            address seller,
            bool isAvailable
        )
    {
        return Imarketplace(_contractAddr).getItem(_itemId);
    }

    function getItemCountFromContract(
        address _contractAddr
    ) external view returns (uint256) {
        uint256 itemCount = Imarketplace(_contractAddr).getItemCount();
        return itemCount;
    }

    function getAvailableItemsFromContract(
        address _contractAddr
    ) external view returns (uint256[] memory) {
        return Imarketplace(_contractAddr).getAvailableItems();
    }
}
