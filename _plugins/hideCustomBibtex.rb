module Jekyll
  module HideCustomBibtex
    def hideCustomBibtex(input)
      keywords = @context.registers[:site].config['filtered_bibtex_keywords']

      keywords.each do |keyword|
        escaped = Regexp.escape(keyword)
        input = input.gsub(/^.*#{escaped}.*$\n/, '')
      end

      input
    end
  end
end

Liquid::Template.register_filter(Jekyll::HideCustomBibtex)
