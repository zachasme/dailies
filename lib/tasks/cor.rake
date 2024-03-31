require 'csv'
require 'open-uri'

namespace :cor do
  desc "This task imports inflections from COR"
  task import: :environment do
    filepath = 'tmp/storage/cor.tsv'

    unless File.exist? filepath
      download = URI.parse('https://ordregister.dk/files/cor1.02.tsv').open
      IO.copy_stream(download, filepath)
    end

    CSV.foreach(filepath, col_sep: /\t+/) do |row|
      Word.create!(
        #cor_id: row[0],
        lemma: row[1],
        inflection: row[2],
        fullform: row[3],
        normed: row[4],
      )
    end

  end
end
