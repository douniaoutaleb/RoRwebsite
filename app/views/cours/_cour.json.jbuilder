json.extract! cour, :id, :nom, :institution, :theme, :langue, :professeur, :description, :created_at, :updated_at
json.url cour_url(cour, format: :json)
