class ContactsController < ApplicationController

  before_action :authenticate_user!

  def new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end

  def create
    @contact = Contact.new(contacts_params)
    if @contact.save
      redirect_to blogs_path, notice: "お問い合わせありがとうございました"
      NoticeMailer.sendmail_content(@contact).deliver
    else
      render 'new'
    end
  end

  def confirm
    @contact = Contact.new(contacts_params)
    render 'new' if @contact.invalid?
  end

  private
  def contacts_params
    params.require(:contact).permit(:name, :email, :content).merge(user_id: current_user.id)
  end
end
