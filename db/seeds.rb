# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Category.destroy_all
Goal.destroy_all
Habit.destroy_all
Comment.destroy_all

u1 = User.create(name: 'Lauren', username: 'lbirts', email: 'laurentest@aol.com', password: 'iLovepuppies12', image_url: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12231413/Labrador-Retriever-MP.jpg" )
u2 = User.create(name: 'Karim', username: 'karim12', email: 'karimtest@aol.com', password: 'iLovecats21', image_url: "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500" )

c1 = Category.create(title: "Education")
c2 = Category.create(title: "Technology")

g1 = Goal.create(title: 'Read 10 books', category_id: c1.id, description: "I want to read at least 10 books by the end of the year", due_date: "06/01/2021", cheers: 0, user_id: u2.id, complete: false)
g2 = Goal.create(title: '100 day coding challenge', category_id: c2.id, description: "I want to code everyday for 100 days", due_date: "12/01/2020", cheers: 0, user_id: u1.id, complete: false)

h1 = Habit.create(name: "Read a book", description: "Finish chapters 1-5 of To Kill a Mockingbird", goal_id: g1.id, complete: false)
h2 = Habit.create(name: "Read a book", description: "Finish chapters 5-6 of To Kill a Mockingbird", goal_id: g1.id, complete: false)
h3 = Habit.create(name: "Code Challenge 1", description: "Create a working calculator in ruby", goal_id: g2.id, complete: false)
h4 = Habit.create(name: "Code Challenge 2", description: "Create a tic tac toe game in ruby", goal_id: g2.id, complete: false)

com1 = Comment.create(content: "OMG you're killing it!!", goal_id: g1.id, user_id: u1.id)
com2 = Comment.create(content: "I love that you are doing this!", goal_id: g2.id, user_id: u2.id)