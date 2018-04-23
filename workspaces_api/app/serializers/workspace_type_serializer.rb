class WorkspaceTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :number_of_people, :price_hour, :price_day, :price_week, :price_month, :price_year, :unit, :workspace_id, :type_id, :type
  belongs_to :workspace
  belongs_to :type
  has_many :orders

end
