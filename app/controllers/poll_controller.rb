class PollController < ApplicationController
  before_filter :authenticate_user

  def poll
    name = params[:name]
    if name
      p = Poll.find_or_create_by_user_id_and_name(@user.id, name)
      p.answer = params[:answer] == 'true'
      p.save()
      render json: {}
    else
      render json: {}, status: :bad_request
    end
  end
end
