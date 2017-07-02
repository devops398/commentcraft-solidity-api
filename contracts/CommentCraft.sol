pragma solidity ^0.4.0;


contract CommentCraft {
    struct Post {
    uint id;
    uint rating;
    string content;
    address author;
    uint[] replies;
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

    function replyToPost(uint pageId, uint postId, string content, uint replyTo) {
        posts[postId] = Post(postId, 0, content, msg.sender, emptyPosts);
        posts[replyTo].replies.push(postId);
    }

    function getPagesPosts(uint pageId) constant returns (uint[]) {
        return pagesData[pageId];
    }
}
