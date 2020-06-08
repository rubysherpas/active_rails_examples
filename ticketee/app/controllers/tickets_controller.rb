class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
    @attachments = []
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user
    @ticket.attachments.attach(params[:attachments])
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      @attachments = []
      if params[:attachments]
        @attachments = params[:attachments].map do |attachment|
          blob = ActiveStorage::Blob.find_signed(attachment)
          { signedId: blob.signed_id, name: blob.filename, size: blob.byte_size, path: rails_blob_url(blob) }
        end
      end
      flash.now[:alert] = "Ticket has not been created."
      render "new"
    end
  end

  def show
  end

  def edit
    @attachments = []
  end

  def update
    if @ticket.update(ticket_params)
      @ticket.attachments.attach(params[:attachments])
      flash[:notice] = "Ticket has been updated."
      redirect_to [@project, @ticket]
    else
      @attachments = []
      if params[:attachments]
        byebug
        @attachments = params[:attachments].map do |attachment|
          blob = ActiveStorage::Blob.find_signed(attachment)
          { signedId: blob.signed_id, name: blob.filename, size: blob.byte_size, path: rails_blob_url(blob) }
        end
      end
      flash.now[:alert] = "Ticket has not been updated."
      render "edit"
    end
  end
  
  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted."
  
    redirect_to @project
  end

  def upload_file
    blob = ActiveStorage::Blob.create_and_upload!(io: params[:file], filename: params[:file].original_filename)
    render json: { signedId: blob.signed_id }
  end
  
  private

  def ticket_params
    params.require(:ticket).permit(:name, :description, attachments: [])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end
  
end
