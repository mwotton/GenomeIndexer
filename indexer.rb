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

def persist(output, offset)
  STDERR.puts "#{offset} : #{output}"
end

def run
  source = source_data "yeast"
  0.upto(source.length - 32) do |i|
    persist(parse(source, i), i)
  end
end

run
