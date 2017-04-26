require 'nokogiri'
require 'parallel'
require 'ruby-progressbar'
require 'net/http'
require 'matrix'
require 'yaml'

Dir['./lib/**/*.rb'].each { |file| require file }
