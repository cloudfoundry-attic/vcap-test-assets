CREATE OR REPLACE PROCEDURE create_book (book_id IN NUMBER, book_title IN STRING, book_author IN STRING, book_category IN STRING)
IS
BEGIN
    INSERT INTO books(id, title, author, category)
    VALUES(book_id, book_title, book_author, book_category);
END create_book;
/

CREATE OR REPLACE PROCEDURE authored_books (author_name IN STRING)
  AS
  book_title    books.title%TYPE;
  book_category books.category%TYPE;
BEGIN
	  SELECT title, category INTO book_title, book_category FROM books
	  WHERE author = author_name;
END authored_books;
/
