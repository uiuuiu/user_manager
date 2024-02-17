class RoleResource
  attr_accessor :resource

  ACTIONS = {
    read: 1,
    write: 2,
    delete: 3
  }

  def initialize(resource)
    @resource = resource

    raise Pundit::NotDefinedError, "Resource not found" unless self.class.resource_exists? resource
  end

  def self.all
    @resources ||= YAML.load_file "config/resources.yml"
  end

  def self.resource_exists? resource
    all.map { |res| res["name"] }.include? resource
  end

  def read? role
    role.permissions[resource]&.include? ACTIONS[:read].to_s
  end

  def write? role
    role.permissions[resource]&.include? ACTIONS[:write].to_s
  end

  def delete? role
    role.permissions[resource]&.include? ACTIONS[:delete].to_s
  end
end
