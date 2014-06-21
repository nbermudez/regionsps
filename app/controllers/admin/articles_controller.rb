class Admin::ArticlesController < ApplicationController
  def index
    if puede "Ver Articulo"
      if params[:page].nil?
        params[:page] = 1
      end
      @articles = Article.order("id desc").paginate(:page => params[:page], :per_page => 15)
    else
      redirect_to access_denied_path
    end
  end

  def active
    if puede "Modificar Articulo"
      @article = Article.find(params[:id])

      @article.active = !@article.active

      respond_to do |format|
      if @article.save
          flash[:notice] = "El articulo #{@article.active ? ' se mostrara' : 'no se mostrara'} en el slider principal."
      else
          flash[:alert] = "Lo sentimos, El articulo no pudo #{!@article.active ? 'mostrar en' : 'quitar de'} el slider."
      end
        format.js
      end
    else
      redirect_to access_denied_path
    end
  end

  def publish
    if puede "Modificar Articulo"
      @article = Article.find(params[:id])

      @article.published = !@article.published

      respond_to do |format|
        if @article.save
          flash[:notice] = "El articulo fue marcado como #{@article.published ? 'publicado' : ' no publicado'}."
        else
          flash[:alert] = "Lo sentimos, El articulo no pudo ser marcado como #{!@article.published ? 'publicado' : 'no publicado'}."
        end
        format.js
      end
    else
      redirect_to access_denied_path
    end
  end

  def new
    if puede "Crear Articulo"
      @article = Article.new
      @article.resource= Resource.new
    else
      redirect_to access_denied_path
    end
  end

  def create
    if params[:cancel]
      redirect_to admin_articles_url
    else
      @article = Article.new(params[:article])
      if !params[:article][:resource_attributes][:file].nil?
        @article.resource.content_type = params[:article][:resource_attributes][:file].content_type
      end
      if @article.save!
        t = Tag.find_by_title("GENERAL")
        if t.nil?
          t = Tag.create(:title => "GENERAL")
        end
        tt = Tagging.new
        tt.resource_id = @article.resource.id
        tt.tag_id = t.id
        tt.save

        redirect_to admin_article_path(@article)
        return
      else
        render :action => "new"
      end
    end
  end

  def show
    if puede "Ver Articulo"
      @resource = Resource.find(params[:id])
      @tags_available = Array.new
      @tags = Array.new
      tmp = [-1]

      tags = Tagging.where(:resource_id => @resource.id)
      tags.each do |t|
        tmp.push(t.tag_id)
      end
      #@tags = Tag.where('id in (?)', tmp)

      tags = Tag.where('id not in (?)', tmp)
      tags.each do |t|
        @tags_available.push([t.title, t.id])
      end
    else
      redirect_to access_denied_path
    end
  end

  def edit
    if puede "Modificar Articulo"
      @article = Article.find(params[:id])
    else
      redirect_to access_denied_path
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:resource])
      redirect_to admin_articles_path
    else
      render "edit"
    end
  end

  def destroy
    if puede "Eliminar Articulo"
      @article = Article.find(params[:id])

      respond_to do |format|
        if @article.destroy
          flash[:notice] = "El articulo fue eliminado."
        else
          flash[:alert] = "Lo sentimos, El articulo no pudo ser eliminado."
        end
        format.js
      end
    else
      redirect_to access_denied_path
    end
  end
end
