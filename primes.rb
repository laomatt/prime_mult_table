require_relative 'time_trial'

class Integer
	# To make things a little cleaner to read, I usually add things to the Integer class to minimize 'loose' methods and extra inputs
	def is_multiple_of?(m)
		return true if self%m == 0
		false
	end

	def is_prime?
		return false if self == 0
		2.upto(self.abs-1) do |j|
			return false if self.is_multiple_of?(j)
		end
		return true
	end

	# avoiding making an instance method optimizes the time
	def is_prime_opt?
		return false if self == 0
		2.upto(self.abs-1) do |j|
			return false if self%j == 0
		end
		return true
	end
end

def find_primes(n)
	out = []
	i = 1

	while out.length < n.to_i
		out << i if i.is_prime?
		i+=1
	end
	out
end

def find_primes_optimized(n)
	out = []
	i = 1

	while out.length < n.to_i
		out << i if i.is_prime_opt?
		i+=1
	end
	out
end


def print_primes(n,test=false)
	primes = find_primes(n)

	# Offset the table cell based on the size of the largest number, to make it look nice.
	largest_num = primes.last**2
	offset = largest_num.to_s.length
	

	primes.each do |prime|
		row = gen_row(primes,prime,offset)
		p "  " + row + "  " if !test
	end
end

# I put this in its own to help me verify and test my optimized solution below
def gen_row(primes,prime,offset)
	primes.map { |e| (e*prime).to_s.ljust(offset.to_f)  }.join('  ')
end


def print_primes_optimized_1(n,test=false)
	# primes = find_primes(n)
	primes = find_primes_optimized(n)

	# Offset the table cell based on the size of the largest number, to make it look nice.
	largest_num = primes.last**2
	offset = largest_num.to_s.length
	

	primes.each do |prime|
		row = gen_row(primes,prime,offset)
		p "  " + row + "  " if !test
	end
end


 def print_primes_optimized_0(n,test=false)
     # primes = find_primes(n)
     primes = find_primes_optimized(n)
     # offset the table cell based on the size of the largest number
     # Offset the table cell based on the size of the largest number, to make t look nice.
     largest_num = primes.last**2
     offset = largest_num.to_s.length
     cache = {}

     primes.each do |prime|prime - prime%10

       if cache[prime%10] && cache[prime-prime%10]
               # the idea here was to cache processed rows so we can add them instead of reprocessing if we come across a prime number that is a sum or wo already processed primes
              prime_prod = [cache[prime%10], cache[prime-prime%10]].ranspose.map {|x| x.reduce(:+)}
       else
               prime_prod = primes.map { |e| (e*prime) }
       end

       cache[prime] = prime_prod

       # here is to keep my primes consistent
       raise 'error' if !(prime_prod.map { |e| e.to_s.ljust(offset.to_f) }.join('  ') == gen_row(primes,prime,offset)) && test
       p "  " + prime_prod.map { |e| e.to_s.ljust(offset.to_f)  }.join(' ') + "  " if !test
			 primes.each do |prime|
         row = gen_row(primes,prime,offset)
         p "  " + row + "  " if !test
      end
      # p 'df'
    end
 end


# test the is_prime method
[1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997, 1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097, 1103, 1109, 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301, 1303, 1307, 1319, 1321, 1327, 1361, 1367, 1373, 1381, 1399, 1409, 1423, 1427, 1429, 1433, 1439, 1447, 1451, 1453, 1459, 1471, 1481, 1483, 1487, 1489, 1493, 1499, 1511, 1523, 1531, 1543, 1549, 1553, 1559, 1567, 1571, 1579, 1583, 1597, 1601, 1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657, 1663, 1667, 1669, 1693, 1697, 1699, 1709, 1721, 1723, 1733, 1741, 1747, 1753, 1759, 1777, 1783, 1787, 1789, 1801, 1811, 1823, 1831, 1847, 1861, 1867, 1871, 1873, 1877, 1879, 1889, 1901, 1907, 1913, 1931, 1933, 1949, 1951, 1973, 1979].each do |pr|
	raise "Wrong answer:  #{pr} should be prime"  if !pr.is_prime?
end


[4,60,120,-4,9,20,0].each do |pr|
	raise "Wrong answer:  #{pr} should NOT be prime"  if pr.is_prime?
end

# test various list sizes
[1,2,10,20,40,50].each do |n|
	raise "List of #{n}: #{find_primes(n)} not all prime:  #{find_primes(n).select { |e| !e.is_prime? }}" if find_primes(n).any? { |e| !e.is_prime? }
end


# test my custom integer instance method
[[40,4,true],[300,30,true],[1,40,false],[9,3,true],[9,2,false]].each do |test|
	if test[0].is_multiple_of?(test[1]) != test[2]
		if test[2]
			raise "#{test[0]} should be a multiple of #{test[1]}"
		else
			raise "#{test[0]} should NOT be a multiple of #{test[1]}"
		end
	end
end

# print input form the command line or the default 10 if not argument given
# print_primes(ARGV[0].nil? ? 10 : ARGV[0].to_i, ARGV[2] == 'silent' ? true : false )

if ARGV[1] == 'test'
	# sample_input = 300
	sample_input = ARGV[0] 
	time = TimeTrial.new('optimized')
	puts time.time_test('print_primes',{
				:trials => 10, 
				:sample_input => [sample_input,true], 
				:test_cases => [0,1]
			}
		)

	puts time.time_test('find_primes',{
				:trials => 10, 
				:sample_input => [sample_input]
			}
		)
end





