module Backend
  module CommentsHelper
    def comment_states
      Comment::STATES.reject { |state| state == 'all' }.map { |state| [t("comment.states.#{state}"), state] }
    end
  end
end

