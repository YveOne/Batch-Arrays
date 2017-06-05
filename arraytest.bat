@echo off & setlocal
::---------------------------------------------------


set "ii=1"
set "k=16"
::---------------------------------------------------
:testMenu
::---------------------------------------------------
CLS
echo. 1: create, push and clear
echo. 2: access values directly
echo. 3: get and set
echo. 4: fill and loop
echo. 5: set out of bounds
echo. 6: reverse
echo. 7: sorting
echo. 8: shrinking
echo. 9: unique
echo. 10: random value
echo. 11: shuffle array
echo. 12: product and sum
echo. 13: pop, unshift, shift
echo. 14: pop, unshift, shift extended
echo. 15: merging
echo. 16: contains
echo. 0: exit
set "jj="
set /p "jj=select:"
if "%jj%" == "" set "jj=%ii%"
set /a "jj=%jj%+0"
set /a "ii=%jj%+1"
CLS
if %jj% LSS  0  goto:testMenu
if %jj% GTR %k% goto:testMenu
if %jj% EQU  0  goto:testExit
goto:test%jj%


::---------------------------------------------------
:test1
::---------------------------------------------------

:: lets create a new array
call:array.new myArray

:: and add some values
call:array.push myArray "my"
call:array.push myArray "name"
call:array.push myArray "is"
call:array.push myArray "agita"
    :: thats the same as
    ::set "myArray[0]=my"
    ::set "myArray[1]=name"
    ::set "myArray[2]=is"
    ::set "myArray[3]=agita"
    ::set "myArray=4"

:: output
echo.%myArray[0]% %myArray[1]% %myArray[2]% %myArray[3]% (size: %myArray%)

:: lets clear the array
call:array.clear myArray

:: and now its empty
echo.%myArray[0]% %myArray[1]% %myArray[2]% %myArray[3]% (size: %myArray%)

pause
call:array.unset myArray
goto:testMenu


::---------------------------------------------------
:test2
::---------------------------------------------------

call:array.new myArray
call:array.push myArray "my"
call:array.push myArray "name"
call:array.push myArray "is"
call:array.push myArray "agita"

set "i=3"
call echo.%%myArray[%i%]%%

call set "a=%%myArray[%i%]%%"
echo.%a%

call set "myArray[%i%]=yvonne"
call set "a=myArray[%i%]"
call echo.%%%a%%%

pause
call:array.unset myArray
goto:testMenu


::---------------------------------------------------
:test3
::---------------------------------------------------

call:array.new myArray
call:array.push myArray "my"
call:array.push myArray "name"
call:array.push myArray "is"
call:array.push myArray "agita"

call:array.get myArray 3 myName
echo.%myName%

call:array.set myArray 3 Yvonne
call:array.get myArray 3 myName
echo.%myName%

pause
call:array.unset myArray
goto:testMenu


::---------------------------------------------------
:test4
::---------------------------------------------------

call:array.new days
call:array.push days "monday"
call:array.push days "tuesday"
call:array.push days "wednesday"
call:array.push days "thursday"
call:array.push days "friday"
call:array.push days "saturday"
call:array.push days "sunday"
call:array.fill days 2 2 null
call:array.fill days 8 2 null
call:array.loop days testLoopEcho
echo.length: %days%

pause
call:array.unset days
goto:testMenu


::---------------------------------------------------
:test5
::---------------------------------------------------

call:array.new arr
call:array.push arr "a"
call:array.push arr "b"
call:array.push arr "c"
call:array.set arr 5 f
call:array.loop arr testLoopEcho
echo.length: %arr%

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test6
::---------------------------------------------------

call:array.new arr

call:array.push arr 1
call:array.push arr 2
call:array.push arr 3
call:array.push arr 4
call:array.push arr 5
::1,2,3,4,5

call:array.reverse arr
::5,4,3,2,1

call:array.push arr 0
::5,4,3,2,1,0

call:array.reverse arr
::0,1,2,3,4,5

call:array.push arr 6
::0,1,2,3,4,5,6

call:array.reverse arr
::6,5,4,3,2,1,0

call:array.loop arr testLoopEcho

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test7
::---------------------------------------------------

call:array.new arr
call:array.push arr ""
call:array.push arr aab
call:array.push arr 002
call:array.push arr 001
call:array.push arr aac
call:array.push arr aaa
call:array.push arr ""
call:array.push arr ""
call:array.push arr caa
call:array.push arr baa
call:array.push arr 013
call:array.push arr 011

echo.length: %arr%
call:array.sort arr
call:array.loop arr testLoopEcho
echo.length: %arr%

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test8
::---------------------------------------------------

call:array.new arr
call:array.push arr ""
call:array.push arr ""
call:array.push arr "hello"
call:array.push arr ""
call:array.push arr ""
call:array.push arr "world"
call:array.push arr ""

echo.length: %arr%
call:array.shrink arr
call:array.loop arr testLoopEcho
echo.length: %arr%

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test9
::---------------------------------------------------

call:array.new arr
call:array.push arr "a"
call:array.push arr "b"
call:array.push arr "c"
call:array.push arr "b"
call:array.push arr "a"
call:array.push arr "d"
call:array.push arr "c"
call:array.push arr "d"

echo.length: %arr%
call:array.unique arr
call:array.loop arr testLoopEcho
echo.length: %arr%

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test10
::---------------------------------------------------

call:array.new arr
call:array.push arr "11"
call:array.push arr "12"
call:array.push arr "13"
call:array.push arr "14"
call:array.push arr "15"
call:array.push arr "16"
call:array.push arr "17"
call:array.push arr "18"
call:array.push arr "19"
call:array.push arr "20"
call:array.push arr "21"
call:array.push arr "22"

call:array.random arr value
echo.random value: %value%
call:array.random arr value
echo.random value: %value%
call:array.random arr value
echo.random value: %value%
call:array.random arr value
echo.random value: %value%

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test11
::---------------------------------------------------

call:array.new arr
call:array.push arr "a"
call:array.push arr "b"
call:array.push arr "c"
call:array.push arr "d"
call:array.push arr "e"
call:array.push arr "f"

call:array.shuffle arr
call:array.loop arr testLoopEcho

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test12
::---------------------------------------------------

call:array.new arr
call:array.push arr "1"
call:array.push arr "2"
call:array.push arr "3"
call:array.push arr "4"

call:array.product arr val
echo.1*2*3*4=%val%

call:array.sum arr val
echo.1+2+3+4=%val%

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test13
::---------------------------------------------------

call:array.new arr
call:array.push arr "aaa"
call:array.push arr "bbb"
call:array.push arr "ccc"
call:array.push arr "ddd"

echo.---
call:array.loop arr testLoopEcho
echo.---

echo.length: %arr%
call:array.pop arr val
echo.pop: %val%
echo.length: %arr%

echo.---
call:array.loop arr testLoopEcho
echo.---

echo.length: %arr%
call:array.unshift arr %val%
echo.length: %arr%

echo.---
call:array.loop arr testLoopEcho
echo.---

echo.length: %arr%
call:array.shift arr val
echo.shift: %val%
echo.length: %arr%

echo.---
call:array.loop arr testLoopEcho
echo.---

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test14
::---------------------------------------------------

call:array.new arr
call:array.push arr "bbb"
call:array.push arr "aaa"
call:array.push arr "eee"
call:array.push arr "ccc"
call:array.push arr "ddd"

echo.---
call:array.loop arr testLoopEcho
echo.---

::extract eee
call:array.shift arr val 2
::push eee
call:array.push arr %val%
::extract bbb
call:array.shift arr val 0
::insert bbb
call:array.unshift arr %val% 1

echo.---
call:array.loop arr testLoopEcho
echo.---
echo.length: %arr%

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:test15
::---------------------------------------------------

call:array.new arr1
call:array.push arr1 "abc"
call:array.push arr1 "def"
call:array.push arr1 "ghi"

call:array.new arr2
call:array.push arr2 "jkl"
call:array.push arr2 "mno"

call:array.new arr3
call:array.push arr3 "pqr"
call:array.push arr3 "stu"
call:array.push arr3 "vwx"
call:array.push arr3 "yz"

call:array.merge arr1 arr2
call:array.merge arr1 arr3

echo.---
call:array.loop arr1 testLoopEcho
echo.---

pause
call:array.unset arr1
call:array.unset arr2
call:array.unset arr3
goto:testMenu


::---------------------------------------------------
:test16
::---------------------------------------------------

call:array.new arr
call:array.push arr "abc"
call:array.push arr "def"
call:array.push arr "ghi"

call:array.contains arr abc ret
echo.contains 'abc': %ret%

set def=def
call:array.contains arr %def% ret
echo.contains '%def%': %ret%

call:array.contains arr lol ret
echo.contains 'lol': %ret%

pause
call:array.unset arr
goto:testMenu


::---------------------------------------------------
:testExit
pause
EXIT /B %ERRORLEVEL%
::---------------------------------------------------

    :testLoopEcho
        echo.%~1
        goto:eof


::---------------------------------------------------
:: Pseudo array functions
:: Yvonne Pautz (c) 2016
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
