class ContactMailer < ActionMailer::Base

  def submission(message)
    @message = message

    mail( to: "politics@project.com", 
          subject: "#{@message.subject}", 
          from: "#{@message.name}"
          )
  end

end
