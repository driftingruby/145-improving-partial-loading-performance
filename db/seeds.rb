10.times do 
  User.create(name: Faker::Name.name)
end

movie = Movie.create({ name: 'Dumb and Dumber' })
20.times do
  movie.quotes.create(content: Faker::DumbAndDumber.quote, user: User.all.sample)
end

movie = Movie.create({ name: 'Princess Bride' })
20.times do
  movie.quotes.create(content: Faker::PrincessBride.quote, user: User.all.sample)
end