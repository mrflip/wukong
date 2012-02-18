#!/usr/bin/env ruby
# require 'taglib'
# require 'yaml'; require 'json'
# require 'configliere'; Settings.use :commandline
# require 'gorillib'
# require 'gorillib/logger/log'

require 'awesome_print'
$:.unshift File.expand_path("~/ics/backend/icss-gh/lib")
require 'icss'
Settings.catalog_root = File.expand_path("~/ics/backend/infochimps_catalog-gh")


module Icss::ReceiverModel::ActsAsCatalog::ClassMethods
  def load_catalog(flush=false)
    flush_registry if flush
    load_files_from_catalog('core')
  end
end

# Icss::Meta::Type.find('culture.creative_work')
# Icss::Meta::Type.find('culture.music_recording')
# # ap Icss::Thing.to_schema
# ap Icss::Culture::MusicRecording.to_schema
