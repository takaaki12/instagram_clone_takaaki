module GuestSessionsHelper
  def guest_user
      current_user == User.find_by(email: 'guest@example.com')
  end
  
  def guest_user?(user)
    user && user == guest_user
  end
end
