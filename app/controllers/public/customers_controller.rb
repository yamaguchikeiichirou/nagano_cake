class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customers_mypage_path,notice: "You have updated user successfully."
  end

  def verification
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    @customer.update(customer_params)
    reset_session
    redirect_to  root_path
  end

   private

  def customer_params
    params.require(:customer).permit(:email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end

end
