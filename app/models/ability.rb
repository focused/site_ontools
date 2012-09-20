class Ability
  include CanCan::Ability

  def initialize(user)
    can [:show], Page, visible: true

    return unless user

    if user.is? :admin
      can :manage, :all
    elsif user.is? :editor
      can :index, :app_page
      can :manage, Page
      can :manage, PageMetaTag
      can :manage, :file_manager
    end
  end
end
