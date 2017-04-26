require_relative 'sparse_matrix'

class MultithreadSparseMatrix < SparseMatrix
  def fill
    Parallel.map($parser.main_page_links, in_threads: $inputs.threads_count, progress: "Загрузка страниц") do |child_link|
      @cacher.cached_links[child_link] = $parser.general_page_links(child_link)
    end

    super
  end
end
