const CommentCraft = artifacts.require('./CommentCraft.sol');
const BigNumber = require('BigNumber.js');


const getUniqId = () => Math.floor(Math.random() * 999999); // emulator for hash func


contract('CommentCraft', function (accounts) {
  it('Should deploy', () => CommentCraft.deployed());

  it('Should save username for account', () => CommentCraft.deployed()
    .then(instance => Promise.all([
        instance.setUsername('account0', {
          from: accounts[0]
        }),
        instance.setUsername('account1', {
          from: accounts[1]
        })
      ])
    )
  );
  it('Should store username for account in static field', () => CommentCraft.deployed()
    .then(instance => {
      return instance.getUsername.call(accounts[0])
        .then(username => assert(username === 'account0', 'Username in contract equals "account0"'))
        .then(() => instance.getUsername.call(accounts[1]))
        .then(username => assert(username === 'account1', 'Username of empty account in contract equals "account1'))
    })
  );
  it('Should store username for account in static field', () => CommentCraft.deployed()
    .then(instance => {
      return instance.getUsername.call(accounts[0])
        .then(username => assert(username === 'account0', 'Username in contract equals "account0"'))
        .then(() => instance.getUsername.call(accounts[1]))
        .then(username => assert(username === 'account1', 'Username of empty account in contract equals "account1'))
    })
  );
  it('Should store posts', () => CommentCraft.deployed()
    .then(instance => {
      const pageId = getUniqId();
      const postId = getUniqId();
      const replyId = getUniqId();

      return instance.createPost(pageId, postId, 'Test post', {
        from: accounts[0]
      })
        .then(() => instance.getPost.call(postId))
        .then(([rating, content, author, username, replies]) => {
          assert(rating == 0, 'rating of new post should be 0');
          assert(content === 'Test post', 'contents should match');
          assert(author === accounts[0], 'Author should be account0');
          assert(username === 'account0', 'username should be account0');
          assert(replies.length === 0, 'replies should be empty array');
        })
        .then(() => instance.replyToPost(replyId, 'Reply to post', postId, {
          from: accounts[1]
        }))
        .then(() => Promise.all([
          instance.getPost.call(replyId),
          instance.getPost.call(postId),
        ]))
        .then(([
                 [rating, content, author, username],
                 [, , , , replies]
               ]) => {
          assert(replies[0] == replyId, 'Parent post should contains replypost id in replies array');
          assert(rating == 0, 'rating of new reply post should be 0');
          assert(content === 'Reply to post', 'contents should match');
          assert(author === accounts[1], 'Author should be account1');
          assert(username === 'account1', 'username should be account1');
        })
    })
  )
});
