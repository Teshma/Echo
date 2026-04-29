Debug = {}

function Debug.Log(message, tracebacks)
    if (tracebacks) then
        print(debug.traceback(message, 2))
    else
        print(message)
    end
end