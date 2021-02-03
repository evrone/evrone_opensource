# frozen_string_literal: true

module PipelineService
  module Improvement
    # Highlight gem syntax in README.md
    module ReadmeGemImprovement2
      module_function

      PATTERN = /(?<line>```\n(?<gem>gem\s["'].+["'])\n)```/.freeze

      # Replaces PATTERN with highlighted gem definition,
      # "
      # ```
      #     gem '<gem_name-here>'
      # ```
      # "
      #
      # becomes
      #
      # "
      #
      # ```ruby
      # gem '<gem_name-here>'
      # ```
      #
      # "
      def call(directory)
        file    = "#{directory}/README.md"
        content = File.read(file)
        matched = content.match(PATTERN)

        return unless matched

        highlight_gem_syntax \
          file, content, matched[:line], matched[:gem]
      end

      def highlight_gem_syntax(filepath, content, line, gem)
        improvement = <<-STR.strip_heredoc
        ```ruby
        #{gem}
        STR

        File.open(filepath, 'wb') do |f|
          content.sub!(line, improvement)
          f.write(content)
        end
      end
    end
  end
end
