#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../config/environment"
require "rack"

run Rails.application
Rails.application.load_server
