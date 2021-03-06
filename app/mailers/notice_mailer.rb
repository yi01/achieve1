class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #
  def sendmail_blog(blog)
    @blog = blog

    mail to: @blog.user.email,
    subject: '【Achieve】ブログが投稿されました'
  end

  def sendmail_content(contact)
    @contact = contact

    mail to: @contact.user.email,
    subject: 'お問い合わせが投稿されました'
  end
end
