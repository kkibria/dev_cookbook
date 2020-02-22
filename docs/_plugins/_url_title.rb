# Capitalize all words of the input
module Jekyll
    module UrlTitle
        def url_title(words)
            a = words.split('/').last.split('.').first.split(/[-,_]/)
            b = a.map(&:capitalize).join(' ')
            return b
        end
    end
end
  
Liquid::Template.register_filter(Jekyll::UrlTitle)