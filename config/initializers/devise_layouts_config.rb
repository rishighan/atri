 Atri::Application.configure do
    config.to_prepare do
      #Devise::SessionsController.layout       "admin"
      #Devise::RegistrationsController.layout  "admin"
      #Devise::ConfirmationsController.layout  "admin"
      #Devise::UnlocksController.layout        "admin"
      #Devise::PasswordsController.layout      "admin"
    end
  end
