module UsersHelper

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/#(gravatar_id)"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def init_member(user)
    current_user.members.build(user_id: user.id)
  end
end
