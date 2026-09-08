-- =========================================================
-- MINI PROJECT FULL-STACK WEB DEVELOPMENT
-- CASE STUDY: LEARNING MANAGEMENT SYSTEM (LMS)
-- LINK DRAW.IO :  https://app.diagrams.net/#G1pfRmbVMUH2AhUmvN4qsCuAmLwaOqJ5kV#%7B%22pageId%22%3A%22aiFxxEzGud-hVxVeEYMo%22%7D
-- =========================================================

-- Hapus database jika sebelumnya sudah ada
DROP DATABASE IF EXISTS db_tulearn;

-- Membuat database
CREATE DATABASE db_tulearn;

-- Menggunakan database
USE db_tulearn;

-- Table: users
CREATE TABLE users (
	user_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('student', 'instructor', 'admin', 'guest') NOT NULL DEFAULT 'guest',
    
    PRIMARY KEY (user_id)
);

-- Table: course_category
CREATE Table course_category (
	category_id INT AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    
    PRIMARY KEY (category_id)
);

-- Table: course
CREATE TABLE course (
	course_id INT AUTO_INCREMENT,
    instructor_id INT NOT NULL,
    category_id INT NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    quota INT NOT NULL,
    course_level ENUM('easy', 'medium', 'hard') NOT NULL DEFAULT 'easy',
    
    PRIMARY KEY (course_id),
    
    CONSTRAINT fk_course_instructor
    	FOREIGN KEY (instructor_id)
    	REFERENCES users(user_id)
    	ON UPDATE CASCADE
    	ON DELETE RESTRICT,
    
    CONSTRAINT fk_course_category
    	FOREIGN KEY (category_id)
    	REFERENCES course_category(category_id)
    	ON UPDATE CASCADE
    	ON DELETE RESTRICT
);

-- Insert Data: users
INSERT INTO users (name, email, role) VALUES
('Andi Saputra', 'andi@tulearn.com', 'student'),
('Budi Santoso', 'budi@tulearn.com', 'instructor'),
('Citra Lestari', 'citra@tulearn.com', 'student'),
('Deni Pratama', 'deni@tulearn.com', 'instructor'),
('Eka Putri', 'eka@tulearn.com', 'student'),
('Fajar Ramadhan', 'fajar@tulearn.com', 'instructor'),
('Gita Permata', 'gita@tulearn.com', 'student'),
('Hendra Wijaya', 'hendra@tulearn.com', 'instructor'),
('Intan Sari', 'intan@tulearn.com', 'student'),
('Joko Susilo', 'joko@tulearn.com', 'instructor'),
('Kartika Dewi', 'kartika@tulearn.com', 'student'),
('Lukman Hakim', 'lukman@tulearn.com', 'instructor'),
('Maya Anggraini', 'maya@tulearn.com', 'student'),
('Nanda Kurniawan', 'nanda@tulearn.com', 'admin'),
('Olivia Maharani', 'olivia@tulearn.com', 'guest');

-- Insert Data: course_categories
INSERT INTO course_category (category_name) VALUES
('Web Development'),
('Programming'),
('Database'),
('Mobile Development'),
('Data Science'),
('UI/UX Design'),
('DevOps'),
('Cyber Security'),
('Artificial Intelligence'),
('Cloud Computing'),
('Game Development'),
('Digital Marketing'),
('Microsoft Office'),
('Software Testing'),
('Computer Networking');

-- Insert Data: course
INSERT INTO course (instructor_id, category_id, course_name, price, quota, course_level) VALUES
(2, 1, 'HTML & CSS Fundamental', 75000, 30, 'easy'),
(4, 1, 'JavaScript Fundamental', 150000, 25, 'easy'),
(6, 1, 'React JS Fundamental', 250000, 20, 'medium'),
(8, 1, 'Laravel Web Development', 550000, 15, 'hard'),
(10, 2, 'Python Fundamental', 175000, 30, 'easy'),
(12, 2, 'Java Programming', 300000, 20, 'medium'),
(2, 3, 'MySQL Database Fundamental', 125000, 35, 'easy'),
(4, 3, 'Advanced SQL Query', 200000, 25, 'hard'),
(6, 4, 'Flutter Mobile Development', 450000, 20, 'medium'),
(8, 4, 'Dart Programming', 150000, 25, 'easy'),
(10, 5, 'Data Science Fundamental', 600000, 15, 'hard'),
(12, 5, 'Machine Learning Fundamental', 750000, 10, 'hard'),
(2, 6, 'UI/UX Design Fundamental', 100000, 30, 'easy'),
(4, 7, 'Docker & DevOps Fundamental', 550000, 20, 'medium'),
(6, 8, 'Cyber Security Fundamental', 650000, 0, 'hard');

-- =========================================================
-- SQL FUNDAMENTAL
-- =========================================================
-- SOAL 1: Tampilkan seluruh data course
SELECT * FROM course;

-- SOAL 2: Tampilkan nama course dan harga saja.
SELECT course_name, price FROM course;

-- SOAL 3: Tampilkan course dengan harga antara 50.000 sampai 200.000.
SELECT * FROM course WHERE price BETWEEN 50000 AND 200000;

-- SOAL 4: Tampilkan course yang memiliki kuota 0 ATAU harga di atas 500.000.
SELECT * FROM course WHERE quota = 0 OR price > 500000;

-- SOAL 5: Tampilkan 5 course dengan harga tertinggi.
SELECT * FROM course ORDER BY price DESC LIMIT 5;

-- =========================================================
-- AGGREGATE & CONDITIONAL LOGIC
-- =========================================================
-- SOAL 6: Hitung total user yang terdaftar.
SELECT COUNT(user_id) AS total_user FROM users;

-- SOAL 7: Hitung total course yang tersedia.
SELECT COUNT(course_id) AS total_course FROM course;

-- SOAL 8: Hitung jumlah course per kategori.
SELECT
	cc.category_name,
	COUNT(c.course_id) AS total_grouped_course 
FROM 
	course_category cc LEFT JOIN course c ON cc.category_id = c.category_id
GROUP BY 
	c.category_id,
    cc.category_name;

-- SOAL 9: Hitung rata-rata harga course per kategori.
SELECT
	cc.category_name,
    ROUND(AVG(c.price), 2) AS AVG_course_price
FROM
	course_category cc LEFT JOIN course c ON cc.category_id = c.category_id
GROUP BY
	c.category_id,
    cc.category_name;

-- SOAL 10: Tampilkan kategori yang memiliki lebih dari 3 course.
SELECT
	cc.category_name,
    COUNT(c.category_id) AS total_course
FROM 
	course_category cc LEFT JOIN course c ON cc.category_id = c.category_id
GROUP BY 
	c.category_id,
	cc.category_name
HAVING
	COUNT(c.course_id) > 3;

-- =========================================================
-- JOIN STATEMENTS
-- =========================================================
-- SOAL 11: Tampilkan daftar course beserta nama kategorinya.
SELECT
	c.course_name,
    cc.category_name
FROM
	course_category cc LEFT JOIN course c ON cc.category_id = c.category_id
WHERE
	c.course_name IS NOT NULL;

-- SOAL 12: Tampilkan semua kategori meskipun belum memiliki course.
SELECT
	c.course_name,
    cc.category_name
FROM
	course_category cc LEFT JOIN course c ON cc.category_id = c.category_id;

-- SOAL 13: Tampilkan semua user meskipun belum pernah mengupload course.
SELECT
	u.name,
    u.role,
    c.course_name
FROM
	users u LEFT JOIN course c ON u.user_id = c.instructor_id;

-- SOAL 14: Tampilkan daftar course beserta nama instructor yang membuat course tersebut.
SELECT
	u.name,
    u.role,
    c.course_name
FROM
	users u LEFT JOIN course c ON u.user_id = c.instructor_id
WHERE 
	u.role = "instructor";

-- SOAL 15: Tampilkan jumlah course yang dibuat oleh masing-masing instructor.
SELECT
    u.name,
    u.role,
	COUNT(c.course_name) AS total_course
FROM 
	users u LEFT JOIN course c ON u.user_id = c.instructor_id
WHERE
	u.role = "instructor"
GROUP BY
	u.user_id;

-- Tambahan: Indexing
CREATE INDEX idx_course_price ON course(price);
SHOW INDEX FROM course;

-- Tambahan: Explain
EXPLAIN SELECT * FROM course WHERE price > 500000;

-- Tambahan: FILTER
EXPLAIN SELECT * FROM course WHERE course_name LIKE '%JAVA%';