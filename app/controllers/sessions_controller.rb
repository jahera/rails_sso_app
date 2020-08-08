class SessionsController < Devise::SessionsController
    before_action :authorize_viewer, except: [:new, :create, :destroy]
    before_action :login_access, only: [ :create]

    def create
      @resource = User.find_by_email(params[:user][:email])
      if @resource && @resource.valid_password?(params[:user][:password])
         self.resource = warden.authenticate!(auth_options)
         p "==========   #{resource.consumer_service_url}"
         redirect_to "#{resource.consumer_service_url}?auth_token=#{resource.auth_token}"
      else
        redirect_to new_user_session_path(token: params[:user][:auth_token]), notice: "Invalid email or password"
      end
    end

  private

  def generate_auth_token id, email
    payload = {user_id: id, email: email}
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def login_access
    token = params[:user][:auth_token]
    @auth_token ||= JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    @email = @auth_token['email']
    @company_id = @auth_token['company_id'].to_i
    @user = User.where(company_id: @company_id, email: params[:user][:email]).first
    p "----------------------------------- #{@user.present?}"
    if @user.present? 
      return true
    else
      redirect_to new_user_session_path(token: params[:user][:auth_token]), notice: "Invalid email or password"
    end 
  end

end
