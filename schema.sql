
-- schema.sql

DROP TABLE IF EXISTS enrollments, reviews, courses, instructors, students, categories CASCADE;

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    registered_on DATE
);

CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    bio TEXT
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    description TEXT,
    instructor_id INT REFERENCES instructors(instructor_id),
    category_id INT REFERENCES categories(category_id),
    price NUMERIC(10, 2),
    published_on DATE
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    enrolled_on DATE
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    reviewed_on DATE
);
