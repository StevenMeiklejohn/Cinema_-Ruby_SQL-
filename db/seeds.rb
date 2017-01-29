require('pry-byebug')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

film1 = Film.new({'title' => 'Jaws', 'price' => 8, 'empty_seats' => 2})
film2 = Film.new({'title' => 'Robocop','price' => 8, 'empty_seats' => 2})
film3 = Film.new({'title' =>'Alien', 'price' => 10, 'empty_seats' => 2})
film4 = Film.new({'title' =>'Blade Runner', 'price' => 11, 'empty_seats' => 2})
film5 = Film.new({'title' =>'Conan The Barbarian', 'price' => 9, 'empty_seats' => 2})

film1.save
film2.save
film3.save
film4.save
film5.save

customer1 = Customer.new({'name' => 'Bobby Blanco', 'funds' => 100})
customer2 = Customer.new({'name' => 'Sergio Leone', 'funds' => 1})
customer3 = Customer.new({'name' => 'Francis Bacon', 'funds' => 200})
customer4 = Customer.new({'name' => 'Piers - the bastard - Morgan', 'funds' =>  50})
customer5 = Customer.new({'name' => 'Ming The Merciless', 'funds' =>  90})

customer1.save
customer2.save
customer3.save
customer4.save
customer5.save



ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id, 'time' => 9})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id, 'time' => 8})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id, 'time' => 9})
ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film4.id, 'time' => 6})
ticket5 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film5.id, 'time' => 9})




ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save

binding.pry


customer3.buy_ticket(film2, 9)
customer3.update

customer4.buy_ticket(film2, 9)
customer4.update

customer5.buy_ticket(film2, 9)
customer5.update

# film1.customers
# film2.customers



# binding.pry

# nil





