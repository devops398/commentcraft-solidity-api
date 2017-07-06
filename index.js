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
//const account = window.web4.eth.accounts[0];
const commentcraftContract = window.web4.qtum.contract(require('./build/contracts/CommentCraft.json')).at(CONTRACT_ADR);
/* Commentcraft.deployed()
 .then(instance => {
 window.CCONTRACT = instance;
 });*/

const getAbiData = (methodName, data) => commentcraftContract[methodName].getData(data);

const getId = ( data ) => parseInt(XXH.h32(data, 0xABCD).toString(16), 16);

const getPosts = id => Commentcraft.deployed()
.then(instance => instance.getPagespostsData.call(id));

const getPost = id => Commentcraft.deployed()
.then(instance => instance.getPost.call(id));

const getUsername = id => web4.qtum.callContract(CONTRACT_ADR, getAbiData('getUsername', id))

const createPost = ( pageId, content ) => Commentcraft.deployed()
.then(instance => {
  const postId = getId(`${pageId}${content}${Math.random()}`); // uniq post id

  return instance.createPost(pageId, postId, content, { from: ""/*account */ })
  .then(() => postId);
});

export default {
  commentcraftContract,
  getId,
  getPost,
  getPosts,
  getUsername,
  createPost
}