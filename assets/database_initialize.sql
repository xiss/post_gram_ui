-- Table: Users
DROP TABLE IF EXISTS t_Users;
CREATE TABLE IF NOT EXISTS t_Users
(
    id text NOT NULL,
    name text  NOT NULL,
    surname text  NOT NULL,
    patronymic text  NOT NULL,
    email text  NOT NULL,
    nickname text  NOT NULL,
    birthDate timestamp with time zone NOT NULL,
    avatarId text,    
    CONSTRAINT PK_Users PRIMARY KEY (id)    
);

-- Table: Avatars
DROP TABLE IF EXISTS t_Avatars;
CREATE TABLE IF NOT EXISTS t_Avatars
(
    id text NOT NULL,
    userId text NOT NULL,
    name text NOT NULL,
    mimeType text NOT NULL,
    link text NOT NULL,
    CONSTRAINT PK_Avatars PRIMARY KEY (id) 
);

-- Table: Posts
DROP TABLE IF EXISTS t_Posts;
CREATE TABLE IF NOT EXISTS t_Posts
(
    id text NOT NULL,
    header text  NOT NULL,
    body text  NOT NULL,
    edited timestamp ,
    authorId text NOT NULL,
    created timestamp  NOT NULL,
    likeCount int NOT NULL,
    dislikeCount int NOT NULL,
    commentCount int NOT NULL,
    isLikedByUser bool,
    CONSTRAINT PK_Posts PRIMARY KEY (id),
    CONSTRAINT FK_Posts_Users_AuthorId FOREIGN KEY (authorId)
        REFERENCES t_Users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Table: PostContents
DROP TABLE IF EXISTS t_PostContents;
CREATE TABLE IF NOT EXISTS t_PostContents
(
    id text NOT NULL,
    postId text NOT NULL,
    name text NOT NULL,
    mimeType text NOT NULL,
    link text NOT NULL,
    CONSTRAINT PK_PostContents PRIMARY KEY (id),    
    CONSTRAINT FK_PostContents_Posts_PostId FOREIGN KEY (postId)
        REFERENCES t_Posts (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: Comments 
DROP TABLE IF EXISTS t_Comments;
CREATE TABLE IF NOT EXISTS t_Comments
(
    id text NOT NULL,
    body text NOT NULL,
    edited timestamp with time zone,
    postId text NOT NULL,
    authorId text NOT NULL,
    created timestamp with time zone NOT NULL,
    quotedCommentId text,
    quotedText text,
    CONSTRAINT PK_Comments PRIMARY KEY (id),
    CONSTRAINT FK_Comments_Comments_QuotedCommentId FOREIGN KEY (quotedCommentId)
        REFERENCES t_Comments (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_Comments_Posts_PostId FOREIGN KEY (postId)
        REFERENCES t_Posts (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT FK_Comments_Users_AuthorId FOREIGN KEY (authorId)
        REFERENCES t_Users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Table: Likes//TODO
DROP TABLE IF EXISTS t_Likes;
CREATE TABLE IF NOT EXISTS t_Likes
(
    id text NOT NULL,
    isLike boolean,    
    authorId text NOT NULL,
    created timestamp NOT NULL,
    entityId text NOT NULL ,
    entityType integer NOT NULL ,
    CONSTRAINT PK_Likes PRIMARY KEY (id),
    CONSTRAINT FK_Likes_Users_AuthorId FOREIGN KEY (authorId)
        REFERENCES t_Users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: Subscriptions
DROP TABLE IF EXISTS t_Subscriptions;
CREATE TABLE IF NOT EXISTS t_Subscriptions
(
    id text NOT NULL,
    slaveId text NOT NULL,
    masterId text NOT NULL,
    status boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    edited timestamp with time zone,
    CONSTRAINT PK_Subscriptions PRIMARY KEY (id),
    CONSTRAINT FK_Subscriptions_Users_MasterId FOREIGN KEY (masterId)
        REFERENCES t_Users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_Subscriptions_Users_SlaveId FOREIGN KEY (slaveId)
        REFERENCES t_Users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);