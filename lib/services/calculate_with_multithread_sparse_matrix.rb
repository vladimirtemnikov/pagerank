require_relative 'calculate_with_sparse_matrix'

module Services
  class CalculateWithMultithreadSparseMatrix < CalculateWithSparseMatrix
    MATRIX_CLASS = 'multithread_sparse'.freeze
  end
end
