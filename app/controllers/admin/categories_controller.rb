class Admin::CategoriesController < AdminController
  def index
  	if puede "Ver Categoria"
  		@cats = Category.order(:position)
  	else
  		redirect_to access_denied_path
  	end
  end

  def new
  	if puede "Crear Categoria"
  		@cat = Category.new
  	else
  		redirect_to access_denied_path
  	end
  end

  def create
    @cat = Category.new(params[:category])

    if @cat.save
      redirect_to admin_category_path(@cat)
    else
      render :action => "new"
    end
  end

  def show
  	if puede "Modificar Categoria"
  		@cat = Category.find(params[:id])

      is = TagCategorization.where(:category_id => @cat.id).order('tag_position ASC')
      iss = [-1]
      @topicos = []
      is.each do |i|
        iss.push(i.tag_id)
        @topicos.push(Tag.find (i.tag_id))
      end

      @to_join = Tag.where("id not in (?)", iss)
  	else
  		redirect_to access_denied_path
  	end
  end

  def update
    @cat = Category.find(params[:id])
    if @cat.update_attributes(params[:category])
      redirect_to admin_category_path(@cat)
    else
      render :action => 'show'
    end
  end

  def destroy
    cat = Category.find(params[:id])
    cat.destroy

    redirect_to admin_categories_path
  end

  def up_tag
    @cat = Category.find(params[:category_id])
    tc = TagCategorization.where('category_id = (?) and tag_id = (?)', params[:category_id], params[:tag_id]).first
    if(tc.tag_position > 0)
      before_tc = TagCategorization.where('category_id = (?) and tag_position = (?)', params[:category_id], tc.tag_position - 1).first
      before_tc.tag_position = tc.tag_position
      before_tc.save
      tc.tag_position = tc.tag_position - 1
      tc.save
    end
    redirect_to admin_category_path(@cat)
  end

  def down_tag
    @cat = Category.find(params[:category_id])
    tc = TagCategorization.where('category_id = (?) and tag_id = (?)', params[:category_id], params[:tag_id]).first
    position = TagCategorization.where('category_id = (?)', params[:category_id]).maximum(:tag_position)
    if(tc.tag_position < position)
      after_tc = TagCategorization.where('category_id = (?) and tag_position = (?)', params[:category_id], tc.tag_position + 1).first
      after_tc.tag_position = tc.tag_position
      after_tc.save
      tc.tag_position = tc.tag_position + 1
      tc.save
    end
    redirect_to admin_category_path(@cat)
  end

  def remove_tag
    @cat = Category.find(params[:category_id])
    tc = TagCategorization.where('category_id = (?) and tag_id = (?)', params[:category_id], params[:tag_id])
    tc.delete_all
    redirect_to admin_category_path(@cat)
  end

  def add_tag
    @cat = Category.find(params[:id])
    new_tc = TagCategorization.new
    new_tc.category_id = @cat.id
    new_tc.tag_id = params[:tag_id]
    position = TagCategorization.where('category_id = (?)', params[:id]).maximum(:tag_position)
    if(position.nil?) then
      new_tc.tag_position = 0
    else
      new_tc.tag_position = position + 1
    end

    new_tc.save
    redirect_to admin_category_path(@cat)
  end
end
