module Api
  module V1
    class LibrariesController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_library, except: [:index, :create]

      def index
        @libraries = current_user.libraries.all
      end

      def show
        @records = @library.records
      end

      def create
        records = current_user.records.find(library_params[:record_ids])
        @library = current_user.libraries.build({name: library_params[:name], content: library_params[:content]})

        if @library.save
          records.each do |record|
            current_user.record_libraries.create({
              user_id: current_user.id,
              record_id: record.id,
              library_id: @library.id,
            })
          end

          render status: :created
        else
          render status: :unprocessable_entity
        end
      end

      def update
        records = current_user.records.find(library_params[:record_ids])
        record_libraries = current_user.record_libraries.where(user_id: current_user.id).where(library_id: @library.id)

        record_libraries.each do |record_library|
          if !library_params[:record_ids].include?(record_library.record_id)
            record_library.destroy
          end
        end

        if @library.update({name: library_params[:name], content: library_params[:content]})
          records.each do |record|
            record_library = current_user.record_libraries.find_or_initialize_by({
              user_id: current_user.id,
              record_id: record.id,
              library_id: @library.id
            })

            if record_library.new_record?
              record_library.save!
            end
          end
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
        params.require(:library).permit(:name, :content, record_ids: [])
      end
    end
  end
end
