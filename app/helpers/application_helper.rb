module ApplicationHelper
  # full path for custom pages like "/about"
  def page_full_path(path)
    (root_path == "/" ? "" : root_path) + path
  end
end

