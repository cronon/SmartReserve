class MarkdownController < ApplicationController
  def preview
    @text = params[:data]
    render :layout => false
  end
end