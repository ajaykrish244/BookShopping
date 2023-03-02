class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    #debugger
    if params[:search_by_username].present?
      @reviews = Review.where(user: User.where(username: params[:search_by_username]).first,book: @book)
  end
end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    if current_user.id!=@review.user_id and current_user.username!="AdminUser"
      flash[:notice] = "Not able to access this"
      redirect_to root_path
    end
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @review.book=@book
    @review.user=@current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to book_reviews_path, notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to book_reviews_path, notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to book_reviews_path, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book=Book.find(params[:book_id])
    end

    def set_review
      #@review = Review.find(params[:id])
      @review = @book.reviews.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :review)
    end
end
