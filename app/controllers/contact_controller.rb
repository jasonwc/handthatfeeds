class ContactController < ApplicationController
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.valid?
        ContactMailer.submission(@contact).deliver
        format.html { redirect_to root_path, notice: 'Email was successfully created.' }
      else
        format.html { render action: "new", alert: "There was a problem." }
      end
    end
  end
end
