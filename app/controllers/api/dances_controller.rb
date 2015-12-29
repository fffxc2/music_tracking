module Api
  class DancesController < ApplicationController
    def index
      @dances = Dance.all
      if params['term']
        @dances = @dances.named(params['term'])
      end
      @dances = @dances.map(&:name) if params['only_name']
      respond_to do |format|
        format.json { render json: @dances, status: :ok }
      end
    end
  end
end
