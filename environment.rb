require 'csv'
require 'ostruct'
require 'rubygems'
require 'bundler/setup'

Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter  => 'postgresql', 
  :database => 'stadiums',
  :host     => 'localhost'
)

$: << '.'
require 'lib/db_builder'
require 'lib/data_importer'
require 'lib/models'
require 'lib/schedule_outputter'
