json.user do
  json.username @user.username
  json.email @user.email
  json.role @user.role.name
end
