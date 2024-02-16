require "rails_helper"

RSpec.describe RoleResource do
  describe ".all" do
    it "returns all resources" do
      expect(described_class.all).to eq(YAML.load_file("config/resources.yml"))
    end
  end

  describe "Constants" do
    it "has a constant for all actions" do
      expect(described_class::ACTIONS).to eq({read: 1, write: 2, delete: 3})
    end

    it "not contains a constant for all actions" do
      expect(described_class::ACTIONS).not_to eq({read: 1, write: 2, delete: 4})
    end
  end
end
