module ApplicationHelper
  def full_title title
    title_default = t "name"
    title.empty? ? title_default : "#{title_default}||#{title}"
  end
end
