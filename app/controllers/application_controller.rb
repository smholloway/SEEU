class ApplicationController < ActionController::Base
  # Turning off forgery protection to allow Sun SPOTs to post without 
  # authenticity token
  #protect_from_forgery

  # pretty up errors when resources are not found
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
    flash[:error] = 'resource was not found.'
    respond_to do |format|
      format.html { redirect_to :root }
    end
  end
end
