class PagesController < ApplicationController
  layout 'landing'

  def index
    redirect_to account_path if current_user
  end

  def manifesto
    render :index
  end

  def disclaimer; end
  def credits; end
  def contacts; end
end
