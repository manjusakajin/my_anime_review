module UsersHelper
  def gravatar_for user, options = {size: 80}
    size = options[:size]
    gravatar_url =
      "https://secure.gravatar.com/avatar/#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
