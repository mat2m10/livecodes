require 'open-uri'
require 'nokogiri'
require_relative 'recipe'

class ScrapeOnline
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    recepies_array = []
    url = "https://www.allrecipes.com/search/results/?search=#{@ingredient}"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.card__recipe').first(5).each do |element|
      name = element.search('.card__title').text.strip
      description = element.search('.card__summary').text.strip
      recepies_array << Recipe.new({name: name, description: description})
    end
    return recepies_array
  end
end
