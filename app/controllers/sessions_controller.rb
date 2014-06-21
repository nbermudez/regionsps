#encoding: UTF-8
class SessionsController < ApplicationController
  def create
  	user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
    else
      sign_in user
    end
    @current_page = "ADMIN"
  	render :action => 'admin'

  end

  def admin
		@current_page = "ADMIN"
	end

  def destroy
    sign_out
    redirect_to root_path
  end

  def forgot_password

  end

  def reset_password_request
    @user = User.find_by_email(params[:email])
    puts @user.id
    respond_to do |format|
      unless @user.nil?

        if @user.make_password_reset_code
          UserMailer.reset_passwort_request(@user).deliver
          flash[:notice] = "Enviamos un correo con las instrucciones de recuperacion"
        else
          flash[:alert] = 'Lo sentimos, por favor intentalo nuevamente'
        end
      else
        flash[:alert] = "Lo sentimos, El email ingresado no coincide con ninguno de nuestros registros."
      end
      format.js
    end
  end

  def reset_password
    if params[:token].nil? || params[:id].nil? || params[:token]=="" || params[:id]==""
      flash[:alert] = "Lo sentimos, los datos proveidos para restablecer su contraseña no son correctos, por favor solicite un nuevo link de restablecimiento de contrasena."
      redirect_to signin_path
    end
    @user = User.where(:id => params[:id],:password_reset_code => params[:token]).first

    if @user.nil?
      flash[:alert] = "Lo sentimos, El token de el link que esta utilizando vencio, por favor solite un nuevo link de restablecimiento de contrasena."
      redirect_to signin_path
    end
  end

  def update_password

      if params[:session][:password]==params[:session][:password_confirmation]
        @user = User.find(params[:session][:id])
        @user.password = params[:session][:password]
        @user.password_reset_code = ""
        if @user.save
          flash[:notice] = "Su contraseña fue restablecida correctamente!"
          render :js => "window.location = '/admin'"
        else
          flash[:alert] = "Lo sentimos, por alguna razon no pudimos restablecer tu contraseñas, intentalo nuevamente!"
          respond_to do |format|
            format.js
          end
        end
      else
        flash[:alert] = "Las contraseñas ingresadas no coinciden, por favor vuelve a intentarlo!"
        respond_to do |format|
          format.js
        end
      end


  end

end
