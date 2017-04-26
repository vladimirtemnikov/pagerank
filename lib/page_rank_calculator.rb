class PageRankCalculator
  KOEFF = 0.85.freeze
  EPS = 0.0001.freeze

  attr_reader :matrix, :pages_rank, :sum_link
  attr_accessor :pages_rank_old

  def initialize(matrix)
    @matrix = matrix
    @pages_rank = []
    @pages_rank_old = []
    @sum_link = vectors_sums
  end

  def pageranks
    for i in 0...matrix.row_count do
      pages_rank_old[i] = 1
    end

    begin
      eps = 0

      for j in 0...matrix.row_count do
        sum = 0
        pages_rank[j] = (1 - KOEFF)

        for i in 0...matrix.row_count do
          if matrix[j, i] > 0
            sum += pages_rank_old[i].to_f / sum_link[i]
          else
            sum += 0
          end
        end

        sum = KOEFF * sum
        pages_rank[j] += sum
      end

      for i in 0...pages_rank.size do
        eps += (pages_rank[i] - pages_rank_old[i]) * (pages_rank[i] - pages_rank_old[i])
      end

      self.pages_rank_old = pages_rank
    end while eps > EPS

    pages_rank
  end

  private

  def vectors_sums
    matrix.column_vectors.map { |column| column.to_a.reduce(0, :+) }
  end
end
