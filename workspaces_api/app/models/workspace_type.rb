class WorkspaceType < ApplicationRecord
  belongs_to :workspace
  belongs_to :type

  def self.create_new_room(type_id, workspace_id, name, number_people)
    name.each_with_index do |room, index|
      WorkspaceType.create(type_id: type_id, workspace_id: workspace_id, name: room, number_of_people: number_people[index].to_i)
    end
  end

  def self.create_workspace_type(room_list, number_people_list, workspace_id)
    create_new_room(1, workspace_id, room_list[:privateRoom], number_people_list[:privateRoom])
    create_new_room(2, workspace_id, room_list[:meetingRoom], number_people_list[:meetingRoom])
    create_new_room(3, workspace_id, room_list[:commonRoom], number_people_list[:commonRoom])
    create_new_room(4, workspace_id, room_list[:openRoom], number_people_list[:openRoom])
  end
end
