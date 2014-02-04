# coding: utf-8

module Vernissage

  # Generates site statistics.
  class Report

    # Report constructor.
    #
    # @param [Array<Curation>] curations
    def initialize(curations)
      @curations = curations
    end

    # Collects all {#summary_line}s.
    #
    # @return [Array<String>] the summary lines.
    def summaries
      @curations.map { |curation| summary_line(curation) }
    end

    # Outputs a formatted stats line to the standard out.
    #
    # @param [Vernissage::Curation] curation the object to extract the stats
    #   from.
    #
    # @return [String] status line.
    def summary_line(curation)
      curation.to_gallery.name.ljust(25, '.') + stats(curation).rjust(15, '.')
    end

    # Returns a triple indicating the number of unmatched original images, the
    # number of unmatched thumbnails and the number of exhibits in a curation
    # respectively.
    #
    # @param [Vernissage::Curation] curation the object to calculate the
    #   statistics from.
    #
    # @return [String] a stats line.
    def stats(curation)
      curation.find_unmatched_originals.length.to_s + ':' +
        curation.find_unmatched_thumbnails.length.to_s + ':' +
        curation.to_gallery.exhibits.length.to_s
    end

    # Compiles all {#unmatched_images}.
    #
    # @return [Array<String>] a listing of unmatched images.
    def details
      @curations.map { |curation| unmatched_images(curation) }
    end

    # Generates the missing images info.
    #
    # @param [Vernissage::Curation] curation the object to extract the
    #   statistics from.
    #
    # @return [String] list of unmatched images formatted for the standard out.
    def unmatched_images(curation)
      StringIO.open do |io|
        io.puts header(curation.to_gallery.name)
        io.puts('Unmatched original images:')
        io.puts list_images(curation.find_unmatched_originals)
        io.puts
        io.puts('Unmatched thumbnails:')
        io.puts list_images(curation.find_unmatched_thumbnails)
        io.string
      end
    end

    # Formats a list of images for the standard output.
    #
    # @param [Array<Vernissage::Image>] images a list of images.
    #
    # @return [String]
    def list_images(images)
      StringIO.open do |io|
        unless images.empty?
          images.each do |image|
            io.puts(' - ' + image.path.to_s)
          end
        else
          io.puts "None!"
        end
        io.string
      end
    end

    # Creates the report heading.
    #
    # @return [String] heading text.
    def generated_at_line
      'vernissage.rb' + ' ' + timestamp
    end

    # Formats the current time for the standard out.
    #
    # @return [String] timestamp.
    def timestamp
      Time.new.strftime("%Y-%m-%d @ %H:%M:%S")
    end

    # Formats a text for a heading displayed on the standard output.
    #
    # @param [String] text the heading text.
    # @param [String] underline the character to underline the text with.
    #
    # @return [String] the formatted text.
    def header(text, underline='-')
      text + "\n" + underline * text.length + "\n"
    end

    # Generates the report.
    #
    # @return [String]
    def generate
      StringIO.open do |io|
        io.puts header(generated_at_line, '=')
        io.puts
        io.puts header('Summary (o:t:m)')
        io.puts(summaries.join("\n"))
        io.puts
        io.puts(details.join("\n"))
        io.string
      end
    end

  end

end
