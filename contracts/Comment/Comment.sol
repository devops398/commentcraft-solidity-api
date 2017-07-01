pragma solidity ^0.4.0;


import './CommentInterface.sol';


contract Comment {
    struct Post {
    byte32 id;
    uint rating;
    string content;
    address author;
    Post[] replies;
    }

    mapping (address => string) usernames;

    mapping (byte32 => Post) posts;

    mapping (byte32 => Post[]) pagesData;


    // USERFUNCTIONS
    function setUsername(string username) {
        usernames[msg.sender] = username;
    }

    function getUsername(address addr) constant returns (string) {
        return usernames[addr];
    }

    // POSTS FUNCTIONS
    function doPost(byte32 pageId, byte32 postId, string content) {
        Post post = Post(postId, 0, content, msg.sender, Post[]);
        posts[postId] = post;
        pagesData[pageId].push(post);
    }

    function getPagesPosts(byte32 pageId) constant returns (Post[]) {
        return pagesData[pageId];
    }
}
