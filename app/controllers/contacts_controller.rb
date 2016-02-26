class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contacts }
    end
    # render json: @contacts
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    render json: @contact
  end

  def new
    @contact = Contact.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end
  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      UserMailer.contact_email(@contact).deliver_now
      redirect_to thankyou_bookings_path
      # render :text => "<p>Your message has been sent.</p>".html_safe

    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      head :no_content
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    head :no_content
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end
    def contact_params
      params.require(:contact).permit(:phone, :email, :mobile, :message, :mtype)
    end
end
