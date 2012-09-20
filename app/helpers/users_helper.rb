module UsersHelper
  def roles_list(user)
    return '-' unless user.roles.any?

    user.roles.map { |r| t.users.roles.send(r) } * ', '
  end
end

