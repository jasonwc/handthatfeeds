class ContactMailer < ActionMailer::Base

  def submission(message)
    @message = message

    mail( to: "marlenycotrim@gmail.com", 
          subject: "#{@message.subject}", 
          from: "#{@message.name}"
          )
  end

end
