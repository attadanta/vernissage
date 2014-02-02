# coding: utf-8

module Vernissage

  class Report

    def initialize(curations)
      @curations = curations
    end

    def summaries
      @curations.map { |curation| summary_line(curation) }
    end

    def summary_line(curation)
      curation.to_gallery.name.ljust(25, '.') + stats(curation).rjust(15, '.')
    end

    def stats(curation)
      curation.find_unmatched_originals.length.to_s + ':' +
        curation.find_unmatched_thumbnails.length.to_s + ':' +
        curation.to_gallery.exhibits.length.to_s
    end

    def details
      @curations.map { |curation| unmatched_images(curation) }
    end

    def unmatched_images(curation)
      io = StringIO.new
      io.puts header(curation.to_gallery.name)
      io.puts('Unmatched original images:')
      io.puts list_images(curation.find_unmatched_originals)
      io.puts
      io.puts('Unmatched thumbnails:')
      io.puts list_images(curation.find_unmatched_thumbnails)
      io.close; io.string
    end

    def list_images(images)
      io = StringIO.new
      unless images.empty?
        images.each do |image|
          io.puts(' - ' + image.path.to_s)
        end
      else
        io.puts "None!"
      end
      io.close; io.string
    end

    def generated_at_line
      'vernissage.rb' + ' ' + timestamp
    end

    def timestamp
      Time.new.strftime("%Y-%m-%d @ %H:%M:%S")
    end

    def header(text, underline='-')
      text + "\n" + underline * text.length + "\n"
    end

    def generate
      io = StringIO.new
      io.puts header(generated_at_line, '=')
      io.puts
      io.puts header('Summary (o:t:m)')
      io.puts(summaries.join("\n"))
      io.puts
      io.puts(details.join("\n"))
      io.close; io.string
    end

  end

end
