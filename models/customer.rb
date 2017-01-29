require('pry-byebug')
require_relative("../db/sql_runner")
require_relative('film')
require_relative('ticket')

class Customer

  attr_accessor :id, :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{ @name }', #{ @funds }) RETURNING id"
    customer = SqlRunner.run( sql ).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = Customer.get_many(sql)
    return customers
  end

  def self.delete_all() 
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id};"
    result = SqlRunner.run(sql)
  end

  def buy_ticket(film, time)
    price = film.price
    return unless film.empty_seats > 0
    return unless customer_can_afford_film?(price)
    Ticket.new('customer_id' => @id, 'film_id' => film.id, 'time' => time).save
    @funds -= price
    film.sell_ticket()
    update()
  end


  def customer_can_afford_film?(price)
    return price <= @funds
  end


  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new( customer ) }
  end

  def films()
    sql = "SELECT f.* FROM films f
            INNER JOIN tickets t
            ON f.id = t.film_id
            WHERE t.customer_id = #{ @id };"
    films = Film.get_many(sql)
    return films
  end

  def tickets()
    sql = "SELECT from tickets WHERE tickets.customer_id = #{@id}"
    tickets = Ticket.get_many(sql)
    return tickets.length
  end











end
