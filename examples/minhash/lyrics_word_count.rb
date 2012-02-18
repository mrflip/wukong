#!/usr/bin/env ruby
require 'rubygems'
require 'wukong/script'
require 'yajl/json_gem'

module LyricsWordCount
  class LyricsRecordToWordCount < Wukong::Streamer::JsonStreamer

    #
    # Emit each word in each line.
    #
    def process lyrics_hsh
      return unless lyrics_hsh['wordbag']
      lyrics_hsh['wordbag'].each do |word, count|
        yield [word, lyrics_hsh['artist'], lyrics_hsh['title'], lyrics_hsh['genre'], count]
      end
    end
  end

  # class WordCounter < Wukong::Streamer::AccumulatingReducer
  #   def start!(*args)      @key_count =  0 end
  #   def accumulate(*args)  @key_count += 1 end
  #   def finalize
  #     yield [ @key_count, key ]
  #   end
  # end

end

# Execute the script
Wukong.run(
  LyricsWordCount::LyricsRecordToWordCount,
  nil # WordCount::WordCounter
  )
