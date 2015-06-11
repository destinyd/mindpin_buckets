class MindpinBuckets::BucketsController < ::ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  def index
    begin 
      @buckets = collection
      render json: {
        type: get_bucket_type,
        result: @buckets.map do |bucket|
          {
            id: bucket.id,
            name: bucket.name,
            desc: bucket.desc
          }
        end
      }
    rescue
      render json: {error: "unknowns"}, status: 500
    end
  end

  def create
    begin 
      name = params[:name]
      desc = params[:desc]
      @bucket = bucket_start.create name: name, desc: desc
      render json: {
        type: get_bucket_type,
        result: {
          id: @bucket.id,
          name: @bucket.name,
          desc: @bucket.desc
        }
      }
    rescue
      render json: {error: "unknowns"}, status: 500
    end
  end

  protected
  def get_bucket_type
    params[:type]
  end

  def bucket_start
    #get_bucket_type.humanize.constantize
    current_user.send(get_bucket_type.downcase.pluralize)
  end

  def collection
    bucket_start.all
  end
end
