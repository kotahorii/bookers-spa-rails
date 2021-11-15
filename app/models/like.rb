class Like < ApplicationRecord
  belongs_to :to_user, class_name: 'User', foreign_key: :to_user_id
  belongs_to :from_user, class_name: 'User', foreign_key: :from_user_id

  def create_chat_room
    chat_room = ChatRoom.create
    ChatRoomUser.find_or_create_by(
      chat_room_id: chat_room.id,
      user_id: active_like.from_user_id
    )
    ChatRoomUser.find_or_create_by(
      chat_room_id: chat_room.id,
      user_id: passive_like.from_user_id
    )
  end

  def passive_like(active_like)
    Like.find_by(
      room_user_id: active_like.to_user_id,
      to_user_id: active_like.from_user_id
    )
  end

  def render_data(active_like, is_matched)
    if active_like.save
      { status: 200, like: active_like, is_matched: is_matched }
    else
      { status: 500, message: '作成に失敗しました。' }
    end
  end
end
