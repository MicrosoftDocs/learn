[Ethereum Improvement Proposals](https://eips.ethereum.org/) (EIPs) describe standards for the Ethereum platform, including core protocol specifications, client APIs, and contract standards. What this means is that community members can make proposals of new standards for every part of the platform.

Token standards in particular are defined in what's called [Ethereum Request for Comments](https://eips.ethereum.org/erc) or ERC for short. While new standards are continuously being proposed and accepted, there are primary ERC types that have been adopted widely.

Those four token standards are:

- **ERC20**
- **ERC721**
- **ERC777**
- **ERC1155**

Let's explore each type of token, taking a moment to understand what makes each one significant and unique.

## ERC20

The most widely known and used token is the [ERC20](https://eips.ethereum.org/EIPS/eip-20). ERC20 is the technical standard used for smart contracts on the Ethereum blockchain for token implementation. It has a simple interface for basic tokens.

An ERC20 token contract keeps track of fungible tokens: any one token is exactly equal to any other token; no tokens have special rights or behavior associated with them. This makes ERC20 tokens useful for things like: currency exchange, voting rights, or staking.

## ERC721

[ERC721](https://eips.ethereum.org/EIPS/eip-721) is the top solution for non-fungible tokens, often referred to as NFTs for short. Like all other tokens, NFTs represent ownership of both virtual and physical assets. These assets might likely include the following:

- Collectible items like antiques, cards, or art
- Physical assets like houses or cars
- Negative value assets like loans

Each token is unique and has ownership and status which must be tracked.

The ERC721 token is a more complex standard than ERC20. Where the core functions have some similarities, each one has function arguments that specify the token ID.

## ERC777

[ERC777](https://eips.ethereum.org/EIPS/eip-777) is a richer standard for fungible tokens, enabling new use cases and building on learnings from previous token standards. It is backwards compatible with ERC20, which means that you can interact with these tokens as if they were ERC20. ERC777 allows more complex interactions when trading tokens.

## ERC1155

[ERC1155](https://eips.ethereum.org/EIPS/eip-1155) is a standard for managing multi-token types, allowing for a single contract to represent multiple fungible and non-fungible tokens.

ERC1155 draws on ideas from ERC20, ERC721, and ERC777.

The design of this token type allow for massive gas savings for a couple different reasons. First, because you can use this token contract for multiple tokens, this means less deployments with less complexity. It also has batched operations which means a single function call can be simpler and less gas-intensive.
