class RoleDecorator < ApplicationDecorator
  delegate_all

  def role_type
    object.team_id.present? ? "Custom" : "Default"
  end
end
