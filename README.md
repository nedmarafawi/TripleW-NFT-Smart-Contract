<h1 align="center">TripleW NFT - Smart Contract</h1>
<p align="center">Mint Your Own NFT Collection</p>





## 🔖 About The Project
<!-- You know those websites where people are making millions of dollars where users can come and "mint" an NFT? This is basically the project.
Your will let users connect their Ethereum wallet, and mint an NFT to their wallet so they actually own it. They'll even be able to re-sell the NFT on OpenSea. -->
TripleW #01 is an NFT project consisting of 50 randomly generated three-word combination. Each piece is a unique and really funny.

## 💈Mint Site
* You can interact with this Smart Contract <a href="https://triplew-nft.netlify.app/">here</a> <br>
* You can also find the web app code <a href="https://github.com/nedmarafawi/TripleW-NFT-web-app">here</a>

## 🧰 Built with
<ul>
  <li>Solidity</li>
  <li>React.Js</li>
</ul>

## 💻 Instructions 

### Step 1 - Install node & npm
You'll need to get node/npm. If you don't have it head over <a href="https://hardhat.org/tutorial/setting-up-the-environment.html">here</a>.<br>
If you get any sort of ``out of memory errors`` on older versions of node, make sure to get Node 16 instead.<br></br>

### Step 2 - Configure ``hardhat`` config file
You need to set your Alchemy API url, your private key from your Etherum (Rinkeby) wallet and your etherscan API key.
```
hardhat.config.js
```

### Step 3 - Test
Make sure you have ``solidity: "0.8.0"``, in your ``hardhat.config.js``.<br>
```
npx hardhat run scripts/run.js
```

### Step 4 - Deploy
Run this command from the root directory.<br>
```
npx hardhat run scripts/deploy.js --network rinkeby
```
The NFT you just minted will be on <a href="https://testnets.opensea.io/">OpenSea's TestNet</a> site.

### Step 5 - Verify
```
npx hardhat verify {Your awesome contract address} --network rinkeby
```


## ❤️ Thanks

<a href="https://buildspace.so/">Buildspace</a> team, <a href="https://twitter.com/FarzaTV">@Farza</a> and the whole community.

What an amazing project to contribute into the future of web3.

## 📄 License
Distributed under the MIT License. See ``LICENSE`` for more information.
# TripleW-NFT-Smart-Contract
# TripleW-NFT-Smart-Contract
