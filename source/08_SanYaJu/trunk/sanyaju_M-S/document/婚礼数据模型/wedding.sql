/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2015/4/17 16:50:20                           */
/*==============================================================*/


drop table if exists ams_wedding_accept_invitation;

drop table if exists ams_wedding_attache;

drop table if exists ams_wedding_blessing;

drop table if exists ams_wedding_invitation;

drop table if exists ams_wedding_photo;

/*==============================================================*/
/* Table: ams_wedding_accept_invitation                         */
/*==============================================================*/
create table ams_wedding_accept_invitation
(
   id                   int not null,
   attendee_name        varchar(50),
   attendee_num         int,
   friends_type         varchar(200),
   accept_time          date,
   remark               varchar(1000),
   wedding_id           int,
   primary key (id)
);

alter table ams_wedding_accept_invitation comment '婚礼接受邀请信息';

/*==============================================================*/
/* Table: ams_wedding_attache                                   */
/*==============================================================*/
create table ams_wedding_attache
(
   id                   int not null,
   bg_img               varchar(200),
   bg_music             varchar(200),
   wedding_id           int,
   create_time          date,
   remark               varchar(1000),
   primary key (id)
);

alter table ams_wedding_attache comment '婚礼活动附属信息';

/*==============================================================*/
/* Table: ams_wedding_blessing                                  */
/*==============================================================*/
create table ams_wedding_blessing
(
   id                   int not null,
   nickname             varchar(50),
   message_content      longblob,
   create_time          date,
   wedding_id           int,
   primary key (id)
);

alter table ams_wedding_blessing comment '婚礼祝福留言信息';

/*==============================================================*/
/* Table: ams_wedding_invitation                                */
/*==============================================================*/
create table ams_wedding_invitation
(
   id                   int not null,
   subject              varchar(1),
   groom                varchar(1),
   bride                varchar(1),
   wedding_address      varchar(1),
   wedding_time         date,
   map_latitude         varchar(200),
   map_longitude        varchar(200),
   create_time          date,
   remark               varchar(1000),
   primary key (id)
);

alter table ams_wedding_invitation comment '婚礼邀请函信息';

/*==============================================================*/
/* Table: ams_wedding_photo                                     */
/*==============================================================*/
create table ams_wedding_photo
(
   id                   int not null,
   photo_path           varchar(200),
   click_num            int,
   wedding_id           int,
   create_time          date,
   remark               varchar(1000),
   primary key (id)
);

alter table ams_wedding_photo comment '婚礼活动相册';

alter table ams_wedding_accept_invitation add constraint FK_Reference_4 foreign key (wedding_id)
      references ams_wedding_invitation (id) on delete restrict on update restrict;

alter table ams_wedding_attache add constraint FK_Reference_2 foreign key (wedding_id)
      references ams_wedding_invitation (id) on delete restrict on update restrict;

alter table ams_wedding_blessing add constraint FK_Reference_3 foreign key (wedding_id)
      references ams_wedding_invitation (id) on delete restrict on update restrict;

alter table ams_wedding_photo add constraint FK_Reference_1 foreign key (wedding_id)
      references ams_wedding_invitation (id) on delete restrict on update restrict;

