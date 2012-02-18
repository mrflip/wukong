#!/usr/bin/env ruby
require 'rubygems'
require 'wukong/script'

module WordCount
  class Tokenizer < Wukong::Streamer::LineStreamer

    #
    # Emit each word in each line.
    #
    def process line
      Wukong::Helper::Tokenizer.tokenize(line).each{|word| yield [word, 1] }
    end
  end

  class WordCounter < Wukong::Streamer::AccumulatingReducer
    def start!(*args)      @key_count =  0 end
    def accumulate(*args)  @key_count += 1 end
    def finalize
      yield [ @key_count, key ]
    end
  end

end

# Execute the script
Wukong.run(
  WordCount::Tokenizer,
  WordCount::WordCounter
  )
