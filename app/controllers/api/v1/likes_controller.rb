class Api::V1::LikesController < ApplicationController
  def index
    render json: {
      status: 200,
      active_likes: current_api_v1_user.active_likes,
      passive_likes: current_api_v1_user.passive_likes
    }
  end

  def create
    is_matched = false
    active_like = Like.find_or_initialize_by(like_params)
    passive_like = passive_like(active_like)

    if passive_like
      create_chat_room
      is_matched = true
    end

    data = render_data(active_like, is_matched)
    render json: data
  end

  private

  def like_params
    params.permit(:from_user_id, :to_user_id)
  end
end
