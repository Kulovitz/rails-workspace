class ContactsController < ApplicationController
    
    # GET request to /contact-us
    # Show new contact form 
    def new
        @contact = Contact.new
    end
    
    # POST request /contacts
    def create
        # Mass assignment of form fields into contact object
        @contact = Contact.new(contact_params)
        # Save the contact object to database
        if @contact.save
            # Store form fields via parameters, into variables
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            # Plug variables into Contact mailer email method
            ContactMailer.contact_email(name, email, body).deliver
            
            flash[:success] = "Message Sent."
            # Store success message in flash field
            # and redirect to new action
            redirect_to new_contact_path
        else
            flash[:danger] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        end
    end
private
    def contact_params
        params.require(:contact).permit(:name, :email, :comments)
    end
end    