class ContactMailer < ActionMailer::Base


  def submission(message)
    @message = message

    # we can change the to: line when we have a project email
    mail( to: "politics@project.com", 
          subject: "#{@message.subject}", 
          from: "#{@message.name}"
          )
  end

end
