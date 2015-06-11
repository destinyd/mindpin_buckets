require 'active_support/dependencies'

require "mindpin_buckets/bucket_methods"
require "mindpin_buckets/bucket_resource_methods"
require "mindpin_buckets/version"

module MindpinBuckets
  # Our host application root path
  # We set this when the engine is initialized
  mattr_accessor :app_root

  # Yield self on setup for nice config blocks
  def self.setup
    yield self
  end
end

require 'mindpin_buckets/rails'
