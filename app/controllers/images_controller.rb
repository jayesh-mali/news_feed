class ImagesController < ApplicationController
    before_action :set_image, only: [:show,:destroy]

    def index
        @images = Image.where(created_by_id:current_user.id)
        render json: @images, status: :ok
    end
    
    def create
        authorize Image
        @image = Image.create_image(create_params,current_user.id)
        if @image.errors.blank?
            render json: @image, status: :created
        else
            render json: {errors:@image.errors.messages}, status: :unprocessable_entity
        end
    end

    def show
        if @image.present?
            authorize @image
            render json: @image, status: :ok
        else
            render json: {message:"Unable to find image."}, status: :unprocessable_entity
        end
    end

    def destroy
        if @image.present?
            authorize @image
            @image.destroy
            render json: {message:"Image destroyed successfully"}, status: :ok
        else
            render json: {message:"Unable to find image."}, status: :unprocessable_entity
        end
        
    end

    private

    def set_image
        @image = Image.find_by_id(params[:id])
    end

    def create_params
        params.permit(:title,:image_post)
    end
end
