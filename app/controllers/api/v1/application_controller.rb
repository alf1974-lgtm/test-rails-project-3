module Api
  module V1
    class ApplicationController < ActionController::API
      private

      def render_not_found(resource = "Resource")
        render json: { error: "#{resource} not found" }, status: :not_found
      end

      def render_error(message, status = :unprocessable_entity)
        render json: { error: message }, status: status
      end
    end
  end
end
