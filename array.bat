
::---------------------------------------------------
:: Pseudo array functions
:: Yvonne P. (c) 2016
:: agita[at]live[dot]de
::
:: function list:
::
:: create new array:
::    call:array.new <arrname>
::    call:array.new arr
::
:: clear array:
::    call:array.clear <arrname>
::    call:array.clear arr
::
:: unset array:
::    call:array.unset <arrname>
::    call:array.unset arr
::
:: getter:
::    call:array.get <arrname> <index> <return>
::    call:array.get arr 0 val
::    call:array.get arr 123 val
::    call:array.get arr %i% val
::    echo.%val%
::
:: setter:
::    call:array.set <arrname> <index> <value>
::    call:array.set arr 123 "hello world"
::    call:array.set arr %i% "%val%"
::
:: push (insert value at end):
::    call:array.push <arrname> <value>
::    call:array.push arr "hello world"
::    call:array.push arr "%var%"
::
:: pop (remove value at end):
::    call:array.pop <arrname> <return>
::    call:array.pop arr value
::    echo.removed: %value%
::
:: shift (remove value at start[+offset]):
::    call:array.shift <arrname> <return> <[offset]>
::    call:array.shift arr value1
::    call:array.shift arr value2 7
::    echo.removed: %value1% (at start)
::    echo.removed: %value2% (at index 7)
::
:: unshift (insert value at start[+offset]):
::    call:array.unshift <arrname> <value> <[offset]>
::    call:array.unshift arr "%var%"
::    call:array.unshift arr "%var%" 7
::    call:array.unshift arr "%var%" %i%
::
:: foreach element (call function):
::    call:array.loop <arrname> <function>
::    call:array.loop arr mycallback
::    :mycallback
::        echo.%~1
::        goto:eof
::
:: filling an array:
::    call:array.fill <arrname> <startindex> <count> <value>
::    call:array.fill arr 1 3 "%val%"
::    call:array.fill arr 1 3 "0"
::
:: reverse order of elements:
::    call:array.reverse <arrname>
::    call:array.reverse arr
::
:: sort elements asc order (resizes):
::    call:array.sort <arrname>
::    call:array.sort arr
::
:: remove empty elements (resizes):
::    call:array.shrink <arrname>
::    call:array.shrink arr
::
:: remove duplicates:
::    call:array.unique <arrname>
::    call:array.unique arr
::
:: get random element:
::    call:array.random <arrname> <value>
::    call:array.random arr value
::    echo.%value%
::
:: shuffle array:
::    call:array.shuffle <arrname>
::    call:array.shuffle arr
::
:: calculate product of elements:
::    call:array.product <arrname> <return>
::    call:array.product arr value
::    echo.%value%
::
:: calculate sum of elements:
::    call:array.sum <arrname> <return>
::    call:array.sum arr value
::    echo.%value%
::
:: merge array2 into array1:
::    call:array.merge <arr1name> <arr2name>
::    call:array.merge arr1 arr2
::
:: find element:
::    call:array.contains <arrname> <value> <return>
::    call:array.contains arr "hello" isset
::    if defined isset echo.array contains value
::
:: accessing directly (advanced):
::    set "arr[2]=hello world"
::    set value=%arr[2]%
::
:: array length:
::    echo.array length: %arr%
::
:: errorcodes:
::    0: no error
::    1: array doesnt/already exist
::    2: index out of bounds
::
::---------------------------------------------------
    :array.new
        setlocal
        set "array=%~1"
        if defined %array% endlocal & exit /b 1
        endlocal & set "%array%=0"
        EXIT /b
::---------------------------------------------------
    :array.push
        setlocal
        set "array=%~1"
        set "value=%~2"
        if not defined %array% endlocal & exit /b 1
        call set "vPointer=%array%[%%%array%%%]"
        endlocal & call set /A %array%=%%%array%%%+1 & set "%vPointer%=%value%"
        EXIT /b
::---------------------------------------------------
    :array.clear
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        endlocal & set "%array%=0" & FOR /L %%i IN (0,1,%arrayLastIndex%) DO set "%array%[%%i]="
        EXIT /b
::---------------------------------------------------
    :array.unset
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        endlocal & set "%array%=" & FOR /L %%i IN (0,1,%arrayLastIndex%) DO set "%array%[%%i]="
        EXIT /b
::---------------------------------------------------
    :array.get
        setlocal
        set "array=%~1"
        set "index=%~2"
        call set "length=%%%array%%%"
        if not defined %array% endlocal & exit /b 1
        if %index% LSS 0 endlocal & exit /b 2
        if %index% GEQ %length% endlocal & exit /b 2
        set "vPointer=%array%[%index%]"
        endlocal & call set "%~3=%%%vPointer%%%"
        EXIT /b
::---------------------------------------------------
    :array.set
        setlocal
        set "array=%~1"
        set "index=%~2"
        set "value=%~3"
        call set "length=%%%array%%%"
        if not defined %array% endlocal & exit /b 1
        if %index% LSS 0 endlocal & exit /b 2
        call set "newLength=%%%array%%%"
        if %index% GEQ %newLength% set /a newLength=%index%+1
        set "vPointer=%array%[%index%]"
        endlocal & set "%array%=%newLength%" & set "%vPointer%=%value%"
        EXIT /b
::---------------------------------------------------
    :array.loop
        setlocal
        set "array=%~1"
        set "callb=%~2"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        endlocal & FOR /L %%i IN (0,1,%arrayLastIndex%) DO call:%callb% "%%%array%[%%i]%%"
        EXIT /b
::---------------------------------------------------
    :array.fill
        setlocal
        set "array=%~1"
        set "start=%~2"
        set "count=%~3"
        set "value=%~4"
        if not defined %array% endlocal & exit /b 1
        if %start% LSS 0 endlocal & exit /b 2
        if %count% LSS 0 endlocal & exit /b 2
        if %count% EQU 0 endlocal & exit /b 0
        call set /a arrayLastIndex=%start%+%count%-1
        call set /a newLength=%%%array%%%-1
        if %arrayLastIndex% GTR %newLength% set "newLength=%arrayLastIndex%"
        endlocal & set /a %array%=%newLength%+1 & FOR /L %%i IN (%start%,1,%arrayLastIndex%) DO set "%array%[%%i]=%value%"
        EXIT /b
::---------------------------------------------------
    :array.reverse.swap
        setlocal
        set "array=%~1"
        set "i1=%~2"
        call set /a i2=%%%array%%%-%i1%-1
        call set "v1=%%%array%[%i1%]%%"
        call set "v2=%%%array%[%i2%]%%"
        endlocal & set "%array%[%i1%]=%v2%" & set "%array%[%i2%]=%v1%"
        EXIT /b
    :array.reverse
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%/2-1
        endlocal & FOR /L %%i IN (0,1,%arrayLastIndex%) DO call:array.reverse.swap "%array%" %%i
        EXIT /b
::---------------------------------------------------
    :array.sort
        setlocal
        set array=%~1
        if not defined %array% endlocal & exit /b 1
        call set /a "arrayLastIndex=%%%array%%%-1"
        :: for this function we need a tmp bat file
        set TMPFILE=%TMP%\array.sort.%RANDOM%.%TIME:~6,2%.%TIME:~9,2%.bat
        set lastFirstI=0
        set sortedI=0
        :array.sort.mainLoop
            set firstI=%lastFirstI%
            :array.sort.findFirstLoop
                if %firstI% GTR %arrayLastIndex% goto:array.sort.findFirstDone
                call set "tmp=%%%array%[%firstI%]%%"
                if "%tmp%" NEQ "" goto:array.sort.findFirstDone
                set /a firstI=%firstI%+1
                goto:array.sort.findFirstLoop
            :array.sort.findFirstDone
            set "lastFirstI=%firstI%"
            :: no value found.. the original array is empty
            if %firstI% GTR %arrayLastIndex% goto:array.sort.mainDone
            :: lets find the lowest value
            set /a "nextI=%firstI%+1"
            :array.sort.findNextLoop
                if %nextI% GTR %arrayLastIndex% goto:array.sort.findNextDone
                call set "left=%%%array%[%firstI%]%%"
                call set "right=%%%array%[%nextI%]%%"
                if "%right%" NEQ "" if "%left%" GTR "%right%" set firstI=%nextI%
                set /a nextI=%nextI%+1
                goto:array.sort.findNextLoop
            :array.sort.findNextDone
            :: set new value
            call echo.set %array%[%sortedI%]=%%%array%[%firstI%]%%>>%TMPFILE%
            set /a sortedI=%sortedI%+1
            :: delete the value of the original array
            call set "%array%[%firstI%]="
            goto:array.sort.mainLoop
        :array.sort.mainDone
        :: unset all other empty values and set new length
        FOR /L %%i IN (%sortedI%,1,%arrayLastIndex%) DO echo.set "%array%[%%i]=">>%TMPFILE%
        echo.set "%array%=%sortedI%" >> %TMPFILE%
        ::
        endlocal & call %TMPFILE% & del %TMPFILE%
        EXIT /b
::---------------------------------------------------
    :array.shrink
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        :: for this function we need a tmp bat file
        set TMPFILE=%TMP%\array.sort.%RANDOM%.%TIME:~6,2%.%TIME:~9,2%.bat
        set "curIndex=0"
        set "newIndex=0"
        :array.shrink.mainLoop
            if %curIndex% GTR %arrayLastIndex% goto:array.shrink.mainDone
            call set "tmp=%%%array%[%curIndex%]%%"
            if "%tmp%" NEQ "" echo.set %array%[%newIndex%]=%tmp%>>%TMPFILE% & set /a newIndex=%newIndex%+1
            set /a curIndex=%curIndex%+1
            goto:array.shrink.mainLoop
        :array.shrink.mainDone
        :: unset all other empty values and set new length
        FOR /L %%i IN (%newIndex%,1,%arrayLastIndex%) DO echo.set "%array%[%%i]=">>%TMPFILE%
        echo.set "%array%=%newIndex%" >> %TMPFILE%
        ::
        endlocal & call %TMPFILE% & del %TMPFILE%
        EXIT /b
::---------------------------------------------------
    :array.unique
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        :: for this function we need a tmp bat file
        set TMPFILE=%TMP%\array.sort.%RANDOM%.%TIME:~6,2%.%TIME:~9,2%.bat
        set "curIndex=0"
        :array.unique.mainLoop
            if %curIndex% GTR %arrayLastIndex% goto:array.unique.mainDone
            call set "this=%%%array%[%curIndex%]%%"
            if "%this%" EQU "" goto:array.unique.subDone
            set /a tmpIndex=%curIndex%+1
            :array.unique.subLoop
                if %tmpIndex% GTR %arrayLastIndex% goto:array.unique.subDone
                call set "that=%%%array%[%tmpIndex%]%%"
                if "%this%" EQU "%that%" echo.set "%array%[%tmpIndex%]=">>%TMPFILE%
                set /a tmpIndex=%tmpIndex%+1
                goto:array.unique.subLoop
            :array.unique.subDone
            set /a curIndex=%curIndex%+1
            goto:array.unique.mainLoop
        :array.unique.mainDone
        endlocal & call %TMPFILE% & del %TMPFILE%
        EXIT /b
::---------------------------------------------------
    :array.random
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        ::randomize random
        FOR /L %%i IN (0,1,%TIME:~9,2%) DO SET rand=%RANDOM%
        call SET /A rand=%RANDOM% * %%%array%%% / 32768
        endlocal & call set "%~2=%%%array%[%rand%]%%"
        EXIT /b
::---------------------------------------------------
    :array.shuffle
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        :: for this function we need a tmp bat file
        set TMPFILE=%TMP%\array.sort.%RANDOM%.%TIME:~6,2%.%TIME:~9,2%.bat
        ::randomize random
        FOR /L %%i IN (0,1,%TIME:~9,2%) DO SET rand=%RANDOM%
        ::
        set "curIndex=0"
        call set "tmpLength=%%%array%%%"
        :array.shuffle.mainLoop
            if %curIndex% GTR %arrayLastIndex% goto:array.shuffle.mainDone
            SET /A rand=%RANDOM% * %tmpLength% / 32768
            call echo.set %array%[%curIndex%]=%%%array%[%rand%]%%>>%TMPFILE%
            :: shift all next values
            set "shiftI=%rand%"
            :array.shuffle.shiftLoop
                if %shiftI% GTR %arrayLastIndex% goto:array.shuffle.shiftDone
                set /a shiftJ=%shiftI%+1
                call set "%array%[%shiftI%]=%%%array%[%shiftJ%]%%"
                set /a shiftI=%shiftI%+1
                goto:array.shuffle.shiftLoop
            :array.shuffle.shiftDone
            :: shift end
            set /a tmpLength=%tmpLength%-1
            set /a curIndex=%curIndex%+1
            goto:array.shuffle.mainLoop
        :array.shuffle.mainDone
        endlocal & call %TMPFILE% & del %TMPFILE%
        EXIT /b
::---------------------------------------------------
    :array.product
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        set value=1
        set "i=0"
        :array.product.mainLoop
            if %i% GTR %arrayLastIndex% goto:array.product.mainDone
            call set /a "value=%value%*%%%array%[%i%]%%"
            set /a i=%i%+1
            goto:array.product.mainLoop
        :array.product.mainDone
        endlocal & set %~2=%value%
        EXIT /b
::---------------------------------------------------
    :array.sum
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        set value=0
        set "i=0"
        :array.sum.mainLoop
            if %i% GTR %arrayLastIndex% goto:array.sum.mainDone
            call set /a "value=%value%+%%%array%[%i%]%%"
            set /a i=%i%+1
            goto:array.sum.mainLoop
        :array.sum.mainDone
        endlocal & set %~2=%value%
        EXIT /b
::---------------------------------------------------
    :array.pop
        setlocal
        set "array=%~1"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        endlocal & call set "%~2=%%%array%[%arrayLastIndex%]%%" & set "%array%[%arrayLastIndex%]=" & call set /a %array%=%%%array%%%-1
        EXIT /b
::---------------------------------------------------
    :array.unshift
        setlocal
        set "array=%~1"
        set "value=%~2"
        set "index=%~3"
        if not defined %array% endlocal & exit /b 1
        if "%index%" EQU "" set index=0
        call set /a arrayLastIndex=%%%array%%%-1
        :: for this function we need a tmp bat file
        set TMPFILE=%TMP%\array.sort.%RANDOM%.%TIME:~6,2%.%TIME:~9,2%.bat
        set "i=%index%"
        echo.set %array%[%i%]=%value%>>%TMPFILE%
        :array.unshift.mainLoop
            if %i% GTR %arrayLastIndex% goto:array.unshift.mainDone
            set /a j=%i%+1
            call echo.set %array%[%j%]=%%%array%[%i%]%%>>%TMPFILE%
            set /a i=%i%+1
            goto:array.unshift.mainLoop
        :array.unshift.mainDone
        call echo.set /a %array%=%%%array%%%+1>>%TMPFILE%
        endlocal & call %TMPFILE% & del %TMPFILE%
        EXIT /b
::---------------------------------------------------
    :array.shift
        setlocal
        set "array=%~1"
        set "index=%~3"
        if not defined %array% endlocal & exit /b 1
        if "%index%" EQU "" set index=0
        call set /a arrayLastIndex=%%%array%%%-1
        :: for this function we need a tmp bat file
        set TMPFILE=%TMP%\array.sort.%RANDOM%.%TIME:~6,2%.%TIME:~9,2%.bat
        set "i=%index%"
        call set "value=%%%array%[%i%]%%"
        :array.shift.mainLoop
            if %i% GTR %arrayLastIndex% goto:array.shift.mainDone
            set /a j=%i%+1
            call echo.set %array%[%i%]=%%%array%[%j%]%%>>%TMPFILE%
            set /a i=%i%+1
            goto:array.shift.mainLoop
        :array.shift.mainDone
        call echo.set /a %array%=%%%array%%%-1 >> %TMPFILE%
        endlocal & call %TMPFILE% & del %TMPFILE% & set "%~2=%value%"
        EXIT /b
::---------------------------------------------------
    :array.merge
        setlocal
        set "array1=%~1"
        set "array2=%~2"
        if not defined %array1% endlocal & exit /b 1
        if not defined %array2% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array2%%%-1
        :: for this function we need a tmp bat file
        set TMPFILE=%TMP%\array.sort.%RANDOM%.%TIME:~6,2%.%TIME:~9,2%.bat
        set "i2=0"
        call set "i1=%%%array1%%%"
        :array.merge.mainLoop
            if %i2% GTR %arrayLastIndex% goto:array.merge.mainDone
            call echo.set %array1%[%i1%]=%%%array2%[%i2%]%%>>%TMPFILE%
            set /a i1=%i1%+1
            set /a i2=%i2%+1
            goto:array.merge.mainLoop
        :array.merge.mainDone
        echo.set "%array1%=%i1%" >> %TMPFILE%
        endlocal & call %TMPFILE% & del %TMPFILE%
        EXIT /b
::---------------------------------------------------
    :array.contains
        setlocal
        set "array=%~1"
        set "value=%~2"
        if not defined %array% endlocal & exit /b 1
        call set /a arrayLastIndex=%%%array%%%-1
        set "i=0"
        set "c="
        :array.contains.mainLoop
            if %i% GTR %arrayLastIndex% goto:array.contains.mainDone
            call set tmp=%%%array%[%i%]%%
            if "%tmp%" EQU "%value%" set /a c=%c%+1
            set /a i=%i%+1
            goto:array.contains.mainLoop
        :array.contains.mainDone
        endlocal & set %~3=%c%
        EXIT /b
::---------------------------------------------------
