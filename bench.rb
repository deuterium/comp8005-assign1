#!/usr/bin/ruby
#Chris Wood - A00741285 - COMP8005 - Assignment 1
#Benchmark
#Use multiple processes and threads on either the Windows or Linux operating systems and measure the performance and efficiency of each mechanism.

require 'prime'

#global variables
usage = "Proper usage: ./bench [t|p]"
@num_workers = 5


#functions
def benchProcesses
	puts "#{@num_workers} processes"
end

def benchThreads
	puts "#{@num_workers} threads"
	doWork
end

def doWork
	pr = Integer(STDIN.gets)
	puts Prime.prime_division(pr)
end


#program logic
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
