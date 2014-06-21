class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_passwort_request.subject
  #
  def reset_passwort_request(user)
    @greeting = "Hola " + user.name + ","
    @message_with_style = "Se ha solicitado restablecer tu contrasena!"
    @message = "Para asegurar la seguridad de tu informacion, por favor utiliza una contrasena fuerte, que incluya letras en mayuscula y minusculas, que incluya numeros, que no sean tus nombres, los nombres de tus hijos y/o fechas de nacimiento, trata de agregar caracteres no comunes como $ % & / ? ! #."
    @code = user.password_reset_code
    @id = user.id
    mail(from: 'no-reply@regionsps.org', to: user.email , subject: "Restablecimiento de Contrasena")
  end
end
