# -*- encoding : utf-8 -*-
module UsersHelper

  #use Gravatar to display user image
  def gravatar_for(user, options = {size: 50})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"
    image_tag(gravatar_url, alt: user.name, class: "avatar img-rounded")
  end
end
