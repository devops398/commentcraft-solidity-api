import XXH from 'xxhashjs';
import Web4 from 'web4';
import contract from 'truffle-contract';

const CONTRACT_ADR = '0xf0fde30f80968f85e5c60b9cc974023bfff94782';
const RPC_HOST     = 'localhost';
const RPC_PORT     = '3889';
const RPC_USER     = 'test';
const RPC_PASSWORD = 'test';
const provider     = new Web4.providers.HttpProvider(`http://${RPC_USER}:${RPC_PASSWORD}@${RPC_HOST}:${RPC_PORT}`);
window.web4        = new Web4(provider);

const abi = require('./build/contracts/CommentCraft.json').abi;
const commentcraftContract = window.web4.qtum.contract(abi).at(CONTRACT_ADR);

const getAbiData = (methodName, data) => commentcraftContract[methodName].getData(data).substring(2);

const getId = ( data ) => parseInt(XXH.h32(data, 0xABCD).toString(16), 16);

const getQtumAddress = (account="") => web4.qtum.getAccountAddress(account);
const getHexAddress = (qtumAddress) => web4.qtum.getHexAddress(qtumAddress);

/*

 const getPosts = id => Commentcraft.deployed()
 .then(instance => instance.getPagespostsData.call(id));

 const getPost = id => Commentcraft.deployed()
 .then(instance => instance.getPost.call(id));
 */

const getUsername = id => web4.toAscii(qtum.callContract(CONTRACT_ADR.substring(2), getAbiData('getUsername', id)).executionResult.output)
/*

 const createPost = ( pageId, content ) => Commentcraft.deployed()
 .then(instance => {
 const postId = getId(`${pageId}${content}${Math.random()}`); // uniq post id

 return instance.createPost(pageId, postId, content, { from: ""/!*account *!/ })
 .then(() => postId);
 });
 */

export default {
  commentcraftContract,
  getUsername
}