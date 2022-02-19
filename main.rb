# Find the longest common prefix string amongst an array of strings

# Total amount of words to sample out of english dictionary
SAMPLE_SIZE = 50

# Read words
words = []
File.open('words.txt', 'r') do |handle|
  handle.each_line do |line|
    words.append line.strip if line.strip.chomp != ''
  end
end

# Build sample set
samples = []
SAMPLE_SIZE.times do
  samples.append words.sample.strip
end

puts "Sample set:"
samples.each do |sample|
  puts sample
end

# Find smallest word length of the sample set
# (number of times to iterate checking for matches)
min_length = samples[0].length
samples.each do |sample|
  if sample.length < min_length
    min_length = sample.length
  end
end

# Build matches
matches = {}

# Iterate through samples to match repeating prefixes
min_length.times do |i|
  samples.each do |sample|
    # Select relevant characters for our sample
    match = sample[0..i]
    if matches[match]
      # The match exists, add 1 to the value
      matches[match] += 1
    else
      # The match does not exist yet, create it and set it to 1
      matches[match] = 1
    end
  end

  # Delete matches that only showed up once
  matches.each do |key, value|
    if value == 1
      matches.delete(key)
    end
  end
end

# Calculate the result length from the remaining match keys
result_length = 0
matches.each_key do |key|
  if key.length > result_length
    result_length = key.length
  end
end

# Delete all match keys that are shorter than the result length
# (Since we're finding the *longest* common prefix, anything shorter than the longest value is useless to us)
matches.each_key do |key|
  if key.length < result_length
    matches.delete(key)
  end
end

# Find maximum amount of occurrences from remaining matches, resulting in our final answer, "result"
max_occurrences = 0
result = ''

matches.each do |key, value|
  if value > max_occurrences
    result = key
  end
end

# Print results to console
puts
puts 'Longest common prefix:'
puts result.inspect