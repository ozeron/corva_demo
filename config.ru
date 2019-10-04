require 'rubygems'
require 'bundler'

Bundler.require

require_relative 'lib/app'
run Sinatra::Application
