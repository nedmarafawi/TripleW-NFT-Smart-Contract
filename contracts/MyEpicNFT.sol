// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// Import OpenZeppelin contracts
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import {Base64} from "./libraries/Base64.sol";

// Getting access to the inherited contract methods
contract MyEpicNFT is ERC721URIStorage {
    // Helps us to keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 private _totalSupply = 50;

    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // Create random words
    string[] firstWords = [
        "Interstellar",
        "Tenet",
        "Dunkirk",
        "Dune",
        "Scarface",
        "Matrix"
    ];
    string[] secondWords = [
        "Tesla",
        "Porsche",
        "Audi",
        "Jaguar",
        "Bentley",
        "Maserati"
    ];
    string[] thirdWords = [
        "xQc",
        "Summit1G",
        "Silent",
        "Pestily",
        "Ramee",
        "Sequisha"
    ];

    event NewEpicNFTMinted(address sender, uint256 tokenId);

    // passing the name of our NFT token and it's symbol
    constructor() ERC721("SqaureNFT", "SQUARE") {
        console.log("My first ever Epic NFT!");
    }

    function getTotalNFTsMintedCount() public view returns (uint256) {
        return _tokenIds.current();
    }

    // Pick random words from each array
    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        // Squash the # between 0 and the length of the array to avoid going out of bounds
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // A function for our user to hit and get their NFT
    function makeAnEpicNFT() public {
        // Get the current tokenId(this starts at 0)
        uint256 newItemId = _tokenIds.current();

        require(
            _totalSupply > newItemId,
            "SOLD OUT: There's a mint limite of 50 NFTs"
        );

        // Grab one random word from each of the three arrays
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory combinedWord = string(
            abi.encodePacked(first, second, third)
        );

        // Add random color
        // string memory randomColor = pickRandomColor(newItemId);
        string memory finalSvg = string(
            abi.encodePacked(baseSvg, combinedWord, "</text></svg>")
        );

        // Get all the JSON metadata in place and base64 encode it
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Prepend data:application/json;base64 to our data
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(
            string(
                abi.encodePacked(
                    "https://nftpreview.0xdev.codes/?code=",
                    finalTokenUri
                )
            )
        );
        console.log("--------------------\n");

        // Mint the NFT to the sender using msg.sender
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data
        // JSON metadata https://jsonkeeper.com/ using imgur
        _setTokenURI(newItemId, finalTokenUri);

        // Increment the counter for when the next NFT is minted
        _tokenIds.increment();
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );
        // Magical event
        emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}
