class RoleResource
  ACTIONS = {
    read: 1,
    write: 2,
    delete: 3
  }

  def self.all
    YAML.load_file "config/resources.yml"
  end
end
