class UsersController < ApplicationController

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user:@user, token:token}, status: :ok
    else
      render json: {error: "Erro"}, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: user_params[:email])

    if @user && @user.authenticate(user_params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user:@user, token: token}, status: :ok
    else
      render json: {error: "Usuário ou senha inválidos."}, status: :unprocessable_entity
    end
  end

  def getAuthorized
    if !authorized_user
      render json: {error: "Não autorizado"}, status: :unauthorized
      return
    end
    render json: {user: authorized_user}, status: :ok
  end


  private


  def user_params
    params.permit(:username, :email, :password)
  end
end
