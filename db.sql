DROP DATABASE IF EXISTS db_bookinfo;

CREATE DATABASE db_bookinfo;

USE db_bookinfo;

CREATE TABLE book (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    image_url VARCHAR(512) NOT NULL,
    download_url VARCHAR(512) NOT NULL,
    read_url VARCHAR(512) DEFAULT NULL
);

CREATE TABLE book_text_sections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    type ENUM('about', 'thought_process') NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);

CREATE TABLE book_artist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    artist_name VARCHAR(255),
    artist_url VARCHAR(512),
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);

CREATE TABLE book_wallpapers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    image_url VARCHAR(512) NOT NULL,
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);

CREATE TABLE book_deleted (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    scene_url VARCHAR(512) NOT NULL,
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);


INSERT INTO book (title, image_url, download_url)
VALUES (
    'Book 1 of the series',
    'https://picsum.photos/300/600',
    'https://example.com/books/book1-download.pdf'
);


INSERT INTO book (title, image_url, download_url)
VALUES (
    'Book 1 of the series',
    'https://example.com/images/book1.jpg',
    'https://example.com/books/book1-download.pdf'
);

INSERT INTO book_text_sections (book_id, type, content)
VALUES (
    2,
    'about',
    'This is a deep, emotional exploration of a hidden world and the lives it touches.'
);

INSERT INTO book_artist (book_id, artist_name, artist_url)
VALUES (
    2,
    'Jett Blacksmith',
    'https://example.com/artists/jett-blacksmith'
);

INSERT INTO book_wallpapers (book_id, image_url)
VALUES (2, 'https://example.com/wallpapers/book1-1.jpg');


INSERT INTO book (title, image_url, download_url)
VALUES (
    'Book 1 of the series',
    'https://example.com/images/book1.jpg',
    'https://example.com/books/book1-download.pdf'
);

INSERT INTO book_text_sections (book_id, type, content)
VALUES (
    3,
    'about',
    'This is a deep, emotional exploration of a hidden world and the lives it touches.'
);


INSERT INTO book (title, image_url, download_url, read_url)
VALUES (
    'Book 1 of the series',
    'https://picsum.photos/300/600',
);