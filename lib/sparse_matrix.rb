class SparseMatrix
  WORDS = 'Процесс заполнения разреженной матрицы...'.freeze

  attr_reader :rows, :pointers

  def initialize(cacher)
    @cacher = cacher
    @rows = []
    @pointers = [1]
    @main_index = 0
    @total = $parser.main_page_links.size ** 2
  end

  def fill
    $parser.main_page_links.each do |child_link|
      last_point = pointers.last
      $parser.main_page_links.each_with_index do |parent_link, index_row|
        @cacher.cached_links[child_link] ||= $parser.general_page_links(child_link)

        if keep?(parent_link, child_link)
          rows.push(index_row)
          last_point += 1
        end

        @main_index += 1
        percents = ((@main_index.to_f / @total) * 100).round
        print "#{WORDS}#{percents}%\r"
      end

      pointers.push(last_point)
    end
    puts "\nГотово!"
  end

  def [](i, j)
    val, n1, n2 = 0, pointers[j], pointers[j+1]
    for k in n1-1...n2-1 do
      if rows[k] == i
        val = 1
        break
      end
    end

    val
  end

  def row_count
    @pointers.size - 1
  end

  def column_vectors
    [].tap do |ar|
      (@pointers.size - 1).times do |index|
        ar.push([@pointers[index + 1] - @pointers[index]])
      end
    end
  end

  private

  def keep?(parent_link, child_link)
    parent_link == child_link || @cacher.cached_links[child_link].include?(parent_link)
  end
end
