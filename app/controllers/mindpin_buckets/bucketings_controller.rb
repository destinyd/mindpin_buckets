class MindpinBuckets::BucketingsController < ::ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  def create
    begin 
      bucket_id = params[:bucket_id]
      resource_id = params[:resource_id]

      @bucket = bucket_start.find bucket_id
      @resource = resource_start.find resource_id
      if @resource.add_to_bucket @bucket
        render json: {
          type: type, 
          result: {
            id: @bucket.id.to_s,
            name: @bucket.name,
            desc: @bucket.desc
          }
        }
      else
        render json: {error: "remove failure"}, status: 500
      end
    rescue
      render json: {error: "unknowns"}, status: 500
    end
  end

  def destroy
    begin 
      bucket_id = params[:bucket_id]
      resource_id = params[:resource_id]

      @bucket = bucket_start.find bucket_id
      @resource = resource_start.find resource_id
      if @resource.remove_from_bucket @bucket
        render json: {
          type: type, 
          result: {
            id: @bucket.id.to_s,
            name: @bucket.name,
            desc: @bucket.desc
          }
        }
      else
        render json: {error: "remove failure"}, status: 500
      end
    rescue
      render json: {error: "unknowns"}, status: 500
    end
  end

  protected
  def get_bucket_type
    params[:bucket_type]
  end

  def bucket_start
    current_user.send(:get_bucket_type.downcase.pluralize)
  end

  def get_resource_type
    params[:resource_type]
  end

  def resource_start
    get_resource_type.humanize.constantize
  end
end
