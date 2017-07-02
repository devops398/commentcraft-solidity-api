pragma solidity ^0.4.0;


contract CommentCraft {
    enum VoteStatus {
    NoVote,
    Like,
    Dislike
    }
    struct Post {
    uint id;
    uint rating;
    string content;
    address author;
    uint[] replies;
    mapping (address => VoteStatus) likes;
    }

    mapping (address => string) usernames;

    mapping (uint => Post) postsData;

    mapping (uint => uint[]) pagesData;

    uint[] emptypostsData;
    // events
    event Posted(address author, uint postId);

    event Liked(address voter, uint postId);

    event Disliked(address voter, uint postId);
    // USER FUNCTIONS
    function setUsername(string username) {
        usernames[msg.sender] = username;
    }

    function getUsername(address addr) constant returns (string) {
        return usernames[addr];
    }

    // postsData FUNCTIONS
    function createPost(uint pageId, uint postId, string content) {
        postsData[postId] = Post(postId, 0, content, msg.sender, emptypostsData);
        pagesData[pageId].push(postId);

        Posted(msg.sender, postId);
    }

    function replyToPost(uint postId, string content, uint replyTo) {
        postsData[postId] = Post(postId, 0, content, msg.sender, emptypostsData);
        postsData[replyTo].replies.push(postId);

        Posted(msg.sender, postId);
    }

    function getPagespostsData(uint pageId) constant returns (uint[]) {
        return pagesData[pageId];
    }

    function getPost(uint postId) constant returns (uint, string, address, string, uint[]) {
        Post post = postsData[postId];
        return (post.rating, post.content, post.author, usernames[post.author], post.replies);
    }
    // TODO: refactor likes to enum
    function like(uint postId) {
        if (postsData[postId].likes[msg.sender] == VoteStatus.Like) {
            throw;
        }
        if (postsData[postId].likes[msg.sender] == VoteStatus.Dislike) {// if disliked before
            postsData[postId].rating += 2;
        }
        else {
            postsData[postId].rating += 1;
        }
        postsData[postId].likes[msg.sender] = VoteStatus.Like;

        Liked(msg.sender, postId);
    }

    function disLike(uint postId) {
        if (postsData[postId].likes[msg.sender] == VoteStatus.Dislike) {
            throw;
        }
        if (postsData[postId].likes[msg.sender] == VoteStatus.Like) {// if liked before
            postsData[postId].rating -= 2;
        }
        else {
            postsData[postId].rating -= 1;
        }
        postsData[postId].likes[msg.sender] = VoteStatus.Dislike;
        Disliked(msg.sender, postId);
    }
}
