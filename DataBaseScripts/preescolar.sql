create database if not exists schools;
use schools;

create table if not exists audits(
	id int
);

create table if not exists characterization(
	id int,
    charac_name varchar(40),
    editable bit
);

create table if not exists religions(
	id int,
    religion varchar(30),
    editable bit
);

create table if not exists genders(
	id int not null auto_increment,
    doc_name varchar(20),
    enabled bit,
    deleted bit,
    editable bit
);

create table if not exists relative_types(
	id int,
    relative_type varchar(30),
    editable bit
);

create table if not exists masters(
	id int,
    name_table varchar(60)
);

create table if not exists document_types(
	id int not null auto_increment,
    doc_name varchar(20),
    enabled bit,
    deleted bit,
    primary key(id)
);

create table if not exists users(
	id int AUTO_INCREMENT not null,
    id_person int,
    primary key(id)
);

create table if not exists teachers(
	id int not null auto_increment,
    primary key(id),
    deleted bit,
    enabled bit
);

create table if not exists contact_info(
	id int not null AUTO_INCREMENT,
    city_code smallint null, 
    cell_phone int null,
    address varchar(50) null,
    id_country int null,
    city varchar(60),
    email varchar(50) null,
    area_code smallint,
    phone int null,
    deleted bit not null,
    enabled bit not null,
    primary key(id)
);

CREATE TABLE IF NOT EXISTS students(
	id INT NOT NULL AUTO_INCREMENT,
    code_student int null,
    inscription_date datetime not null,
    rh int null,
    weight int null,
    height int null,
    people_home int null,
    id_characterization int not null,
    qty_brothers int null,
    id_religion int not null,
    militar_number int null,
    enabled bit not null,
    deleted bit not null,
    INDEX `code_student` (`code_student` ASC) VISIBLE,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_charac_student` FOREIGN KEY (`id_characterization`) REFERENCES `characterization`(`id`),
    CONSTRAINT `fk_relig_student` FOREIGN KEY (`id_religion`) REFERENCES `religions` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

create table if not exists relatives(
	id int not null AUTO_INCREMENT,
    id_type_parent int not null,
    is_attendant bit not null,
    deleted bit not null,
    enabled bit not null,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_type_parent_relat` FOREIGN KEY (`id_type_parent`) REFERENCES `relative_types` (`id`)
);

create table if not exists person(
	id int NOT NULL AUTO_INCREMENT,
    id_contact int not null,
    id_teacher int null,
    id_student int null,
    id_type_doc int not null,
    document varchar(25) not null unique,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    birthdate date not null,
    id_gender int null,
    birth_place int null,
    enabled bit not null,
    deleted bit not null,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_type_doc` FOREIGN KEY (`id_type_doc`) REFERENCES `document_types` (`id`),
    CONSTRAINT `fk_gender_person` FOREIGN KEY (`id_gender`) REFERENCES `genders` (`id`),
    constraint fk_person_teacher foreign key (id_teacher) references teachers(id),
    constraint fk_person_student foreign key(id_student) references students(id),
    CONSTRAINT `fk_person_contact` FOREIGN KEY (`id_contact`) REFERENCES `contact_info` (`id`)
);

create table if not exists student_relative(
	id int AUTO_INCREMENT not null,
    id_student int,
    id_relative int,
    deleted bit not null,
    PRIMARY KEY (`id`),
	CONSTRAINT `fk_stude_rela_stude` FOREIGN KEY (`id_student`) REFERENCES `students` (`id`),
    CONSTRAINT `fk_stude_rela_rela` FOREIGN KEY (`id_relative`) REFERENCES `relatives` (`id`)
);

create table if not exists diseases(
	id int AUTO_INCREMENT not null,
    id_student int,
    disease varchar(50),
    deleted bit not null,
    PRIMARY KEY (`id`),
	CONSTRAINT `fk_students_diseases` FOREIGN KEY (`id_student`) REFERENCES `students` (`id`)
);

create table IF NOT EXISTS registrations(
	id int not null AUTO_INCREMENT,
    date_registration datetime,
    state int not null,
    period int not null,
	to_year int not null,
    deleted bit not null,
    PRIMARY KEY (`id`)
);

create table IF NOT EXISTS grades(
	id int not null AUTO_INCREMENT,
	grade varchar(30),
	deleted bit not null,
	enabled bit not null,
    primary key(id)
);

create table IF NOT EXISTS classes(
	id int not null AUTO_INCREMENT,
    id_subject_group int not null,
    id_subject int not null,
    id_type int not null,
    id_grade int not null,
    deleted bit not null,
    enabled bit not null,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_class_subj_group` FOREIGN KEY (`id_subject_group`) REFERENCES `subjects_group` (`id`),
    CONSTRAINT `fk_class_grade` FOREIGN KEY (`id_grade`) REFERENCES `grades` (`id`),
    CONSTRAINT `fk_class_subject` FOREIGN KEY (`id_subject`) REFERENCES `subjects` (`id`)
);

create table IF NOT EXISTS subjects_group(
	id int not null AUTO_INCREMENT,
    group_name varchar(20),
    deleted bit not null,
    primary key(id)
);

create table IF NOT EXISTS subjects(
	id int not null AUTO_INCREMENT,
    subjects_name varchar(20),
    subjects_code varchar(10),
    deleted bit not null,
    primary key(id)
);

create table if not exists subjects_classes(
	id int not null AUTO_INCREMENT,
	id_registration int not null,
	id_class int not null,
	deleted bit not null,
	enabled bit not null,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_subjects_registration` FOREIGN KEY (`id_registration`) REFERENCES `registrations` (`id`),
    CONSTRAINT `fk_subjects_class` FOREIGN KEY (`id_class`) REFERENCES `classes` (`id`)
);

create table IF NOT EXISTS notes_score(
	id int not null AUTO_INCREMENT,
    id_subject int,
    note int not null,
    percentage int not null,
    deleted bit not null,
    primary key(id),
    CONSTRAINT `fk_notes_subject_classes` FOREIGN KEY (`id_subject`) REFERENCES `subjects_classes` (`id`)
);

create table IF NOT EXISTS permits(
	id int AUTO_INCREMENT not null,
    typeDocument int not null,
    document varchar(25) not null,
    done bit not null,
    primary key(id)
);

create table IF NOT EXISTS settings(
	id int AUTO_INCREMENT not null primary key,
    name_option varchar(30),
    value_option varchar(30),
    group_option int,
    option_parent int null
);

create table IF NOT EXISTS provinces(
	id int not null
);

create table IF NOT EXISTS citys(
	id int
);

/*alter table document_types add constraint  pk_doc_types primary key(id);
alter table genders add constraint pk_genders primary key(id);
alter table characterization modify column id int not null;
alter table characterization add constraint pk_characterization primary key(id);
alter table religions modify column id int not null;
alter table religions add constraint pk_religions primary key(id);
ALTER TABLE religions AUTO_INCREMENT = 0;
ALTER TABLE `religions` MODIFY COLUMN `id` int NOT NULL AUTO_INCREMENT;
ALTER TABLE `characterization` MODIFY COLUMN `id` int NOT NULL AUTO_INCREMENT;
ALTER TABLE characterization AUTO_INCREMENT = 0;
alter table characterization modify column id int not null;
alter table document_types add constraint  pk_doc_types primary key(id);
ALTER TABLE `relative_types` MODIFY COLUMN `id` int NOT NULL AUTO_INCREMENT primary key;*/
  
