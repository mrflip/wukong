#!/usr/bin/env ruby
require 'taglib'
require 'yaml'; require 'json'
require 'configliere'; Settings.use :commandline
require 'gorillib'
require 'gorillib/logger/log'
$:.unshift('../../lib', File.dirname(__FILE__))
require 'wukong'
require 'wukong/helper'

Settings.define :output_dir, :default => '/tmp/lyrics', :type => :filename, :description => "Destination directory. Will create files like 'lyrics-{artist}.yaml', overwriting anything present"
Settings.define :dump_empty, :default => false,         :type => :boolean,  :description => "Dump files even if they're empty"
Settings.resolve!

frame_factory = TagLib::ID3v2::FrameFactory.instance
frame_factory.default_text_encoding = TagLib::String::UTF8

class Mp3File
  attr_reader :mp3_filename, :file, :tag, :lyrics
  def initialize(mp3_filename)
    @mp3_filename = mp3_filename
    @file         = TagLib::MPEG::File.new(mp3_filename)
    @tag          = file.id3v2_tag                      # or (tagger_warn("no id3v2 tag found"); return)
    @lyrics       = tag && tag.frame_list('USLT').first # or (tagger_warn("no lyrics found");    return)
  end

  def tagger_warn(str)
    warn("%-142s\t%s" % [mp3_filename, str])
  end

  def genre()  tag.genre  ; end
  def artist() tag.artist ; end
  def track()  tag.track  ; end
  def title()  tag.title  ; end
  def album()  tag.album  ; end
  def year()   tag.year.to_i == 0 ? nil : tag.year  ; end

  def lyrics_text
    return unless lyrics?
    text = lyrics.text.to_s
    text.gsub!(/\r\n?/m, "\n")
    text.gsub!(/^ *\[ Get Lyrical.*$/, '')
    text.gsub!(/\s+\z/m, '')
    text
  end

  def lyrics_wordbag
    return unless lyrics?
    txt = lyrics_text.split(/\n/)[3..-1] or return # nuke the artist and song title
    txt = txt.join("\n")
    counts = Hash.new{|h,k| h[k] = 0 }
    Wukong::Helper::Tokenize.tokenize(txt).each do |word|
      counts[word] += 1
    end
    counts
  end

  def lyrics?
    lyrics && lyrics.text.present?
  end

  def to_hash
    {
      :artist => artist,
      :album  => album,
      :year   => year,
      :track  => track,
      :title  => title,
      :genre  => genre,
      :lyrics => lyrics_text,
      :frames => frame_hash
    }
  end

protected

  def frame_hash
    fh = {}
    tag.frame_list.each do |frame|
      next if %w[USLT TALB TIT2 TPE1].include?(frame.frame_id)
      fh[frame.frame_id] = frame.to_string
    end
    fh
  end
end

Settings.rest.each do |path|
  path = path + '/**/*.mp3' unless path =~ /\.mp3$/
  Log.info(path)
  Dir[path].each do |mp3_filename|
    mp3 = Mp3File.new(mp3_filename)
    hsh = mp3.to_hash
    hsh[:wordbag] = mp3.lyrics_wordbag
    hsh.delete(:lyrics)
    puts JSON.dump(hsh) if (mp3.lyrics? || Settings.dump_empty)
  end
end
