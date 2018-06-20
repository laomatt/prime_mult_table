require 'benchmark'
require 'bigdecimal/math'

class TimeTrial
	def initialize(lookfor=nil)
		@lookfor = lookfor
	end

	def compare_methods(method,trials,sample_input,version,object=nil)
		orig_sum = 0
		opt_sum = 0
		result = nil
		result2 = nil
		if object
			trials.times do
				orig_sum += Benchmark.measure { 
					result = object.send(method.to_sym,*sample_input) 
				}.total

				if @lookfor
					opt_sum += Benchmark.measure { 
						result2 = object.send("#{method}_#{@lookfor}#{ version ? '_' : '' }#{version}".to_sym,*sample_input) 
					}.total
				else
					opt_sum += Benchmark.measure { 
						result2 = object.send("#{method}#{ version ? '_' : '' }#{version}".to_sym,*sample_input) 
					}.total
				end
			end
		else
			trials.times do 

				orig_sum += Benchmark.measure { 
					result = send(method.to_sym,*sample_input) 
				}.total

				if @lookfor
					opt_sum += Benchmark.measure { 
						result2 = send("#{method}_#{@lookfor}#{ version ? '_' : '' }#{version}".to_sym,*sample_input) 
					}.total
				else
					opt_sum += Benchmark.measure { 
						result2 = send("#{method}#{ version ? '_' : '' }#{version}".to_sym,*sample_input) 
					}.total
				end
			end
		end

		raise 'inconsistent results' if result != result2

		[orig_sum,opt_sum]
	end


	def time_test(method,options={})
			if options[:trials]
				trials = options[:trials]
			else
				trials = 1
			end

			if options[:object]
				object = options[:object]
			else
				object = nil
			end

			if options[:sample_input]
				sample_input = options[:sample_input]
			else
				sample_input = nil
			end

			if options[:test_cases]
				test_cases = options[:test_cases]
			else
				test_cases = nil
			end

			message = "\n"
			message += " --------------- #{method} report --------------- \n"

			if options[:test_cases]
				options[:test_cases].each do |version|
					message += " --------------- #{method}_#{version} --------------- \n"
					message += "Over #{trials} trials:\n"
					begin
						orig_sum,opt_sum = compare_methods(method,10,sample_input,version,object)
						original = orig_sum/trials
						optimized = opt_sum/trials

						message += "Original: #{original}\n"
						message += "Optimized: #{optimized}\n"
						diff = original - optimized
						message += "Time difference: #{diff}\n"
						if diff < 0
							message += "The optimized solution performs worse.\n"
						elsif diff > 0
							message += "The optimized solution performs better.\n"
						else
							message += "There is no difference in time.\n"
						end

					rescue Exception => e
						message += e.message
						
					end
					message += "\n"
				end

			else
				orig_sum,opt_sum = compare_methods(method,10,sample_input,nil,object)
				original = orig_sum/trials
				optimized = opt_sum/trials

				message += "Over #{trials} trials:\n"
				begin
					message += "Original: #{original}\n"
					message += "Optimized: #{optimized}\n"
					diff = original - optimized
					message += "Time difference: #{diff}\n"
					if diff < 0
						message += "The optimized solution performs worse.\n"
					elsif diff > 0
						message += "The optimized solution performs better.\n"
					else
						message += "There is no difference in time.\n"
					end
					
				rescue Exception => e
						message += e.message
					
				end

				message += "\n"
					
			end
			message
	end

end