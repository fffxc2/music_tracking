module Api
  class ArtistsController < ApplicationController
    def index
      @artists = Artist.all
      if params['term']
        @artists = @artists.named(params['term'])
      end
      @artists = @artists.map(&:name) if params['only_name']
      respond_to do |format|
        format.json { render json: @artists, status: :ok }
      end
    end
  end
end
