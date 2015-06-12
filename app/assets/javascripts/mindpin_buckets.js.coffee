class @MindpinBuckets
  constructor: (@$path_fix)->
    @_init()

  _init: ->
    if !@$path_fix
      @$path_fix = ""
    @buckets_path = @$path_fix + "/buckets"
    @bucketings_path = @$path_fix + "/bucketings"

  buckets: (bucket_type) ->
    jQuery.ajax
      url: "#{@buckets_path}?type=#{bucket_type}"
      method: "GET"
      success: (res) =>
        console.log "buckets success"
        console.log res
        if res['result']
          console.log res.result

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
