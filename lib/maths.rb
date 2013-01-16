def mean(num)
  return num.inject(0){|accum, i| accum + i }/ num.length.to_f
end

def sample_var(num)
  m = mean(num)
  s = num.inject(0){|accum, i| accum + (i - m) ** 2 }
  return s / (num.length - 1).to_f
end

def standard_dev(num)
  return Math.sqrt(sample_var(num))
end