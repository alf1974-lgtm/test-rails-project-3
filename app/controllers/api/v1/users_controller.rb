module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]

      # GET /api/v1/users
      def index
        users = User.all.order(:last_name, :first_name)
        render json: users
      end

      # GET /api/v1/users/:id
      def show
        render json: @user
      end

      # POST /api/v1/users
      def create
        user = User.create!(user_params)
        render json: user, status: :created
      end

      # PATCH /api/v1/users/:id
      def update
        @user.update!(user_params)
        render json: @user
      end

      # DELETE /api/v1/users/:id
      def destroy
        @user.destroy!
        head :no_content
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :role)
      end
    end
  end
end
