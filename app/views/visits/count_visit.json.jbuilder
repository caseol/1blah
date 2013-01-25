json.visit do |json|
    json.item @visit.attributes
    json.total Visit.sum(:count)
    json.total_play Count.sum(:value)
end