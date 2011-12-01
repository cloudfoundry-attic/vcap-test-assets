class DbController < ApplicationController
  # /db/init
  def init
    # create ruby book
    book = Book.new do |b|
      b.title = "Ruby"
      b.author = "RubyAuthor"
      b.category = "Programming"
    end
    book.save

    # create rails book
    book = Book.new do |b|
      b.title = "Rails"
      b.author = "RailsAuthor"
      b.category = "Programming"
    end
    book.save

    books = Book.all

    respond_to do |format|
      format.json { render json: books }
    end
  end

  # /db/query?id=
  def query
    book = Book.find(params[:id])
    respond_to do |format|
      format.json { render json: book }
    end
  end

  # /db/update?id=&title=
  def update
    book = Book.find(params[:id])
    book.title = params[:title]
    book.save
    respond_to do |format|
      format.json { render json: book }
    end
  end

  # /db/create?author=&title=&category=
  def create
    book = Book.new do |b|
      b.author = params[:author]
      b.title = params[:title]
      b.category = params[:category]
    end
    book.save
    respond_to do |format|
      format.json { render json: book }
    end
  end

  # /db/delete?id=
  def delete
    book = Book.find(params[:id])
    book.destroy
    respond_to do |format|
      format.json { render json: "delete book" }
    end
  end

  # /db/sp_create?author=&title=&category=
  def sp_create
    id = Random.new.rand(5000..10000)
    plsql.create_book(id,
                      params[:title],
                      params[:author],
                      params[:category])
    book = Book.find(id)
    respond_to do |format|
      format.json { render json: book }
    end
  end

  # /db/sp_authored_books?author=
  def sp_authored_books
    book = plsql.authored_books(params[:author])
    respond_to do |format|
      format.json { render json: "book" }
    end
  end
end