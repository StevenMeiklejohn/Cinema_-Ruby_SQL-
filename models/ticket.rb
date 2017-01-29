
require_relative("../db/sql_runner")
require_relative('customer')
require_relative('film')

class Ticket

  attr_accessor :id, :customer_id, :film_id, :time

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @time = options['time'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, time) VALUES (#{ @customer_id }, #{ @film_id }, #{@time}) RETURNING id"
    ticket = SqlRunner.run( sql ).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = Ticket.get_many(sql)
    return tickets
  end

  def self.delete_all() 
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id, time) = (#{@customer_id}, #{@film_id}, #{@time}) WHERE id = #{@id};"
    result = SqlRunner.run(sql)
  end

  def self.get_many(sql)
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
  end




  




end
