# William Hudgins
# 06/25/15
# PigLatinTranslator
#
# Takes a given file, with one sentence per line, and translates it into pig latin
# Note: I'm not sure how to deal with apostrophe's or colons in pig latin...

class PigLatinTranslator
  def self.translate_sentence(sentence)
    sentence = sentence.split(' ') 
    translated_sentence = sentence.map { |word| word = self.translate_word(word) }
    puts translated_sentence.join(" ")
  end

  # If a word starts with a vowel, append "ay"
  # If a word is a consonant, move the first letter to the end and then append "ay"
  def self.translate_word(word)
    if word[0] =~ /(a|e|i|o|u)/
      word = word + "ay"
    else
      word = word[1..-1] + word[0] + "ay"
    end
   return word
  end
end

# Check input
if (ARGV[0] == nil)
  raise ArgumentError.new("Usage: ruby PigLatinTranslator.rb filename")
end

# Read in and translate sentences. Note: once a sentence is translated, it is not held in
# memory. This is done to deliberately minimize memory foot print
begin
  File.foreach(ARGV[0]) { |sentence| 
    puts PigLatinTranslator.translate_sentence(sentence.delete("\n")) }
  rescue => error  
    fail Errno::ENOENT, 'Could not open specified file for reading' 
end

