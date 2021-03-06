class BlogsController < ApplicationController

  before_action :authenticate_user!

  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.order("updated_at DESC").page(params[:page]).per(5)
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blogs_params)
    if @blog.save
      redirect_to blogs_path, notice: "作成しました"
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      render 'new'
    end
  end

  def show
    @comment = @blog.comments.build
    @comments = @blog.comments.order("created_at DESC")
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def edit
  end

  def update
    if @blog.update(blogs_params)
    redirect_to blogs_path, notice: "更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "削除しました"
  end

  def confirm
    @blog = Blog.new(blogs_params)
    render 'new' if @blog.invalid?
  end

  private
  def blogs_params
    params.require(:blog).permit(:title, :content).merge(user_id: current_user.id)
  end

  def set_blog
      @blog = Blog.find(params[:id])
  end
end
