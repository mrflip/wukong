

track provenance and success of records -- 'discard' to not emit (so you can do guarantees)

    read record a from IN
    do while read has not reached end of file
        if c is true
            write a to OUT
        else
            discard a
        endif
        read record a from IN
    enddo
