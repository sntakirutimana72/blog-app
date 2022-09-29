class Ability
  include CanCan::Ability

  def initialize(user)
    # Allowed in public view
    #
    can(:read, Comment, public: true)
    can(:read, Like, public: true)
    can(:read, Post, public: true)

    # Accessible to all logged in users
    #
    return unless user.present?

    can(:manage, Like, user:)
    can(:manage, Comment, user:)
    can(:manage, Post, user:)

    # Only accessible to admin users
    #
    return unless user.admin?

    can :manage, :all
  end
end
