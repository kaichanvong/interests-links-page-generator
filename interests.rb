require "/hypertext_from_markdown/hypertext_from_markdown"
SEARCH_URL = "https://twitter.com/search"
html_header2 = "h2"
file_of_interests = open('./index.html', 'a')
a_to_z = ('A'..'Z').to_a
interests_by_alphabet = interests_by_a_to_z = Hash.new([]); a_to_z.map { |alpha| interests_by_a_to_z[alpha] = [] }
all_interests = [] ## => ["penguins", "cats"]
interests = all_interests.map { |interest_keyword|  interests_by_alphabet[interest_keyword[0].capitalize] << interest_keyword }
list_of_interests = String.new
HTML_ORDERED_LIST = 'ol'
HTML_LIST_ITEM = 'li'
interests_by_alphabet.map do |key, k_interests|
	h2_attrs = {'html_element' => html_header2, 'attr_id' => key.to_s}
	list_of_interests += HyperTextFromMarkdownParser.new(key.to_s, h2_attrs).results
	k_interests_html = k_interests.map { |interest| url_link = "#{SEARCH_URL}?q=#{interest.gsub(' ','%20')}"; interest_link_md = "[#{interest}](#{url_link} 'external')"; HyperTextFromMarkdownParser.new(interest_link_md, HTML_LIST_ITEM).results }.join
	list_of_interests += k_interests_html
end
html_text = "<html><head></head><body>"+ HyperTextFromMarkdownParser.new(list_of_interests, HTML_ORDERED_LIST).results + "</body></html>"
file_of_interests << html_text
file_of_interests.close
