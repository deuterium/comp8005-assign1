#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP8005 - Assignment 1
#Benchmark
#Use multiple processes and threads on either the Windows or Linux operating systems and measure the performance and efficiency of each mechanism.

require 'prime'
require 'thread'

#global variables
usage = "Proper usage: ./bench [t|p] \nt runs just threads, p runs just processes"
@num_workers = 5
@lock = Mutex.new

#functions
def timeNow
	return "#{Time.now}"
end

def info(msg)
	File.open("bench_log", 'a') { |f| f.write ("#{msg} \n") }
	puts msg
end

def benchProcesses
	info "#{@num_workers} processes"
	pids = Array.new(@num_workers)
	for i in 0..@num_workers
		pids[i] = i
	end
	puts pids
end

def benchThreads
	info "Starting thread benchmarking at #{timeNow}"

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

	puts "Completed thread benchmarking at #{timeNow}"
end

#55 = thread, 33 = process
def doWork(type, prime)
	puts Thread.current['prime']
	if type == 55
		info "#{Thread.current} starting at #{timeNow}"
		#Prime.prime_division(prime)
		#sleep(rand(3..10))
		info "#{Thread.current} end at #{timeNow}"
	elsif type == 33

	else
		info "should not get here!!! exiting"
		exit
	end	
end

#generate large numbers for primes to be found
def makePrimers
@prime_me = (1..@num_workers).map do |i|
	i = rand(9000000000000..9999999999999999)
end

info "Generated numbers to be primed:"
@prime_me.each {|p| info p}
end

#program main
#parse command line variables
if ARGV.count > 1
	puts usage
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
