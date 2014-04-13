class ContactMailer < ActionMailer::Base

  def submission(message)
    @message = message

    mail( to: "jasonwcarter@outlook.com", 
          subject: "#{@message.subject}", 
          from: "#{@message.name}"
          )
  end

end
