create DATABASE if not EXISTS qba_db default CHARACTER set utf8 COLLATE utf8_general_ci;

use qba_db;

/*
页面信息展示的更多一些，只有用户自己编辑，选择项使用字符更合适,
多变联查，最后还是要优化
*/

DROP TABLE IF EXISTS qba_userinfo;
CREATE TABLE qba_userinfo(
 uid  INT NOT NULL AUTO_INCREMENT,
 account  varchar(20)        NOT NULL,
 email    varchar(30)        NOT NULL,
 password varchar(40)        NOT NULL,
 sex  varchar(10)           NOT NULL,
 birthday  Date     NOT NULL,

 local_province varchar(20) NOT NULL,
 local_city varchar(20) NOT NULL,
 native_province   varchar(20) NOT NULL,
 native_city   varchar(20) NOT NULL, 

 headUrl       varchar(100),
 photosUrl     varchar(50),
 income       varchar(20),
 house_status varchar(20),
 car_status   varchar(20),
 merry_status varchar(20),
 
 age int, 
 job varchar(30),
 child_status varchar(40),
 constellation varchar(10),/*星座*/
 birth_Pet varchar(2),/*属相*/
 height int,
 weight int,
 race varchar(10),/*名族*/
 real_name varchar(10),
 IDC varchar(20),/*身份证号码*/
 is_vip int, 
 inlove_status varchar(20),/*征婚状态*/
 hot_point int,/*热度*/
 bloodType varchar(20),/*血型*/
 
 love_words  varchar(300), 
 degree      varchar(20),
 QQ          varchar(12),
 telephone   varchar(11),
 weibo       varchar(20), 
 vip_point         INT,
 useable_vip_point INT,
 package_owned	   VARCHAR(100),
 
 gold              INT DEFAULT 0,
 red_heart         INT DEFAULT 0,
 thumbup_count	   INT DEFAULT 0,
 follow_count      INT DEFAULT 0,
 fan_count         INT DEFAULT 0,
 green_count       INT DEFAULT 0,
 friend_count      INT DEFAULT 0,
 note_count	       INT DEFAULT 0,
 
 receive_msg_count int DEFAULT 0,
 send_msg_count	   int DEFAULT 0,

 receive_contact_count int DEFAULT 0,
 send_contact_count	   int DEFAULT 0,
 
 receive_gift_count int DEFAULT 0,
 send_gift_count   int DEFAULT 0,
 
 receive_qiubo_count int DEFAULT 0,
 send_qiubo_count int DEFAULT 0,

 role_type		   INT NOT NULL DEFAULT 0,
 create_time  		DATETIME    NOT NULL ,
 update_time  		DATETIME    NOT NULL ,
 inactive			INT not null DEFAULT 0,/*1-disabled user*/
 local_province_desc varchar(20),
 local_city_desc varchar(20),
 native_province_desc   varchar(20),
 native_city_desc   varchar(20),
 company_type   varchar(20),
 
 smoke   varchar(20),
 drink   varchar(20),
 speak_languages   varchar(50),
 
 college   varchar(50),
 country   varchar(50),
 bodyStyle   varchar(10),
 
 last_logindate	DATETIME,
 is_online	int default 0,
 PRIMARY KEY(UID)
);


/*
update qba_userinfo
set 
thumbup_count=1200,
red_heart=2300,
follow_count=3400
*/


/*
this table is to record the vip point increasing details,
whow add the point and how much
how the points added, other user of buy with gold
 */
drop table if exists qba_vipPoint;
Create table qba_vipPoint(
	id int not null AUTO_INCREMENT,
	uid int not null, /*point to who*/
	suid int not null,/*point from who*/
	point int not null,
	comment varchar(100),/*description of the point*/
	enter_date DATETIME,
	primary key(id)
);

/*
insert into qba_vipPoint(uid,suid,point,comment,enter_date)
values
(1,9,11,'','2014/01/08'),
(2,1,12,'','2014/02/08'),
(3,2,13,'','2014/03/08'),
(4,3,14,'','2014/04/08'),
(5,4,15,'','2014/05/08'),
(6,5,16,'','2014/06/08'),
(7,6,17,'','2014/07/08'),
(8,7,18,'','2014/08/08'),
(9,8,19,'','2014/09/08'),
(11,9,11,'','2014/01/08'),
(12,1,12,'','2014/02/08'),
(13,2,13,'','2014/03/08'),
(14,3,14,'','2014/04/08'),
(15,4,15,'','2014/05/08'),
(16,5,16,'','2014/06/08'),
(17,6,17,'','2014/07/08'),
(18,7,18,'','2014/08/08'),
(19,8,19,'','2014/09/08')

select A.* from qba_userinfo as A
join 
(
	select sum(point) as vip_point,uid from qba_vipPoint as A 
	group by uid
	ORDER by sum(point) desc
	limit 5
) as B on A.uid=B.uid
ORDER by B.vip_point desc;


*/


/*THE CONDITION TO SEARCH THE FRIENDS*/
DROP TABLE IF EXISTS qba_searchCondition;
CREATE TABLE qba_searchCondition(
 uid  INT NOT NULL,
 account  varchar(20),
 email    varchar(30),
 sex  varchar(10),
 age_min int,
 age_max int,
 local_province varchar(20),
 local_city varchar(20),
 native_province   varchar(20),
 native_city   varchar(20), 
 income       varchar(20),/*收入分级*/
 house_status varchar(20),
 car_status   varchar(20),
 merry_status varchar(20), 
 job varchar(30),
 child_status varchar(40),
 constellation varchar(10),/*星座*/
 birth_Pet varchar(2),/*属相*/
 bloodType varchar(20),/*血型*/
 height_min int,
 height_max int,
 weight_min int,
 weight_max int,
 race varchar(10),/*名族*/ 
 degree       varchar(20),
 degree_above INT,/*checkbox for above*/
 is_vip int,
 create_time  DATETIME    NOT NULL,
 update_time  DATETIME    NOT NULL,
 local_province_desc varchar(20),
 local_city_desc varchar(20),
 native_province_desc varchar(20),
 native_city_desc   varchar(20),
 company_type   varchar(20),
 other_request varchar(300),
 smoke   varchar(20),
 drink   varchar(20),
 speak_languages   varchar(50),
 bodyStyle   varchar(10),
 PRIMARY KEY(UID)
);



/*USER INTEREST, CAN ADD DRANK AND SMOKE*/
DROP TABLE IF EXISTS qba_userInterest;
CREATE TABLE qba_userInterest(
 uid          INT NOT NULL,
 hoby		 varchar(200),
 sports      varchar(200),
 dish		 varchar(200),
 place		 varchar(200),
 PRIMARY KEY(UID)
);

/*USER RELATION OF FRIENDS, FANS,FOLLOWS, FELL GOOD
relate_type: 0-fans, 1-feel-good
*/
DROP TABLE IF EXISTS qba_userRelation;
CREATE TABLE qba_userRelation(
 relate_id   	INT NOT NULL AUTO_INCREMENT,
 uid         	INT NOT NULL,
 relate_uid  	INT NOT NULL,
 relate_type 	INT NOT NULL,
 relate_status  INT DEFAULT 0,
 relate_date DATETIME,
PRIMARY KEY(relate_id)
);


/*
STAMPED SHOWS IF THE MESSAGE CAN BE READ FREELY
MSG_TYPE: SI_XIN
ALL THESE TWO TYPE MESSAGE WILL SEND HERE
msg_sendstatus:0-UN_READ, 1-READED, 2-DELETED, status for sender
msg_readstatus:0-UN_READ, 1-READED, 2-DELETED, status for receiver
have to distribute the table to sub tables by id
*/
DROP TABLE IF EXISTS qba_message;
CREATE TABLE qba_message(
 msg_id      INT   NOT NULL AUTO_INCREMENT,
 msg_type    INT   NOT NULL,
 msg_sendstatus  INT,
 msg_readstatus  INT,
 UID    INT   NOT NULL,
 SUID INT   NOT NULL,
 content     VARCHAR(500)  NOT NULL,
 stamped		 INT NOT NULL,
 send_time   DATETIME NOT NULL,
 read_time   DATETIME,
PRIMARY KEY(msg_id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


/*
THE CHONTACT INFO REQUEST FROM OTHER USERS
REQ_TYPE:0-TELEPHONE, 1-QQ,  2-EMAIL,3-SITE_MSG
IF POSSIBILE, ADD OTHER CONTACTS REQUEST LIKE WEIBO
UID: REQUEST TO WHOM
SUID: WHO SEND THE CONTACT REQUEST.
req_cost: THIS IS THE QIUBO_HEART COST FOR THE REQUEST,USER CAN SET THE COST HERSELF.
THE COST CAN'T LESS THEN THE SYSTEM COST
*/
DROP TABLE IF EXISTS qba_ContactRequest;
CREATE TABLE qba_ContactRequest(
 req_id      	INT   NOT NULL AUTO_INCREMENT,
 UID    		INT   NOT NULL,
 SUID 			INT   NOT NULL,
 req_type    	INT   NOT NULL,
 req_cost	 	FLOAT NOT NULL,
 req_status  	INT   NOT NULL,
 content     	VARCHAR(100),
 send_time   	DATETIME NOT NULL,
 read_time   	DATETIME,
PRIMARY KEY(req_id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE utf8_bin;

/*
insert into qba_ContactRequest(    
		UID,	
		SUID,	
		req_type, 
		req_cost,	
		req_status, 
		content, 
		send_time, 
		read_time)
	select 
		UID,    	
		SUID, 		
		req_type,   
		req_cost,	
		req_status, 
		content,    
		send_time,  
		read_time
	from qba_userinfo as A
	where A.uid=#uid#
*/



/*
系统通知只在Note表中添加一条记录，
用户登录是获取用户没有查看的Note，已读和删除的记录存到NoteBox中
这样极大的分散了IO
*/
/*SYSTEM NOTE,WHEN LOGIN ,GET ALL THE NOTE
DISTRIBUTE THE TASK INTO SMALL TASK,
WHEN SEND NOTE,JUST UPDATE THE note count in AppData
when user login just get the note not in notebox and add to notebox,
and the note in the notebox will have the status
note_status:
*/
DROP TABLE IF EXISTS qba_note;
CREATE TABLE qba_note(
 note_id    INT        NOT NULL AUTO_INCREMENT,
 note_type  INT        NOT NULL,
 content VARCHAR(100)  NOT NULL,
 send_time DATETIME        NOT NULL,
 backup_read_note INT,
 note_status	INT NOT NULL,
PRIMARY KEY(note_id)
);


/*
WHEN LOGIN JUST GET THE NOTE NOT IN THE NOTEBOX,
THEN ADD THE NOTE TO THE NOTEBOX, ADD CHANGE THE STATUS.
note_status: 0-NOTE_READ, 1-READED, 2-DELETED
*/
DROP TABLE IF EXISTS qba_noteBox;
CREATE TABLE qba_noteBox(
 NB_ID   INT   NOT NULL AUTO_INCREMENT,
 uid  INT   NOT NULL,
 note_id INT NOT NULL,
 note_status INT NOT NULL,
PRIMARY KEY(NB_ID)
);



/*
SAVE THE APPLICATION VARIABLES FOR GLOBAL USE
*/
DROP TABLE IF EXISTS qba_AppData;
CREATE TABLE qba_AppData(
 APP_ID INT NOT NULL AUTO_INCREMENT,
 APP_KEY   VARCHAR(20) NOT NULL,
 APP_VALUE VARCHAR(50),
PRIMARY KEY(APP_ID)
);

/*
ORDER FOR TRADE,WHAT YOU BUY, ONLY THE REAL PAY OF MONEY ORDER.
THE COST OF CONTACT_REQUEST WITH QIUBO_HEART NOT INCLUDED,
NO NEED TO RECORD THIS FOR USER, THIS WILL RECORD IN THE CONTACT_REQUEST WITH THE COST.
*/
DROP TABLE IF EXISTS qba_order;
CREATE TABLE qba_order(
	ORDER_ID INT NOT NULL AUTO_INCREMENT,
	UID INT NOT NULL,
	PKG_ID INT NOT NULL,
	TRADE_TYPE INT NOT NULL,
	PACKAGE_TYPE INT NOT NULL,
	ORDER_DATE DATETIME NOT NULL,
	PRIMARY KEY(ORDER_ID)
);

/*
VIP RIGHT 
*/
DROP TABLE IF EXISTS qba_vipRight;
CREATE TABLE qba_vipRight(
	UID INT NOT NULL,
	RIGHT_ITEM VARCHAR(100) NOT NULL,
	PRIMARY KEY(UID)
	
);


/*GIFT ITEM FOR REFERENCE TO GIFTBOX
PACKAGE_TYPE: check if user have bought the gift
i have qba_package table 
*/
DROP TABLE IF EXISTS qba_gift;
CREATE TABLE qba_gift(
	GIFT_ID INT NOT NULL AUTO_INCREMENT,
	PACKAGE_TYPE INT NOT NULL,
	GIFT_URL VARCHAR(100) NOT NULL,
	PRIMARY KEY(GIFT_ID)
);

/*THE LIST OF THE GIFT YOU GET
GIFT_URL: REFERENCE TO THE QBA_GIFT TABLE, MAY NOT NEED, TODO

*/
DROP TABLE IF EXISTS qba_giftBox;
CREATE TABLE qba_giftBox(
	GB_ID INT NOT NULL AUTO_INCREMENT,
	UID INT NOT NULL,
	SUID INT NOT NULL,
	GIFT_ID INT NOT NULL,
	GIFT_STATUS INT,
	GIFT_Time DATETIME,
	PRIMARY KEY(GB_ID)
);


/*
QIUBO FOR USER TO SELECT AND SEND TO ANOTHER

*/
DROP TABLE IF EXISTS qba_QiuBo;
CREATE TABLE qba_QiuBo(
	QB_ID INT NOT NULL AUTO_INCREMENT,
	UID INT NOT NULL,
	SUID INT NOT NULL,
	QB_TYPE INT NOT NULL,
	QB_CONTENT VARCHAR(100),
	QB_STATUS INT,
	QB_Date DATETIME,
	PRIMARY KEY(QB_ID)
);

/*
THE LIST OF QIUBO YOU GET
CONTENT MAY BE NOT NEED, REFERENCE TO THE qba_QiuBo, TODO
*/
/*
DROP TABLE IF EXISTS qba_qiuboBox;
CREATE TABLE qba_qiuboBox(
	QBB_ID INT NOT NULL AUTO_INCREMENT,
	UID INT NOT NULL,
	SUID INT NOT NULL,
	QB_TYPE INT NOT NULL,
	QB_CONTENT VARCHAR(100),
	QB_Time DATETIME,
	PRIMARY KEY(QBB_ID)
);
*/
/*
PACKAGES FOR VIP TO BUY
*/
DROP TABLE IF EXISTS qba_package;
CREATE TABLE qba_package(
	PKG_ID INT AUTO_INCREMENT,
	PKG_TYPE INT NOT NULL,
	PKG_NAME VARCHAR(100) NOT NULL,
	PKG_DETAIL VARCHAR(200),
	PKG_PRICE FLOAT NOT NULL,
primary key(PKG_ID)
);


DROP TABLE IF EXISTS qba_image;
CREATE TABLE qba_image(

	img_id INT AUTO_INCREMENT,
	uid INT,
	file_id VARCHAR(100),
	file_name VARCHAR(100),
	file_type varchar(30),
	file_length INT,	
	upload_uid int,	
	description VARCHAR(100),
	update_time DATETIME,
	create_time DATETIME,
PRIMARY KEY(img_id)
);



