module DashboardHelper
  def authorize_link_to(action_name, resource, permission, path, **options)
    return unless policy(resource).send(permission)
    link_to action_name, path, options
  end
end
