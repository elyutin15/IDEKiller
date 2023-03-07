create table if not exists Users (
    id int not null auto_increment,
    name varchar(50) not null,
    email varchar(50) not null,
    password varchar(200) not null,
    primary key (id)
);

