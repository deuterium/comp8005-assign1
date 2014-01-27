#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP8005 - Assignment 1
#Benchmark
#Use multiple processes and threads on either the Windows or Linux operating systems and measure the performance and efficiency of each mechanism.

require 'prime'
require 'thread'

##global variables
@num_workers = 5

##functions
#Returns the system time (long format YYYY-MM-DD HH:MM:SS -GMT_DISPLACEMENT)
def timeNow
	return "#{Time.now}"
end

#info function - logs to file and verbose to STDOUT
#definitely not thread safe but shouldn't matter as long as 
#multiple file handles can be open to append to file
def info(msg)
	File.open("bench_log", 'a') { |f| f.write ("#{msg} \n") }
	puts msg
end

#benchmarks multiprocessing: 5 proccess calculating primes from the pregenerated
#numbers in makePrimers(). 
def benchProcesses
	#TODO
end

#benchmarks multithreading: 5 threads calculating primes from the pregenerated
#numbers in makePrimers(). 
def benchThreads
	info "Starting thread benchmarking at #{timeNow}"

	#make 5 threads and do hard math in each (calc primes)
	threads = (1..@num_workers).map do |t|
		Thread.new(t) do |t|
			info "#{Thread.current} starting at #{timeNow}"
			info "#{Thread.current} #{Prime.prime_division(@prime_me[t-1])}"
			#sleep(rand(3..10)) #debugging for threads
			info "#{Thread.current} end at #{timeNow}"
		end
	end

	#wait for each thread to finish before continuing
	threads.each {|t| t.join}
	info "Completed thread benchmarking at #{timeNow}"
end

#generate large numbers for primes to be found (commonly used if both
#tests are run sequencially (no cmdline arguments))
def makePrimers
@prime_me = (1..@num_workers).map do |i|
	#smaller of the large numbers that actually take time to calculate
	#on my i5-2500k
	i = rand(9000000000000..9999999999999999)
end

info "Generated numbers to be primed:"
@prime_me.each {|p| info p}
end

#program main
#parse command line variables
if ARGV.count > 1
	puts "Proper usage: ./bench [t|p] \nt runs just threads, p runs just processes"
	exit
elsif ARGV[0].eql? 't'
	makePrimers
	ARGV.clear #clear input buffer (argv counts in ruby)
	benchThreads
elsif ARGV[0].eql? 'p'
	makePrimers
	ARGV.clear
	benchProcesses
else 
	makePrimers
	ARGV.clear
	benchProcesses
	benchThreads
end
