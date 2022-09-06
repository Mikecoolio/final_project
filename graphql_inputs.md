# Tester:
{
  test
}


# Create User: (stops working once api authentication is fully implemented, query create user in Insomnia to see result)
mutation {
  registerUser(input:{
    email: "mikecoolio@gmail.com", 
    password: "123"
  , username: "mikecoolio"})
}

# Get all users
{
  users{
    email
    password
    username
    insertedAt
    id
  }
}