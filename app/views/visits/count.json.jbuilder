json.visit do |json|
    json.item @visit.attributes
    json.total Visit.sum(:count)
end