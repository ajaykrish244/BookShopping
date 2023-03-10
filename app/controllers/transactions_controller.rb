class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    if current_user.id != nil
      @transactions = Transaction.where(user_id: current_user.id)
    else
      @transactions = Transaction.all
    end
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    if @book.nil?
      @book = Book.find(params[:book_id])
    end
    if current_user.credit_card_number != nil
      @credit_cards = current_user.credit_card_number
    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.transaction_number = Array.new(10){[*"A".."Z", *"0".."9"].sample}.join + @transaction.id.to_s
    @book = Book.find(params[:transaction][:book_id])
    # We link the transaction to the user and their credit card
    @book.with_lock do
    @transaction.user = current_user
    # We update the original product quantity
    @book.quantity = @book.quantity - @transaction.quantity
    if @book.quantity < 0
       redirect_to books_path, notice: "Book is out of stock." 
    else
    @book.save!
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end
end
end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:quantity, :total_cost, :book_id,
                                        :credit_card_number, :address,
                                        :phone_number)
  end
end
