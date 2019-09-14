create table user(name varchar(30),id varchar(20),password varchar(30),email varchar(30),phone varchar(30),primary key(id));
create table activity(sid varchar(30),subject varchar(30),marks varchar(30),date varchar(30),primary key(sid),foreign key(sid) references user(id));
create table examsession(sid varchar(30),tname varchar(20),start varchar(30),end varchar(30),finished varchar(10));
alter table examsession add primary key(sid);
alter table examsession add foreign key(sid) references user(id);
/*student response tables will be generated in runtime*/
