module RolesHelper
  def permission_checkbox_tag(role, resource_name, action_value)
    checked = role.permissions[resource_name]&.include?(action_value.to_s)
    check_box_tag "role[permissions][#{resource_name}][]", action_value, checked, class: permission_checkbox_css, id: "#{resource_name}_#{action_value}",
      data: {target: "role.checkbox", action: "input->role#toggle"}
  end

  private

  def permission_checkbox_css
    %w[
      w-4
      h-4
      text-blue-600
      bg-gray-100
      border-gray-300
      rounded
      focus:ring-blue-500
      dark:focus:ring-blue-600
      dark:ring-offset-gray-800
      focus:ring-2
      dark:bg-gray-700
      dark:border-gray-600
    ].join(" ")
  end
end
