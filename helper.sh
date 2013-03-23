#function gettop
#{
#    local TOPFILE=build/core/envsetup.mk
#    if [ -n "$TOP" -a -f "$TOP/$TOPFILE" ] ; then
#        echo $TOP
#    else
#        if [ -f $TOPFILE ] ; then
#            # The following circumlocution (repeated below as well) ensures
#            # that we record the true directory name and not one that is
#            # faked up with symlink names.
#            PWD= /bin/pwd
#        else
#            # We redirect cd to /dev/null in case it's aliased to
#            # a command that prints something as a side-effect
#            # (like pushd)
#            local HERE=$PWD
#            T=
#            while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
#                cd .. > /dev/null
#                T=`PWD= /bin/pwd`
#            done
#            cd $HERE > /dev/null
#            if [ -f "$T/$TOPFILE" ]; then
#                echo $T
#            fi
#        fi
#    fi
#}


function jsgrep()
{
    find . -type f -name "*\.js" -print0 | xargs -0 grep --color -n "$@"
}

function jgrep()
{
    find . -type f -name "*\.java" -print0 | xargs -0 grep --color -n "$@"
}

function cgrep()
{
    find . -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \) -print0 | xargs -0 grep --color -n "$@"
}

function hgrep()
{
    find . -type f \( -name '*.h' -o -name '*.hpp' \) -print0 | xargs -0 grep --color -n "$@"
}

function godir () {
    if [[ -z "$1" ]]; then
        echo "Usage: godir <regex>"
        return
    fi
    T=`pwd`
    if [[ ! -f $T/filelist ]]; then
        echo -n "Creating index..."
        (cd $T; find . -type f |grep -v ".svn" > filelist)
        echo " Done"
        echo ""
    fi
    local lines
    lines=($(grep "$1" $T/filelist | sed -e 's/\/[^/]*$//' | sort | uniq))
    if [[ ${#lines[@]} = 0 ]]; then
        echo "Not found"
        return
    fi
    local pathname
    local choice
    if [[ ${#lines[@]} > 1 ]]; then
        while [[ -z "$pathname" ]]; do
            local index=1
            local line
            for line in ${lines[@]}; do
                printf "%6s %s\n" "[$index]" $line
                index=$(($index + 1))
            done
            echo
            echo -n "Select one: "
            unset choice
            read choice
            if [[ $choice -gt ${#lines[@]} || $choice -lt 1 ]]; then
                echo "Invalid choice"
                continue
            fi
            pathname=${lines[$(($choice-$_arrayoffset))]}
        done
    else
        # even though zsh arrays are 1-based, $foo[0] is an alias for $foo[1]
        pathname=${lines[0]}
    fi
    cd $T/$pathname
}

function gofile () {
    if [[ -z "$1" ]]; then
        echo "Usage: gofile <regex>"
        return
    fi
    T=`pwd`
    if [[ ! -f $T/filelist ]]; then
        echo -n "Creating index..."
        (cd $T; find . -type f |grep -v ".svn" > filelist)
        echo " Done"
        echo ""
    fi
    local lines
#lines=($(grep "$1" $T/filelist | sed -e 's/\/[^/]*$//' | sort | uniq))
    lines=($(grep "$1" $T/filelist | sort | uniq))
    if [[ ${#lines[@]} = 0 ]]; then
        echo "Not found"
        return
    fi
    local pathname
    local choice
    if [[ ${#lines[@]} > 1 ]]; then
        while [[ -z "$pathname" ]]; do
            local index=1
            local line
            for line in ${lines[@]}; do
                printf "%6s %s\n" "[$index]" $line
                index=$(($index + 1))
            done
            echo
            echo -n "Select one: "
            unset choice
            read choice
            if [[ $choice -gt ${#lines[@]} || $choice -lt 1 ]]; then
                echo "Invalid choice"
                continue
            fi
            pathname=${lines[$(($choice-$_arrayoffset))]}
        done
    else
        # even though zsh arrays are 1-based, $foo[0] is an alias for $foo[1]
        pathname=${lines[0]}
    fi
    vim $T/$pathname
}




