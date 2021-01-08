module Api
  class LocationsController < ApplicationController
    
    before_action :set_location, only: [:show, :update, :destroy]
    
    def index
      @locations = Location.limit(5)
  
      render json: @locations
    end
  
    def show
      render json: @location
    end

    def search
      @location = Location.where(city: /.*#{params[:keyword]}.*/i )
      
      render json: @location
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_location
        @location = Location.find(params[:id])
        rescue Mongoid::Errors::DocumentNotFound => e
          render json: { errors: 'location not found' }, status: :not_found
      end

  end
end