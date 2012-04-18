require 'csv'
require 'rubygems'
require 'bundler/setup'

Bundler.require

ActiveRecord::Base.establish_connection(:adapter => 'postgresql', :database => 'stadiums')

$: << '.'
require 'lib/db_builder'
require 'lib/data_importer'
require 'lib/models'
