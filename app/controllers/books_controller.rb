class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    if params[:search_by_author].present?
      @books = Book.where('lower(author) =?',params[:search_by_author].downcase)
    elsif params[:search_by_book].present?
      @books = Book.where('lower(name) =?',params[:search_by_book].downcase)
    elsif params[:search_by_rating].present?
      @books = Book.where(id: Review.where('rating > ?', params[:search_by_rating]).pluck(:book_id))
    else
      @books = Book.all
    end
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    if !current_user.admin?
      flash[:notice] = "Not able to access this"
      redirect_to root_path
      return
    else
      @book = Book.new
    end
  end

  # GET /books/1/edit
  def edit
    if !current_user.admin?
      flash[:notice] = "Not able to access this"
      redirect_to root_path
      return
    end
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id]) unless action_name == "index"
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:name, :author, :publisher, :price, :quantity)
  end
end
