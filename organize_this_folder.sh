#!/bin/bash

mkdir -p organized/{image,doc,sheet,media,archive,other}

for file in *; do
    if [[ -f "$file" ]]; then
        case "${file##*.}" in
            jpeg|png|gif|jpg|bmp|psd|webp)
                dest=organized/image
                ;;
            pdf|docx|doc|txt)
                dest=organized/doc
                ;;
            xls|xlsx|csv|numbers)
                dest=organized/sheet
                ;;
            mp3|mp4|m3u|m3u8|ts)
                dest=organized/media
                ;;
            zip|rar|7z|dmg)
                dest=organized/archive
                ;;
            *)
                dest=organized/other
                ;;
        esac

        base=$(basename "$file")
        ext="${base##*.}"
        base="${base%.*}"
        dest_file="$dest/$base.$ext"

        if [[ -e "$dest_file" ]]; then
            i=1
            while [[ -e "$dest/$base-$i.$ext" ]]; do
                let i++
            done
            dest_file="$dest/$base-$i.$ext"
        fi

        mv "$file" "$dest_file"
    fi
done