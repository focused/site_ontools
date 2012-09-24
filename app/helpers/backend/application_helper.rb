module Backend
  module ApplicationHelper
    def state_class(state = nil)
      return '' if state.blank? && state != false

      classes = { 'true' => 'success', 'false' => 'important', pending: 'info', approved: 'success', spam: 'warning' }
      state = state.send(!!state == state ? :to_s : :to_sym)
      classes[state] ? "label-#{classes[state]}" : ''
    end
  end
end
