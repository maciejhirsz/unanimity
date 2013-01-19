unanimity = (backbone, db) ->

  backbone.sync = (method, model, options) ->
    id = null
    id = model.id if model.id isnt undefined
    update = {}

    if method is 'update' or method is 'create' or method is 'patch'
      db.insert model.toJSON(), id, (err, body) ->
        if err
          if typeof options.error is 'funciton'
            options.error(model, err, options)
            return
          else
            throw err

        update['_rev'] = body.rev
        update[model.idAttribute] = body.id if id is null

        options.success(model, update, options)
        model.trigger('sync', model)

    else if method is 'read'
      throw "Can't fetch a model without id!" if id is null

      db.get id, (err, body) ->
        if err
          if typeof options.error is 'funciton'
            options.error(model, err, options)
            return
          else
            throw err

        for key, value of body
          update[key] = value if key isnt '_id' # don't need '_id' since we have model.id

        options.success(model, update, options)

    else if method is 'delete'
      rev = model.get('_rev')
      throw "Can't destroy a model without id!" if id is null
      throw "Can't destroy a new model!" if typeof rev isnt 'string'

      db.destroy id, rev, (err, body) ->
        if err
          if typeof options.error is 'funciton'
            options.error(model, err, options)
            return
          else
            throw err

        options.success(model, update, options)

    return model

  # --------------------------------

  backbone.sync.db = db

# ==================================

module.exports = unanimity