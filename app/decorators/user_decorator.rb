class UserDecorator < ApplicationDecorator
  delegate_all
  decorates_association :teams

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def team_links
    object.teams.map do |team|
      h.link_to team.name, h.edit_team_path(team), class: object_link_css
    end.join(", ").html_safe
  end
end
