class Ability
  include CanCan::Ability

  def initialize(user)
    # Allowed in public view
    #
    can(:read, Comment)
    can(:read, Like)
    can(:read, Post)

    # Accessible to all logged in users
    #
    return unless user.present?

    can(:create, Like)
    can(%i[create destroy], Comment, author: user)
    can(:create, Post)
    can(:destroy, Post, author: user)

    # Only accessible to admin users
    #
    return unless user.admin?

    can :manage, :all
  end
end
