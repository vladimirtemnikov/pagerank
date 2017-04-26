module Services
  class BaseService
    def self.call
      $timer.start

      links_cacher = LinksCacher.new
      matrix = eval("#{self::MATRIX_CLASS.split('_').map(&:capitalize).join('')}Matrix").new(links_cacher)
      matrix.fill
      $logger.send("log_#{self::MATRIX_CLASS}_matrix", eval(self::PARAM_TO_SEND))

      pagerank_calculator = PageRankCalculator.new(eval(self::PARAM_TO_SEND))
      $logger.log_pagerank(pagerank_calculator.pageranks, self::MATRIX_CLASS)

      $timer.stop && $timer.time_spent
    end
  end
end
