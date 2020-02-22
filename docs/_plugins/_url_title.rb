require 'liquid'

# Capitalize all words of the input
module Jekyll
  module UrlTitle
    def url_title(words)
      return words.split('/').last.split('.').first.capitalize.split(/[-,_]/).join(' ')
      # a = words.split('/').last.split('.').first.split(/[-,_]/)
      # b = a.map(&:capitalize).join(' ')
      # return b
    end
  end
end
  
Liquid::Template.register_filter(Jekyll::UrlTitle)