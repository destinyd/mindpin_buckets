class @MindpinBuckets
  constructor: (@$path_fix, @$progress)->
    @_init()

  _init: ->
    if !@$path_fix
      @$path_fix = ""
    @buckets_path = @$path_fix + "/buckets"
    @bucketings_path = @$path_fix + "/bucketings"
    @$progress ||= new MindpinBucketsProgress(@)

  buckets: (bucket_type) ->
    jQuery.ajax
      url: "#{@buckets_path}?type=#{bucket_type}"
      method: "GET"
      success: (res) =>
        console.log "buckets success"
        console.log res
        if res['result']
          @$progress.get_buckets_success(res.result)
        else
          @$progress.error(res.error)

  create_bucket: (bucket_type, name, desc) ->
    jQuery.ajax
      url: @buckets_path
      method: "POST"
      data: 
        type: bucket_type
        name: name
        desc: desc
      success: (res) =>
        console.log "create bucket success"
        console.log res
        if res['result']
          console.log res.result
          @$progress.create_bucket_success(res.result)
        else
          @$progress.error(res.error)

  add_to_bucket: (resource_type, resource_id, bucket_type, bucket_id) ->
    jQuery.ajax
      url: @bucketings_path
      method: "POST"
      data:
        resource_type: resource_type
        resource_id: resource_id
        bucket_type: bucket_type
        bucket_id: bucket_id
      success: (res) =>
        console.log "add to bucket success"
        console.log res
        if res['result']
          console.log res.result
          @$progress.add_to_bucket_success(res.result)
        else
          @$progress.error(res.error)

  remove_from_bucket: (resource_type, resource_id, bucket_type, bucket_id) ->
    jQuery.ajax
      url: @bucketings_path
      method: "DELETE"
      data:
        resource_type: resource_type
        resource_id: resource_id
        bucket_type: bucket_type
        bucket_id: bucket_id
      success: (res) =>
        console.log "add to bucket success"
        console.log res
        if res['result']
          console.log res.result
          @$progress.remove_from_bucket_success(res.result)
        else
          @$progress.error(res.error)

###
  用于处理MindpinBuckets回调的类
  里面规定了一些方法，可以根据传输的不同结果，做不同的处理
###
###
  获取buckets            成功、失败
  创建bucket             成功、失败
  将resource添加到bucket 成功、失败
  将resource从bucket删除 成功、失败

  失败均为500，结构也一样，可以统一
###
class @MindpinBucketsProgress
  constructor: (@mindpin_buckets) ->
    #console.log 'MindpinBucketsProgress'
    #console.log @mindpin_buckets

  get_buckets_success: (buckets) ->
    console.log 'get_buckets_success'
    console.log buckets

  create_bucket_success: (bucket) ->
    console.log 'create_bucket_success'
    console.log bucket

  add_to_bucket_success: (bucket) ->
    console.log 'add_to_bucket_success'
    console.log bucket

  remove_from_bucket_success: (bucket) ->
    console.log 'remove_from_bucket_success'
    console.log bucket

  error: (error) ->
    console.log 'error'
    console.log error

# example 
#class @CustomProgress extends MindpinBucketsProgress
  #constructor: ()->

  #get_buckets_success: (buckets) ->
    #alert(buckets)
#
#buckets = new MindpinBuckets("",new CustomProgress())
#buckets.buckets("folder")
