class UsersController < ApplicationController

    def add_friend
        begin
            current_user.add_friend(friend_params[:friend_id])
            render :json => {message:"Friend has been added successfully"}, status: :ok
        rescue StandardError => e
            render json: {errors: [e.message]}, status: :unprocessable_entity
        end
    end

    def remove_friend
        current_user.remove_friend(friend_params[:friend_id])
        render :json => {message:"Friend has been removed successfully"}, status: :ok
    end

    def active_friends
        render json: current_user.active_friends, status: :ok
    end

    def pending_friends
        render json: current_user.pending_friends, status: :ok
    end

    def received_friends
        render json: current_user.received_friends, status: :ok
    end

    private

    def friend_params
        params.permit(:friend_id)
    end

end
