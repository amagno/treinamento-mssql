USE master
GO

CREATE DATABASE treinamento
GO

USE treinamento;
GO

-- SCHEMAS
CREATE SCHEMA persons
GO

CREATE SCHEMA courses
GO

CREATE SCHEMA classes
GO

CREATE SCHEMA contents
GO

-- PERSONS TABLES

CREATE TABLE persons.users (
  id_user INT IDENTITY(1, 1) PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
  remove INT NOT NULL,
  id_user_type INT NOT NULL,
)
GO

CREATE TABLE persons.users_types (
  id_user_type INT IDENTITY(1, 1) PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
  remove INT NOT NULL,
)
GO

CREATE TABLE persons.users_logins (
  id_user_login INT IDENTITY(1, 1) PRIMARY KEY,
  id_user INT NOT NULL,
  date DATETIME NOT NULL,
)
GO

-- COURSES TABLES 

CREATE TABLE courses.courses (
  id_course INT IDENTITY(1, 1) PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
  removed INT NOT NULL
)
GO

CREATE TABLE courses.tutors (
  id_course_tutor INT IDENTITY(1, 1) PRIMARY KEY,
  id_course INT NOT NULL,
  id_user INT NOT NULL
)
GO
-- CLASSES TABLES 

CREATE TABLE classes.courses_classes_students (
  id_course_class_student INT IDENTITY(1, 1) PRIMARY KEY,
  id_course_class INT NOT NULL,
  id_user INT NOT NULL,
  removed INT NOT NULL,
)
GO

CREATE TABLE classes.courses_classes_tutors (
  id_course_class_tutor INT IDENTITY(1, 1) PRIMARY KEY,
  id_course_class INT NOT NULL,
  id_course_tutor INT NOT NULL,
  removed INT NOT NULL,
)
GO

CREATE TABLE classes.courses_classes (
  id_course_class INT IDENTITY(1, 1) PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
  id_course INT NOT NULL,
  removed INT NOT NULL,
)
GO

CREATE TABLE classes.courses_classes_schedule (
  id_schedule INT IDENTITY(1, 1) PRIMARY KEY,
  id_course_class INT NOT NULL,
  date DATETIME NOT NULL,
  date_finished DATETIME NOT NULL,
  removed INT NOT NULL,
)
GO

CREATE TABLE classes.courses_classes_contents (
  id_course_class_content INT IDENTITY(1, 1) PRIMARY KEY,
  description NVARCHAR(100) NOT NULL,
  id_course_class INT NOT NULL,
  removed INT NOT NULL,
)
GO

--  CONTENTS TABLES 

CREATE TABLE contents.courses_classes_activities_students (
  id_activity_classes_students INT IDENTITY(1, 1) PRIMARY KEY,
  id_activity INT NOT NULL,
  id_course_class_student INT NOT NULL,
  delivery_date DATETIME NOT NULL,
  removed INT NOT NULL,
)
GO

CREATE TABLE contents.courses_classes_activities (
  id_activity INT IDENTITY(1, 1) PRIMARY KEY,
  description NVARCHAR(100) NOT NULL,
  scheduled_date DATETIME NOT NULL,  
  id_course_class INT NOT NULL,
  removed INT NOT NULL,
)
GO

CREATE TABLE contents.assessments_students (
  id_assessment_student INT IDENTITY(1, 1) PRIMARY KEY, 
  id_course_class_student INT NOT NULL,
  id_assessment INT NOT NULL,
  note DECIMAL(5, 1) NOT NULL,
  removed INT NOT NULL,
)
GO

CREATE TABLE contents.courses_classes_assessments (
  id_assessment INT IDENTITY(1, 1) PRIMARY KEY,
  description NVARCHAR(100) NOT NULL,
  scheduled_date DATETIME NOT NULL,
  realization_date DATETIME NULL,  
  id_course_class INT NOT NULL,
  removed INT NOT NULL,
)
GO

-- CONSTRAINTS
  -- PERSONS

ALTER TABLE persons.users
ADD CONSTRAINT fk_user_type
FOREIGN KEY (id_user_type)
REFERENCES persons.users_types(id_user_type)
GO

ALTER TABLE persons.users_logins
ADD CONSTRAINT fk_user
FOREIGN KEY (id_user)
REFERENCES persons.users(id_user)
GO
  -- COURSES

ALTER TABLE courses.tutors
ADD CONSTRAINT fk_course
FOREIGN KEY (id_course)
REFERENCES courses.courses(id_course)
GO

ALTER TABLE courses.tutors
ADD CONSTRAINT fk_user
FOREIGN KEY (id_user)
REFERENCES persons.users(id_user)
GO

  -- CLASSES
ALTER TABLE classes.courses_classes
ADD CONSTRAINT fk_course
FOREIGN KEY (id_course)
REFERENCES courses.courses(id_course)
GO

ALTER TABLE classes.courses_classes_students
ADD CONSTRAINT fk_user
FOREIGN KEY (id_user)
REFERENCES persons.users(id_user)
GO

ALTER TABLE classes.courses_classes_students
ADD CONSTRAINT fk_students_course_class
FOREIGN KEY (id_course_class)
REFERENCES classes.courses_classes(id_course_class)
GO

ALTER TABLE classes.courses_classes_tutors
ADD CONSTRAINT fk_tutors_course_class
FOREIGN KEY (id_course_class)
REFERENCES classes.courses_classes(id_course_class)
GO

ALTER TABLE classes.courses_classes_tutors
ADD CONSTRAINT fk_course_tutor
FOREIGN KEY (id_course_tutor)
REFERENCES courses.tutors(id_course_tutor)
GO

ALTER TABLE classes.courses_classes_schedule
ADD CONSTRAINT fk_schedule_course_class
FOREIGN KEY (id_course_class)
REFERENCES classes.courses_classes(id_course_class)
GO

ALTER TABLE classes.courses_classes_contents
ADD CONSTRAINT fk_course_class
FOREIGN KEY (id_course_class)
REFERENCES classes.courses_classes(id_course_class)
GO

  -- CONTENTS

ALTER TABLE contents.courses_classes_activities
ADD CONSTRAINT fk_course_class
FOREIGN KEY (id_course_class)
REFERENCES classes.courses_classes(id_course_class)
GO

ALTER TABLE contents.courses_classes_activities_students
ADD CONSTRAINT fk_course_class_student
FOREIGN KEY (id_course_class_student)
REFERENCES classes.courses_classes_students(id_course_class_student)
GO

ALTER TABLE contents.courses_classes_activities_students
ADD CONSTRAINT fk_activity
FOREIGN KEY (id_activity)
REFERENCES contents.courses_classes_activities(id_activity)
GO

ALTER TABLE contents.courses_classes_assessments
ADD CONSTRAINT fk_course_class_assessments
FOREIGN KEY (id_course_class)
REFERENCES classes.courses_classes(id_course_class)
GO

ALTER TABLE contents.assessments_students
ADD CONSTRAINT fk_assessments_course_class_student
FOREIGN KEY (id_course_class_student)
REFERENCES classes.courses_classes_students(id_course_class_student)
GO

ALTER TABLE contents.assessments_students
ADD CONSTRAINT fk_assessment
FOREIGN KEY (id_assessment)
REFERENCES contents.courses_classes_assessments(id_assessment)
GO