class WorkspaceType < ApplicationRecord
  belongs_to :workspace
  belongs_to :type

  def self.create_new_room(type_id, workspace_id, name, number_people, price_hour, price_day, price_week, price_month, price_year)
    name.each_with_index do |room, index|
      WorkspaceType.create(type_id: type_id, workspace_id: workspace_id, name: room, number_of_people: number_people[index].to_i, price_hour: price_hour[index].to_i, price_day: price_day[index].to_i, price_week: price_week[index].to_i, price_month: price_month[index].to_i, price_year: price_year[index].to_i)
    end
  end

  def self.create_workspace_type(room_list, number_people_list, price, workspace_id)
    binding.pry
    create_new_room(1, workspace_id, room_list[:privateRoom], number_people_list[:privateRoom],0,0,price[:priceWeek][:privateRoom], price[:priceMonth][:privateRoom], price[:priceYear][:privateRoom])
    create_new_room(2, workspace_id, room_list[:meetingRoom], number_people_list[:meetingRoom], price[:priceHour][:meetingRoom], price[:priceDay][:meetingRoom],0,0,0)
    create_new_room(3, workspace_id, room_list[:openRoom], number_people_list[:openRoom], price[:priceHour][:openRoom], price[:priceDay][:openRoom],0,0,0)
  end
end
