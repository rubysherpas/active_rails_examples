# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def new_comment
    project = Project.new(id: 1)
    ticket = project.tickets.build(id: 1)
    user = User.new
    comment = ticket.comments.build(author: user)

    CommentMailer.with(comment: comment, user: comment.author).new_comment
  end
end
