class InputManager
  def main_link
    @_main_link ||= begin
      print "Введите ссылку (#{config['default_link']}): "
      entered_link = gets.chomp
      entered_link.empty? ? config['default_link'] : entered_link
    end
  end

  def links_count
    @_links_count ||= begin
      print "Максимальное число ссылок (#{config['default_count']}): "
      count = gets.chomp.to_i
      count.zero? ? config['default_count'] : count
    end
  end

  def threads_count
    @threads_count ||= begin
      print "Число потоков (#{config['default_threads_count']}): "
      count = gets.chomp.to_i
      count.zero? ? config['default_threads_count'] : count
    end
  end

  private

  def config
    @_config ||= YAML.load_file('./config.yml')
  end
end
