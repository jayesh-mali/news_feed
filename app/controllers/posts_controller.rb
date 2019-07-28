class PostsController < ApplicationController
    before_action :set_post, only: [:show,:destroy]

    def index
        @posts = Post.where(created_by_id:current_user.id)
        render json: @posts, status: :ok
    end
    
    def create
        @post = Post.create_post(create_params,current_user.id)
        if @post.errors.blank?
            render json: @post, status: :created
        else
            render json: {errors:@post.errors.messages}, status: :unprocessable_entity
        end
    end

    def show
        if @post.present?
            authorize @post
            render json: @post, status: :ok
        else
            render json: {message:"Unable to find post."}, status: :unprocessable_entity
        end
    end

    def destroy
        if @post.present?
            authorize @post
            @post.destroy
            render json: {message:"Post destroyed successfully"}, status: :ok
        else
            render json: {message:"Unable to find post."}, status: :unprocessable_entity
        end
        
    end

    private

    def set_post
        @post = Post.find_by_id(params[:id])
    end

    def create_params
        params.require(:post).permit(:title,:description)
    end
end
