class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(user_id: @blog.user.id)
    respond_to do |format|
      if @comment.save
        format.html {redirect_to blog_path(@blog), notice: "コメントを投稿しました"}
        format.js { render :index }
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したブログにコメントが付きました'
          })
        end
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
        })
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @blog = @comment.blog
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to blog_path(@comment.blog.id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.destroy
        format.js {render :index}
      else
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :blog_id)
  end
end
