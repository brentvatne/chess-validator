module Chess
  def self.legal_move?(board, origin, destination)
    Validator.legal?(board, origin, destination)
  end

  module Rules

  end

  Validator = Object.new

  class << Validator
    include Rules

    def legal?(*args)
      true
    end
  end


end
