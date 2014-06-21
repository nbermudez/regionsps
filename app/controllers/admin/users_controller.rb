class Admin::UsersController < AdminController
	def index
		if puede "Ver Usuario"
			@users = User.order(:first_name,:last_name)
		else
			redirect_to access_denied_path
		end
	end

	def new
		if puede "Crear Usuario"
			@user = User.new
		else
			redirect_to access_denied_path
		end
	end

	def create
		if params[:cancel]
			redirect_to admin_users_url
		else
			@user = User.new(params[:user])

			if @user.save
				redirect_to admin_users_url, :notice => 'Usuario creado exitosamente.'
			else
				render :action => "new"
			end
		end		
	end

	def show
		if puede "Ver Usuario"
			@user = User.find(params[:id])
		else
			redirect_to access_denied_path
		end
	end

	def destroy
		if puede "Eliminar Usuario"
			@user = User.find(params[:id])
			@user.destroy

			redirect_to admin_users_url
		else
			redirect_to access_denied_path
		end
	end

	def edit
		if puede "Modificar Usuario"
			@user = User.find(params[:id])
		else
			redirect_to access_denied_path
		end
	end

	def update
		@user = User.find(params[:id])
		if params[:cancel]
			redirect_to admin_user_path(@user.id)
			return 
		else			
			if @user.has_password?(params[:user][:password_old])
				if @user.update_attributes(params[:user])
					redirect_to admin_user_path(@user.id)
				else
					render :action => 'edit'
				end
			else
				render :action => 'edit'
			end
		end
	end
end
