def source_data(directory)
  source = ""
  Dir.open(directory).entries.each do |file|
    next if File.extname(file) != ".fna"
    source << File.readlines("#{directory}/#{file}")[1..-1].map {|line| line.chomp}.join
  end
  source
end

def parse(source, offset)
  source[offset, 32]
end

def persist(output)
  STDERR.puts output
end

def run
  0.upto(source_data.length - 32) do |i|
    persist parse(source_data, i)
  end
end

puts source_data "yeast"
