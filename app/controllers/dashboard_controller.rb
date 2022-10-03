class DashboardController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show]

  def index
    @should_render_navbar = true
  end

  def show
    if @user.nil?
      redirect_to dashboard_path
      return
    end
    @links = @user.links.where.not(url: '', title: '').order(created_at: :asc)
  end

  def profile
    @should_render_navbar = true
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  rescue StandardError
    @user = nil
  end
end
