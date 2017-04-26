class SimpleMatrix
  WORDS = 'Процесс заполнения матрицы...'.freeze

  attr_reader :matrix

  def initialize(cacher)
    @cacher = cacher
    @matrix = Matrix.zero($parser.main_page_links.count)
    @main_index = 0
    @total = $parser.main_page_links.size ** 2
  end

  def fill
    $parser.main_page_links.each_with_index do |parent_link, index_row|
      $parser.main_page_links.each_with_index do |child_link, index_column|
        @cacher.cached_links[child_link] ||= $parser.general_page_links(child_link)
        matrix.send(:[]=, index_row, index_column, state_of_rebro(parent_link, child_link))
        @main_index += 1
        percents = ((@main_index.to_f / @total) * 100).round
        print "#{WORDS}#{percents}%\r"
      end
    end
    puts "\nГотово!"
  end

  private

  def state_of_rebro(parent_link, child_link)
    keep?(parent_link, child_link) ? 1 : 0
  end

  def keep?(parent_link, child_link)
    parent_link == child_link || @cacher.cached_links[child_link].include?(parent_link)
  end
end
