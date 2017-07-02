pragma solidity ^0.4.0;


contract CommentCraft {
    struct Post {
    uint id;
    uint rating;
    string content;
    address author;
    uint[] replies;
    mapping (address => uint8) likes; // 1 - like, 2 - dislike
    }

    mapping (address => string) usernames;

    mapping (uint => Post) posts;

    mapping (uint => uint[]) pagesData;

    uint[] emptyPosts;
    // USER FUNCTIONS
    function setUsername(string username) {
        usernames[msg.sender] = username;
    }

    function getUsername(address addr) constant returns (string) {
        return usernames[addr];
    }

    // POSTS FUNCTIONS
    function createPost(uint pageId, uint postId, string content) {
        posts[postId] = Post(postId, 0, content, msg.sender, emptyPosts);
        pagesData[pageId].push(postId);
    }

    function replyToPost(uint postId, string content, uint replyTo) {
        posts[postId] = Post(postId, 0, content, msg.sender, emptyPosts);
        posts[replyTo].replies.push(postId);
    }

    function getPagesPosts(uint pageId) constant returns (uint[]) {
        return pagesData[pageId];
    }

    function getPost(uint postId) constant returns (uint, string, address, string, uint[]) {
        Post post = posts[postId];
        return (post.rating, post.content, post.author, usernames[post.author], post.replies);
    }
    // TODO: refactor likes to enum
    function like(uint postId) {
        if (posts[postId].likes[msg.sender] == 1) {
            throw;
        }
        if (posts[postId].likes[msg.sender] == 2) {// if disliked before
            posts[postId].rating += 2;
        }
        else {
            posts[postId].rating += 1;
        }
        posts[postId].likes[msg.sender] = 1;
    }

    function disLike(uint postId) {
        if (posts[postId].likes[msg.sender] == 2) {
            throw;
        }
        if (posts[postId].likes[msg.sender] == 1) {// if liked before
            posts[postId].rating -= 2;
        }
        else {
            posts[postId].rating -= 1;
        }
        posts[postId].likes[msg.sender] = 2;
    }
}
