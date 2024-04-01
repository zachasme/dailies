require 'csv'
require 'open-uri'

namespace :cor do
  desc "This task imports inflections from COR"
  task import: :environment do
    filepath = 'tmp/storage/cor.tsv'
    parsed_file = 'tmp/storage/words.txt'

    unless File.exist? filepath
      download = URI.parse('https://ordregister.dk/files/cor1.02.tsv').open
      IO.copy_stream(download, filepath)
    end

    # Alle gyldige former af alle ord i Retskrivningsordbogen godtages, såfremt de
    # ikke er proprier (egennavne), forkortelser eller indeholder tegn, der ikke er
    # bogstaver, f.eks. apostrof eller bindestreg. 

    words = Set.new
    CSV.foreach(filepath, col_sep: "\t") do |row|
      cor_id, lemma, description, type, fullform, normed = row
      next unless /^[a-zA-ZæøåÆØÅ]{5}$/ =~ fullform
      next if type.split('.').include? 'prop'
      words << fullform
    end

    File.open(parsed_file, "w") do |file|
      file.puts(words.to_a.sort)
    end

  end
end
