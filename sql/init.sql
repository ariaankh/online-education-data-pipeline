-- ۱. جدول مدرسین
CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ۲. جدول دوره‌ها
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    instructor_id INT REFERENCES instructors(instructor_id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ۳. جدول دانشجویان
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ۴. جدول ثبت‌نام‌ها
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'active',
    progress_percent NUMERIC(5, 2) DEFAULT 0.00
);

-- ۵. جدول پرداخت‌ها
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    amount NUMERIC(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status VARCHAR(20) DEFAULT 'pending',
    payment_method VARCHAR(50)
);

-- ۶. جدول نظرات
CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ۷. جدول درس‌ها
CREATE TABLE lessons (
    lesson_id SERIAL PRIMARY KEY,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    content_type VARCHAR(50),
    duration_minutes INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ۸. جدول آزمون‌ها
CREATE TABLE quizzes (
    quiz_id SERIAL PRIMARY KEY,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    total_questions INT NOT NULL,
    passing_score INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ۹. جدول گواهینامه‌ها
CREATE TABLE certificates (
    certificate_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    certificate_code VARCHAR(100) UNIQUE NOT NULL
);

-- ۱۰. جدول لاگ‌ها
CREATE TABLE logs (
    log_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE SET NULL,
    action VARCHAR(100) NOT NULL,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT
);
