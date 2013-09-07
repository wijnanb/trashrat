window.Cache = (->
    readFromLocalStorage = (id) ->
        try
            value = localStorage[id]
            unless value?
                return false
            return value
        catch error
            console.warn "localStorage not available", error
            return false

    storeInLocalStorage = (id, data)->
        try
            localStorage.setItem id, data
        catch error
            console.warn "localStorage not available", error

    generateHash = (input) ->
        hash = 0
        if input.length is 0 then return hash
        for i in [0..input.length-1]
            char = input.charCodeAt(i)
            hash = ((hash<<5)-hash)+char
            hash = hash & hash # Convert to 32bit integer
        return hash + 2147483647 #always positive

    clear = ->
        for key, value of localStorage
            isCache = (key.match /^cache-/i)?
            if isCache then localStorage.removeItem key
        try
            localStorage.removeItem "last_position"
        catch error
            console.warn "localStorage not available", error

    # public functions
    public_functions =
        storeInLocalStorage: storeInLocalStorage
        readFromLocalStorage: readFromLocalStorage
        clear: clear
)()