CREATE TABLE notice(
	noticeNumber int(11) primary key,
	noticeTitle varchar(50),
	noticeContent varchar(2048),
	noticeDate datetime,
	noticeId varchar(20),
	noticeAvailable int(3)
);

CREATE TABLE user (
	id varchar(50) primary key,
	password varchar(50),
	name varchar(20),
	memberdate varchar(20),
	gender varchar(5),
	email varchar(50)
);


CREATE TABLE menu (
	menuNumber int(11) primary key,
	menuTitle varchar(50),
	menuContent varchar(2048),
	menuDate datetime,
	id varchar(50),
	menuImageNumber int(11),
	menuAvailable int(3),
	readCnt int(11),
	sumAppraisal int(3)
);

CREATE TABLE menuImage (
	menuImageNumber int(11),
	imageName1 varchar(50),
	imageName2 varchar(50),
	imageName3 varchar(50)
);

CREATE TABLE menuAppraisal (
	menuNumber int(11),
	id varchar(50),
	menuAppraisal int(3)
);


