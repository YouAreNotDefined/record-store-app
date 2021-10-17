module Api
  module V1
    class LibrariesController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_library, except: [:index, :create]

      def index
        @libraries = current_user.libraries.all
      end

      def show
        @records = @library.record_libraries
      end

      def create
        @library = current_user.libraries.build(library_params)

        if @library.save
          render status: :created
        else
          render status: :unprocessable_entity
        end
      end

      def update
        if @library.update(library_params)

        else
          render status: :unprocessable_entity
        end
      end

      def destroy
        @library.destroy
      end

      private

      def set_library
        @library = current_user.libraries.find(params[:id])
      end

      def library_params
        params.require(:library).permit(:name, :content)
      end
    end
  end
end
