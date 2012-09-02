#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require

class MyUploader < CarrierWave::Uploader::Base
  include CarrierWave::Vips

  version :thumb do
    process :resize_to_fill => [296, 185]
    process :quality => 80
    process :strip # Do not store EXIF data in the thumb to save space
  end

  version :preview do
    # Only resize on width (the 9999999 height should ensure this)
    process :resize_to_fit => [960, 9999999]
    process :quality => 80
    process :strip # Do not store EXIF data in the preview to save space
  end
end

MyUploader.new.store!(File.open('example.png'))
