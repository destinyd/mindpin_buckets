class @MindpinHook
  constructor: (@$fm) ->
    console.log 'mindpin hook constructor'

  el_click: (el) ->
    console.log 'mindpin hook el click'

  buckets_success: (buckets) =>
    console.log 'mindpin hook buckets success'

  create_bucket_success: (bucket) =>
    console.log 'mindpin hook create bucket success'

  add_to_bucket_success: (bucket) =>
    console.log 'mindpin hook add to bucket success'

  remove_from_bucket_success: (bucket) ->
    console.log 'mindpin hook remove_from_bucket_success'

  error: (error) ->
    console.log 'error'
    console.log error

class @MindpinBuckets
  constructor: (@$configs)->
    @_init()

  _default_configs:
    path_fix: ""
    selector: "[data-rel=mindpin_buckets]"
    bucket_type: "Bucket"
    hook_class: MindpinHook

  _init: ->
    for key, val of @_default_configs
      @$configs[key] ||= val

    @path_fix = @$configs["path_fix"]
    @buckets_path = @path_fix + "/buckets"
    @bucketings_path = @path_fix + "/bucketings"

    @$el = jQuery(@$configs["selector"])

    @resource_type = @$el.data('resource-type')
    @resource_id = @$el.data('resource-id')
    @bucket_type = @$configs["bucket_type"]
    @hook = new @$configs["hook_class"](@)
    @_init_buckets()
    @_bind()

  _bind: () ->
    console.log '_bind'
    # 添加按钮点击
    that = @
    @$el.click () -> 
      console.log 'el click'
      that.hook.el_click(@)

  _init_buckets: () ->
    console.log '_init_buckets'
    @buckets(@bucket_type, @resource_type, @resource_id)

  _create_bucket: (bucket_type, name, desc) ->
    jQuery.ajax
      url: @buckets_path
      method: "POST"
      data: 
        bucket_type: bucket_type
        name: name
        desc: desc
      success: (res) =>
        console.log "create bucket success"
        console.log res
        if res['result']
          console.log res.result
          @hook.create_bucket_success(res.result)
        else
          @hook.error(res.error)

  _add_to_bucket: (resource_type, resource_id, bucket_type, bucket_id) ->
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
          @hook.add_to_bucket_success(res.result)
        else
          @hook.error(res.error)

  _remove_from_bucket: (resource_type, resource_id, bucket_type, bucket_id) ->
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
          @hook.remove_from_bucket_success(res.result)
        else
          @hook.error(res.error)

  buckets: (bucket_type, resource_type, resource_id) ->
    jQuery.ajax
      url: "#{@buckets_path}?bucket_type=#{bucket_type}&resource_type=#{resource_type}&resource_id=#{resource_id}"
      method: "GET"
      success: (res) =>
        console.log "buckets success"
        console.log res
        if res['result']
          @hook.buckets_success(res.result)
        else
          @hook.error(res.error)


  remove_from_bucket: (bucket_id) ->
    console.log 'fm remove from bucket'
    @_remove_from_bucket(@resource_type, @resource_id, @bucket_type, bucket_id)

  create_bucket: (bucket_name, bucket_desc) ->
    console.log 'create bucket'
    @_create_bucket(@bucket_type, bucket_name, bucket_desc)

  add_to_bucket: (bucket_id) ->
    console.log 'add to bucket'
    @_add_to_bucket(@resource_type, @resource_id, @bucket_type, bucket_id)
