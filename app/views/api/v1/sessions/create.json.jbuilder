json.user do
  json.email @user.email
  json.id @user.id.to_s
  json.username @user.username
  json.mobile_number @user.mobile_number
end
  json.auth_token @token.auth_token
  json.msg "You have Successfully registered with our Application."
  json.success "true"