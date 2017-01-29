
require_relative("../db/sql_runner")
require_relative('customer')
require_relative('ticket')

class Film

  attr_accessor :id, :title, :price, :empty_seats

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
    @empty_seats = options['empty_seats'].to_i
  end


  def save()
    sql = "INSERT INTO films (title, price, empty_seats) VALUES ('#{ @title }', #{ @price }, #{@empty_seats}) RETURNING id"
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * films"
    films = Film.get_many(sql)
    return customers
  end

  def self.delete_all() 
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET (title, price, empty_seats) = ('#{@title}', #{@price}, #{@empty_seats }) WHERE id = #{@id};"
    result = SqlRunner.run(sql)
  end

  def self.get_many(sql)
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new( film ) }
  end

  def customers()
    sql = "SELECT c.* FROM customers c
            INNER JOIN tickets t
            ON c.id = t.customer_id
            WHERE t.film_id = #{ @id };"
    customers = Customer.get_many(sql)
    return customers
  end



  def most_popular_time()
    eight_bells = 0
    nine_bells = 0
    
    sql = "SELECT * FROM tickets WHERE film_id = #{@id}"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }

    for ticket in result
      if ticket.time == 8
        eight_bells += 1
      else
        nine_bells +=1
      end
    end

    if eight_bells > nine_bells
      return "8 o'clock, with #{eight_bells} sold"
    else
      return "9 o clock, with #{nine_bells} sold"
    end
  end

  def sell_ticket()
    @empty_seats -= 1
    update()
  end


  




end
