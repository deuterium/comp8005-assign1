#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP8005 - Assignment 1
#Benchmark
#Use multiple processes and threads on either the Windows or Linux operating systems and measure the performance and efficiency of each mechanism.

require 'prime'
require 'thread'

#global variables
usage = "Proper usage: ./bench [t|p]"
@num_workers = 5


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
	threads = Array.new(@num_workers)
	info "Starting total of #{@num_workers} threads at #{timeNow}"
	for i in 0..@num_workers
		threads[i] = Thread.new{ doWork(i,55) }
	end
	#wait for each thread to finish before continuing
	for i in 0..@num_workers
		threads[i].join
	end
	
	puts "Completed thread benchmarking at #{timeNow}"
end

#55 = thread, 33 = process
def doWork(id, type)
	if type == 55
		info "#{Thread.current} starting at #{timeNow}"
		#Prime.prime_division(22)
		sleep(rand(3..10))
		info "#{Thread.current} end at #{timeNow}"
	elsif type == 33

	else
		info "should get here!!!"
		exit
	end	
end

#program main
if ARGV.count > 1 || ARGV.empty?
	puts usage
	exit
elsif ARGV[0].eql? 't'
	# run threads
	benchThreads
elsif ARGV[0].eql? 'p'
	# run process
	benchProcesses
else 
	puts usage
end
