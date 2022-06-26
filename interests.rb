require "../apps/hypertext_from_my_markdown/hypertext_from_my_markdown"
require "../helpers/kaichanvong/HTML_elements"

file_of_interests = open('./index.html', 'a')
a_to_z = ('A'..'Z').to_a
interests_by_alphabet = interests_by_a_to_z = Hash.new([]); a_to_z.map { |alpha| interests_by_a_to_z[alpha] = [] }
all_interests = [] ## =>
interests = all_interests.map { |interest_keyword|  interests_by_alphabet[interest_keyword[0]] << interest_keyword }
list_of_interests = String.new
interests_by_alphabet.map do |key, k_interests| 
	list_of_interests += HyperTextFromMarkdownParser.new(key.to_s, {'html_element' => HTML_HEADER2, 'attr_id' => key.to_s}).results  	
	list_of_interests += (k_interests.map { |interest| interest = interest.split("(")[0];interest = "[#{interest}](https://twitter.com/search?q=#{interest.gsub(' ','%20')} 'external')"; HyperTextFromMarkdownParser.new(interest, HTML_LIST_ITEM).results }).join
end
puts list_of_interests
html_a_z = a_to_z.map { |alpha_item| HyperTextFromMarkdownParser.new("[#{alpha_item}](##{alpha_item})", HTML_LIST_ITEM).results }.join
file_of_interests << HyperTextFromMarkdownParser.new(html_a_z, HTML_ORDERED_LIST).results
file_of_interests << HyperTextFromMarkdownParser.new( list_of_interests, HTML_ORDERED_LIST ).results
file_of_interests.close
