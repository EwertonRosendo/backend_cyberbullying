json.array! @cases do |this_case|
  json.extract! this_case, :id, :user_id, :description, :institution_answer, :created_at, :updated_at
  json.images this_case.images.map { |img| url_for(img) }
end