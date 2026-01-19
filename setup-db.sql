-- LinkedIn Profile Review Database Setup

-- Create database
CREATE DATABASE IF NOT EXISTS `linkedin-profile-score-checker`;
USE `linkedin-profile-score-checker`;

-- LinkedIn Profile Review Database Setup

-- Create database
CREATE DATABASE IF NOT EXISTS `linkedin_profile_score_checker`;
USE `linkedin_profile_score_checker`;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) DEFAULT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    isEmailVerified BOOLEAN DEFAULT FALSE,
    aiTokensUsed INT DEFAULT 0,
    aiTokensLimit INT DEFAULT 100,
    subscription ENUM('free', 'premium', 'enterprise') DEFAULT 'free',
    profileReviewsCount INT DEFAULT 0,
    lastActive TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resetPasswordToken VARCHAR(255) DEFAULT NULL,
    resetPasswordExpire TIMESTAMP NULL DEFAULT NULL,
    emailVerificationToken VARCHAR(255) DEFAULT NULL,
    emailVerificationExpire TIMESTAMP NULL DEFAULT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Profile reviews table
CREATE TABLE IF NOT EXISTS profile_reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    jobProfile VARCHAR(255) NOT NULL,
    profileType ENUM('Full-time', 'Part-time', 'Freelancer', 'Intern', 'Consultant', 'Contract', 'Temporary') NOT NULL,
    experience INT NOT NULL,
    linkedinHeader TEXT NOT NULL,
    rating INT NOT NULL,
    suggestions JSON NOT NULL,
    tokensUsed INT DEFAULT 0,
    aiModel VARCHAR(100) DEFAULT 'gemini-1.5-flash',
    processingTime INT DEFAULT 0,
    isBookmarked BOOLEAN DEFAULT FALSE,
    tags JSON DEFAULT NULL,
    feedbackRating INT DEFAULT NULL,
    feedbackComment TEXT DEFAULT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_profile_reviews_user_id ON profile_reviews(userId);
CREATE INDEX idx_profile_reviews_created_at ON profile_reviews(createdAt);

SHOW TABLES;
DESCRIBE users;
DESCRIBE profile_reviews;