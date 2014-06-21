class ArticlesController < ApplicationController
  layout "application"
  def index
    if params[:page].nil?
      params[:page] = 1
    end
    @articles = Article.where(:published=>true).order("id desc").paginate(:page => params[:page], :per_page => 15)
  end
end
