# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     System2.Repo.insert!(%System2.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias System2.Repo
alias System2.HR.Department
alias System2.HR.User

# Create departments
hr_department = Repo.insert!(%Department{name: "HR"})
it_department = Repo.insert!(%Department{name: "IT"})

# Create users
Repo.insert!(%User{
  first_name: "John",
  last_name: "Joseph",
  email: "john.doe@example.com",
  password: "password123", # In a real app, hash this password
  department_id: hr_department.id,
  department: "HR"
})

Repo.insert!(%User{
  first_name: "Jane",
  last_name: "Smith",
  email: "jane.smith@example.com",
  password: "password123", # In a real app, hash this password
  department_id: it_department.id,
  department: "IT"
})
