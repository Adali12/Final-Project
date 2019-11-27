json.extract! user, :id, :firstName, :lastName, :email, :address, :bio, :occupation, :expertise, :admin, :mentor, :created_at, :updated_at
json.url user_url(user, format: :json)
