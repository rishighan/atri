module Rouge
  module Plugins
    module Redcarpet
      def block_code(code, language)
        lexer = Lexer.find_fancy(language, code) || Lexers::PlainText

        # XXX HACK: Redcarpet strips hard tabs out of code blocks,
        # so we assume you're not using leading spaces that aren't tabs,
        # and just replace them here.
        if lexer.tag == 'make'
          code.gsub! /^    /, "\t"
        end

        formatter = rouge_formatter(
          :css_class => "highlight #{lexer.tag}",
          :line_numbers => true
        )

        formatter.format(lexer.lex(code))
      end

    protected
      def rouge_formatter(opts={})
        Formatters::HTML.new(opts)
      end
    end
  end
end