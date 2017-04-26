class Timer
  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def time_spent
    spent = (@stop_time - @start_time).to_i

    puts "Времени затрачено: #{spent} секунд"
  end
end
