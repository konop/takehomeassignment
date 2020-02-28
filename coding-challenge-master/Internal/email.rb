#!/usr/bin/env ruby

require 'FileUtils'

OUTPUT_DIR = 'challenge'.freeze

# Remove existing output directoy and create an empty one
system("rm -rf #{OUTPUT_DIR}")
system("mkdir -p #{OUTPUT_DIR}")

# Copy files
FileUtils.cp_r('Sources', OUTPUT_DIR)
FileUtils.cp_r('Tests', OUTPUT_DIR)
FileUtils.cp_r('CodeChallenge.xcodeproj', OUTPUT_DIR)
FileUtils.cp_r('iPhone 8.png', OUTPUT_DIR)
FileUtils.cp_r('README.md', OUTPUT_DIR)

# Initialize a local git repository
Dir.chdir(OUTPUT_DIR) do
  system('git init . > /dev/null')
  system('git add . && git ci -m "Initial commit" > /dev/null')
end

# Zip the directory and remove the folder
system("zip -r #{OUTPUT_DIR}.zip #{OUTPUT_DIR} > /dev/null")
system("rm -rf #{OUTPUT_DIR}")

# Print instructions
puts 'Please send an email with this:'
puts "\n --- \n\n"
puts 'Subject: Hootsuite Coding Challenge'
puts ''
puts File.read('Internal/CodeEmail.md')
puts "\n\n ---"
