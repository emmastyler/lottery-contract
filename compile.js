const path = require('path');
const fs = require('fs');
const solc = require('solc');

const lotteryPath = path.resolve(__dirname, 'contracts', 'Lottery.sol')
const source = fs.readFileSync(lotteryPath, 'utf8')

const input = {
    language: 'Solidity',
    sources: {
        'Lottery.sol': {
            content: source,
        }
    },
    settings: {
        outputSelection:{
            '*' : {
                '*': ['*']
            }
        }
    }
}
//console.log(JSON.parse(solc.compile(JSON.stringify(input))).contracts['Inbox.sol'].Inbox.evm.bytecode.object);
const bytecode = JSON.parse(solc.compile(JSON.stringify(input))).contracts['Lottery.sol'].Lottery.evm.bytecode.object
const interface = JSON.parse(solc.compile(JSON.stringify(input))).contracts['Lottery.sol'].Lottery.abi

module.exports ={
    interface,
    bytecode
}