class LinksController < ApplicationController
  before_action :authenticate_user!, only: [:update]
  before_action :link_params, only: [:update]

  def create
    @link = current_user.links.create(title: '', url: '')
    redirect_to request.referrer, notice: 'Link created'
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to request.referrer, notice: 'Link deleted'
  end

  def update
    @link = Link.find(params[:id])
    @link.update(link_params)
    redirect_to request.referrer, notice: 'Link updated'
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
