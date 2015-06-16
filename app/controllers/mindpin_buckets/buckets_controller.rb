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
            id: bucket.id.to_s,
            name: bucket.name,
            desc: bucket.desc,
            added: get_resource ? bucket.include_resource?(get_resource) : false
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
          id: @bucket.id.to_s,
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
    params[:bucket_type]
  end

  def bucket_start
    current_user.send(get_bucket_type.downcase.pluralize)
  end

  def collection
    bucket_start.all
  end

  def get_resource
    return nil if params[:resource_type].blank? or params[:resource_id].blank?
    @resource ||= params[:resource_type].humanize.constantize.find params[:resource_id]
  end
end
