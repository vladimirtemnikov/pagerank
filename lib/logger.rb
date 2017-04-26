class Logger
  def log_links_or_abort
    if $parser.main_page_links.count > 0
      puts "Найдено подходящих ссылок: #{$parser.main_page_links.size}"
      File.open('./out/links.txt', 'w') { |f| $parser.main_page_links.each { |e| f.puts e } }
    else
      abort "Подходящих ссылок не найдено."
    end
  end

  def log_simple_matrix(matrix)
    File.open('./out/simple_matrix.txt', 'w') do |f|
      matrix.to_a.each do |row|
        f.puts row.join(' ')
      end
    end
  end

  def log_sparse_matrix(sparse_matrix)
    File.open('./out/sparse_matrix.txt', 'w') do |f|
      f.puts "Rows: #{sparse_matrix.rows.inspect}"
      f.puts "Pointers: #{sparse_matrix.pointers.inspect}"
    end
  end

  def log_multithread_sparse_matrix(sparse_matrix)
    File.open('./out/multithread_sparse_matrix.txt', 'w') do |f|
      f.puts "Rows: #{sparse_matrix.rows.inspect}"
      f.puts "Pointers: #{sparse_matrix.pointers.inspect}"
    end
  end

  def log_pagerank(pageranks, type)
    puts "Идет процесс высчитывания PageRank..."

    links = {}.tap do |hash|
      $parser.main_page_links.each_with_index do |link, index|
        hash[link] = pageranks[index]
      end
    end

    puts 'Готово!'

    File.open("./out/#{type}_pagerank.txt", 'w') do |f|
      links.sort_by { |_k, v| v }.reverse.each do |link, pagerank|
        f.puts "#{sprintf("%0.06f", pagerank)} || #{link}"
      end
    end
  end
end
