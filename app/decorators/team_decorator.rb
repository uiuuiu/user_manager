class TeamDecorator < ApplicationDecorator
  delegate_all
  decorates_association :users

  def user_links
    users.map do |user|
      h.link_to user.full_name, h.edit_user_path(user), class: object_link_css
    end.join(", ").html_safe
  end

  def current_user_admin?
    admins.include?(h.current_user)
  end
end
