class UsersController < ApplicationController
  def index
    render json: User.order(:last_name, :first_name).map { |u|
      { id: u.id, full_name: u.full_name, email: u.email, role: u.role }
    }
  end

  def show
    user = User.find_by(id: params[:id])
    return render_not_found("User") unless user

    render json: {
      id:         user.id,
      first_name: user.first_name,
      last_name:  user.last_name,
      full_name:  user.full_name,
      email:      user.email,
      role:       user.role
    }
  end
end
