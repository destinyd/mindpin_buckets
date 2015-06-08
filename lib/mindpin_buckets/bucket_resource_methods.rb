module MindpinBuckets
  module BucketResourceMethods
    extend ActiveSupport::Concern

    included do
      include Mongoid::Document
      include Mongoid::Timestamps

      cattr_accessor :into
    end

    module ClassMethods
      # act_as_bucket_resource into: :folder

      def act_as_bucket_resource(*fields, &block)
        options = fields.extract_options!
        self.into = options[:into]

        case self.into.class.name
        when "Symbol", "String"
          self.into = self.into.to_s
          has_and_belongs_to_many self.into.to_s.pluralize.to_s
        else
          raise "must be symbol or string"
        end
        
        define_method :add_to_bucket do |bucket|
          singularize_name = bucket.class.name.downcase
          pluralize_name = singularize_name.pluralize
          return bucket.add_resource(self) if self.into == singularize_name
          false
        end

        define_method :add_to_buckets do |buckets|
          if buckets.class.name == "Array"
            buckets.each do |bucket|
              add_to_bucket(bucket)
            end
            return true
          end
          false
        end

        define_method :remove_from_bucket do |resource|
          return true if resource.class.name.downcase == self.into and resource.remove_resource(self)
          false
        end

        define_method :remove_from_buckets do |resources|
          if resources.class.name == "Array"
            resources.each do |resource|
              resource.remove_resource(self)
            end
            return true
          end
          false
        end
      end
    end
  end

end

