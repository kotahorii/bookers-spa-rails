class Api::V1::LikesController < ApplicationController
  def index
    render json: {
      status: 200,
      active_likes: current_api_v1_user.active_likes,
    }
  end

  def create
    active_like = Like.find_or_initialize_by(like_params)
    passsive_like = Like.find_by(
      from_user_id: active_like.to_user_id,
      to_user_id: active_like.from_user_id
    )

    if passsive_like
      chat_room = ChatRoom.create

      ChatRoomUser.find_or_create_by(
        chat_room_id: chat_room.id,
        user_id: active_like.from_user_id
      )

      ChatRoomUser.find_or_create_by(
        chat_room_id: chat_room.id,
        user_id: passsive_like.from_user_id
      )
    end

    if active_like.save
      render json: { status: 200, message: 'いいねを作成しました。' }
    else
      render json: { status: 500, message: "作成に失敗しました" }
    end
  end

  private

  def like_params
    params.permit(:from_user_id, :to_user_id)
  end
end
