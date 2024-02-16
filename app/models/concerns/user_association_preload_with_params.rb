module UserAssociationPreloadWithParams
  extend ActiveSupport::Concern

  included do
    class_attribute :current_user_team_ids, :current_team_id
    # Preload user associations with params
    def self.preload_teams_associations_with_team_ids(team_ids)
      self.current_user_team_ids = team_ids
      yield
    ensure
      self.current_user_team_ids = nil
    end

    def self.preload_teams_associations_with_current_team_id(team_id)
      self.current_team_id = team_id
      yield
    ensure
      self.current_team_id = nil
    end
  end
end
