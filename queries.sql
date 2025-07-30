
-- queries.sql

-- 1. List all students
SELECT * FROM students;

-- 2. Show all course titles along with instructor names
SELECT c.title, i.name AS instructor
FROM courses c
JOIN instructors i ON c.instructor_id = i.instructor_id;

-- 3. Count how many students enrolled in each course
SELECT c.title, COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.title;

-- 4. List courses that have no reviews
SELECT title FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM reviews
);

-- 5. Count how many courses are in each category
SELECT cat.name, COUNT(c.course_id) AS total_courses
FROM categories cat
LEFT JOIN courses c ON c.category_id = cat.category_id
GROUP BY cat.name;

-- 6. Find the course with the highest number of enrollments
SELECT c.title, COUNT(e.enrollment_id) AS total
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.title
ORDER BY total DESC
LIMIT 1;

-- 7. Find the instructor whose courses have the highest average rating
SELECT i.name, AVG(r.rating) AS avg_rating
FROM instructors i
JOIN courses c ON i.instructor_id = c.instructor_id
JOIN reviews r ON c.course_id = r.course_id
GROUP BY i.name
ORDER BY avg_rating DESC
LIMIT 1;

-- 8. List students who gave 5-star ratings
SELECT s.name, r.rating
FROM reviews r
JOIN students s ON r.student_id = s.student_id
WHERE r.rating = 5;

-- 9. Calculate revenue for each course (price * enrolled students)
SELECT c.title, c.price * COUNT(e.enrollment_id) AS revenue
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;

-- 10. List students enrolled in more than one course
SELECT s.name, COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.name
HAVING COUNT(e.course_id) > 1;

-- 11. Show average rating for all courses
SELECT c.title, ROUND(AVG(r.rating),2) AS avg_rating
FROM courses c
LEFT JOIN reviews r ON c.course_id = r.course_id
GROUP BY c.title;

-- 12. List students who have written more than 2 reviews
SELECT s.name, COUNT(r.review_id) AS total_reviews
FROM students s
JOIN reviews r ON s.student_id = r.student_id
GROUP BY s.name
HAVING COUNT(r.review_id) > 2;

-- 13. List course titles reviewed in the last 30 days
SELECT DISTINCT c.title
FROM courses c
JOIN reviews r ON c.course_id = r.course_id
WHERE r.reviewed_on >= CURRENT_DATE - INTERVAL '30 days';

-- 14. Find instructors who have more than 3 courses
SELECT i.name, COUNT(c.course_id) AS total_courses
FROM instructors i
JOIN courses c ON i.instructor_id = c.instructor_id
GROUP BY i.name
HAVING COUNT(c.course_id) > 3;

-- 15. Find the course with the lowest average rating
SELECT c.title, ROUND(AVG(r.rating),2) AS avg_rating
FROM courses c
JOIN reviews r ON c.course_id = r.course_id
GROUP BY c.title
ORDER BY avg_rating ASC
LIMIT 1;
