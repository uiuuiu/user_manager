class UserDecorator < ApplicationDecorator
  delegate_all
  decorates_association :teams

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def roles_tags
    h.content_tag :ul, class: "tags" do
      object.current_team_roles.map do |role|
        h.content_tag :li, role.name, class: "tag"
      end.join(" ").html_safe
    end
  end

  def team_links
    object.belongs_current_user_teams.map do |team|
      h.link_to team.name, h.edit_team_path(team), class: object_link_css
    end.join(", ").html_safe
  end
end
