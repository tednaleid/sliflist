class Probability

  def self.factorial(n)
    return 1 if n == 0
    (1..n).inject(:*)
  end
      
  def self.combinations(n, r)
    return factorial(n).to_f / (factorial(r) * factorial(n-r))
  end

end