#!/bin/bash

function ones {
    local param=$1
    case $param in
        1) echo "One" ;;
        2) echo "Two" ;;
        3) echo "Three" ;;
        4) echo "Four" ;;
        5) echo "Five" ;;
        6) echo "Six" ;;
        7) echo "Seven" ;;
        8) echo "Eight" ;;
        9) echo "Nine" ;;
    esac
}

function belowTwenty {
    local param=$1
    case $param in
        10) echo "Ten" ;;
        11) echo "Eleven" ;;
        12) echo "Twelve" ;;
        13) echo "Thirteen" ;;
        14) echo "Fourteen" ;;
        15) echo "Fifteen" ;;
        16) echo "Sixteen" ;;
        17) echo "Seventeen" ;;
        18) echo "Eighteen" ;;
        19) echo "Nineteen" ;;
    esac
}

function tens {
    local param=$1
    case $param in
        20) echo "Twenty" ;;
        30) echo "Thirty" ;;
        40) echo "Fourty" ;;
        50) echo "Fifty" ;;
        60) echo "Sixty" ;;
        70) echo "Seventy" ;;
        80) echo "Eighty" ;;
        90) echo "Ninety" ;;
    esac
}


function two_digit {
    local param=$1
    if(($param < 10))
    then
        local ret=$(ones $param)
        echo "$ret"
    elif(($param < 20))
    then
        local ret=$(belowTwenty $param)
        echo "$ret"
    elif((param%10 == 0))
    then
        local ret=$(tens $param)
        echo "$ret"
    else
        ((val1=$param/10*10))
        ((val2=$param%10))
        local ret1=$(tens $val1)
        local ret2=$(ones $val2)
        echo "$ret1 $ret2"
    fi
}

function three_digit {
    local param=$1
    if(($param/100 == 0))
    then
        local ret=$(two_digit $param)
        echo "$ret"
    elif(($param%100 == 0))
    then
        ((val3=$param/100))
        local ret=$(ones $val3)
        echo "$ret Hundred"
    else
        ((val4=$param/100))
        ((val5=$param%100))
        local ret1=$(ones $val4)
        local ret2=$(two_digit $val5)
        echo "$ret1 Hundred $ret2"
    fi
}


function numToWord {
    local param=$1
    if(($param == 0))
    then
        echo "Zero"
    else
        local word=''
        ((billions=$param/1000000000))
        ((tmp1=$billions*1000000000))
        ((param-=$tmp1))

        ((millions=$param/1000000))
        ((tmp2=$millions*1000000))
        ((param-=$tmp2))

        ((thousands=$param/1000))
        ((tmp3=$thousands*1000))
        ((param-=$tmp3))

        if(($billions > 0))
        then
            local num1=$(three_digit $billions)
            word="$word $num1 Billion "
        fi

        if(($millions > 0))
        then
            local num2=$(three_digit $millions)
            word="$word $num2 Million "
        fi

        if(($thousands > 0))
        then
            local num3=$(three_digit $thousands)
            word="$word $num3 Thousand "
        fi

        if(($param > 0))
        then
            local num4=$(three_digit $param)
            word="$word $num4"
        fi

        echo "$word"
    fi
}

read -p "Enter Non-negative Number To Be Converted into English Word: " num
ans=$(numToWord $num)
echo $ans
