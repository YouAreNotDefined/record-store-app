module Api
  module V1
    class ArtistsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_artist, only: [:show, :update, :destroy]

      # GET /artists
      def index
        @artists = current_user.artists.all
      end

      # GET /artists/1
      def show
      end

      # POST /artists
      def create
        @artist = current_user.artists.build(artist_params)

        if @artist.save
          render status: :created
        else
          render status: :unprocessable_entity
        end
      end

      # PATCH/PUT /artists/1
      def update
        if @artist.update(artist_params)
        else
          render status: :unprocessable_entity
        end
      end

      # DELETE /artists/1
      def destroy
        @artist.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_artist
          @artist = current_user.artists.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def artist_params
          params.require(:artist).permit(:name)
        end
    end
  end
end
