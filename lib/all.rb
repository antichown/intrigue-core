# Task-related Gems
require 'aws-sdk-sqs'
require 'aws-sdk-s3'
require 'censys'
require 'compare-xml'
require 'digest'
require 'dnsruby'
require 'em-resolv-replace'
require 'ipaddr'
require 'json'
require 'maxminddb'
require 'net/dns'
require 'net/http'
require 'net-http2'
require 'nmap/xml'
require 'nokogiri'
require 'open-uri'
require 'opencorporates'
require 'openssl'
require 'resolv'
require 'resolv-replace'
require 'rexml/document'
require 'snmp'
require 'socket'
require 'spidr'
require 'tempfile'
require 'thread'
require 'towerdata_api'
require 'uri'
require 'whois'
require 'whois-parser'
require 'whoisology'
require 'zip'

###
### SYSTEM HELPERS (for use everywhere)
###

# Intrigue System-wide Bootstrap
require_relative 'system/bootstrap'
include Intrigue::System::Bootstrap

# Intrigue System-wide Match Exeptions
require_relative 'system/match_exceptions'
include Intrigue::System::MatchExceptions

# Intrigue System-wide Validations 
require_relative 'system/validations'
include Intrigue::System::Validations

###
### END SYSTEM HELPERS
###


####
# Task-specific libraries
####
require_relative 'intrigue-tasks'

####
## Machines
####
require_relative 'machine_factory'
require_relative 'machines/base'
machines_folder = File.expand_path('../machines', __FILE__) # get absolute directory
Dir["#{machines_folder}/*.rb"].each {|f| require_relative f}


# Client libraries
require_relative 'client'

####
# Entity Libraries
####
require_relative 'entity_factory'
require_relative 'entity_manager'

# Load all .rb file in lib/entities by default
entities_folder = File.expand_path('../entities', __FILE__) # get absolute directory
require_relative "#{entities_folder}/network_service" # have to do this first, since others dep on it
Dir["#{entities_folder}/*.rb"].each {|f| require_relative f}

####
# Issue Libraries
####
require_relative 'intrigue-issues'
issues_folder = File.expand_path('../issues', __FILE__) # get absolute directory
Dir["#{issues_folder}/*.rb"].each {|f| require_relative f}

#  note that all specific issues are sourced in via this file (for reasons described in that file)

####
# Handler Libraries
####
require_relative 'handler_factory'
require_relative 'handlers/base'
handlers_folder = File.expand_path('../handlers', __FILE__) # get absolute directory
Dir["#{handlers_folder}/*.rb"].each {|f| require_relative f}


####
# Notifier Libraries
####
require_relative 'notifier_factory'
require_relative 'notifiers/base'
notifiers_folder = File.expand_path('../notifiers', __FILE__) # get absolute directory
Dir["#{notifiers_folder}/*.rb"].each {|f| require_relative f}


###
### User-specified directories
###
# And check to see if there are any specified load paths

if Intrigue::System::Config.config["intrigue_load_paths"]
  Intrigue::System::Config.config["intrigue_load_paths"].each do |load_path|
    load_path = "#{load_path}" unless load_path[0] == "/"

    Dir["#{load_path}/entities/*.rb"].each do |file|
      #puts "Adding user entity from: #{file}"
      require_relative file
    end

    Dir["#{load_path}/handlers/*.rb"].each do |file|
      #puts "Adding user handler from: #{file}"
      require_relative file
    end

    Dir["#{load_path}/machines/*.rb"].each do |file|
      #puts "Adding user machine from: #{file}"
      require_relative file
    end

    Dir["#{load_path}/notifiers/*.rb"].each do |file|
      #puts "Adding user notifier from: #{file}"
      require_relative file
    end

    Dir["#{load_path}/tasks/*.rb"].each do |file|
      #puts "Adding user task from: #{file}"
      require_relative file
    end

  end
end
