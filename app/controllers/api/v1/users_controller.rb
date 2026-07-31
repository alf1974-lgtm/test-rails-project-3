module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all.order(:last_name, :first_name)
        render json: users.map { |u| user_json(u) }
      end

      def show
        user = User.find(params[:id])
        render json: user_json(user)
      end

      private

      def user_json(user)
        {
          id:         user.id,
          first_name: user.first_name,
          last_name:  user.last_name,
          full_name:  user.full_name,
          email:      user.email,
          role:       user.role
        }
      end
    end
  end
end
