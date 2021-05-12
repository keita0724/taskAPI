# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
c1 = Category.create(name: 'c1')
c2 = Category.create(name: 'c2')

Idea.create(category: c1, body: 'idea1')
Idea.create(category: c2, body: 'idea2')
