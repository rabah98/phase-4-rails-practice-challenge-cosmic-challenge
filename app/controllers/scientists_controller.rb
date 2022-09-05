class ScientistsController < ApplicationController

    def index 
        render json: Scientist.all, include: ['missions.planets'], status: :ok
    end 
    def show
        scientist = Scientist.find_by(id: params[:id])
        if scientist 
            render json: scientist, status: :ok
        else 
            render json: { error: "Scientist not found" }, status: :not_found 
        end
    end

    def create 
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end
    def update 
        scientist = Scientist.find_by(id: params[:id])
        if scientist
            scientist.update!(scientist_params)
            render json: scientist, status: :accepted
        else
            render json: {error: "Scientist not found"}, status: :not_found
        end
    end

    def destroy 
        scientist = Scientist.find_by(id: params[:id])
        if scientist 
            scientist.missions.destroy_all
            scientist.destroy
            head :no_content
        else 
            render json: {error: "Scientist not found"}, status: :not_found
        end
    end

    private 
    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

end
