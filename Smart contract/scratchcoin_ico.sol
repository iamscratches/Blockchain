// Scratchcoin ICO

// version of the compiler
pragma solidity ^0.4.11;

contract scratchcoin_ico {
    
    // Introducing the maximum no. of scratchcoin available for sale
    uint public max_scratchcoin = 1000000;
    
    // Introducing the USD to scratchcoin conversion rate
    uint public usd_to_scratchcoin = 1000;
    
    // Introducing the total number of scratchcoin that has been bought by the investors
    uint public total_scratchcoin_bought = 0;
    
    // Mapping from the investor address to its equity in scratchcoin and USD
    mapping(address => uint) equity_scratchcoin;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy scratchcoin
    modifier can_buy_scratchcoin(uint usd_invested){
        require (usd_invested * usd_to_scratchcoin + total_scratchcoin_bought <=max_scratchcoin);
        _;
    }
    
    // Getting the equity in scratchcoin of an investor
    function equity_in_scratchcoin(address investor) external constant return (uint) {
        return equity_scratchcoin[investor];
    }
    
    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant return (uint) {
        return equity_usd[investor];
    }
    
    // Buying scratchcoin
    function buy_scratchcoin(address investor, uint usd_invested) external
    can_buy_scratchcoin(usd_invested){
        uint scratchcoin_bought = usd_invested * usd_to_scratchcoin;
        equity_scratchcoin[investor] += scratchcoin_bought;
        equity_usd[investor] = equity_scratchcoin[investor] / 1000;
        total_scratchcoin_bought += scratchcoin_bought;
    }
    
    // Selling scratchcoin
    function sell_scratchcoin(address investor, uint scratchcoin_sold) external {
        equity_scratchcoin[investor] -= scratchcoin_sold;
        equity_usd[investor] = equity_scratchcoin[investor] / 1000;
        total_scratchcoin_bought -= scratchcoin_sold;
    }
}