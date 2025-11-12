#!/bin/bash -eu

# Photo converter:
# - resize to TV display size
# - add background to get 16:9 aspect
# - strip EXIF data

TARGET_SIZE="3840x2160"

# convert image file to TV format
convert_file() {
  local src_file=$1
  local dst_file=$2
  local dir_name=${src_file%/*}
  dir_name=${dir_name##*/}

  magick "${src_file}" \
    -auto-orient -resize "${TARGET_SIZE%x*}" -gravity Center \
    -crop "${TARGET_SIZE}+0+0" -blur 0x40 \
    -gravity Center "${src_file}" -auto-orient -resize "${TARGET_SIZE}" -composite \
    -quality 80% -strip \
    "${dst_file}"
}

# convert photos for TV
convert_dir() {
  local src_dir=$1
  local dst_dir=$2

  local files
  readarray -d '' files < <(cd "${src_dir}" && find -L . -name '*.jpg' -printf '%P\0' | sort -z)

  local index=1
  local file
  for file in "${files[@]}"; do
    local dir="$(dirname "${file}")"
    local name="${file##*/}"
    echo -n "Convert ${index} of ${#files[@]}: ${file}..."
    mkdir -p "${dst_dir}/${dir}"
    convert_file "${src_dir}/${file}" "${dst_dir}/${dir}/${name}"
    echo "OK"
    index=$((index + 1))
  done
}

# entry point
if [[ $# -lt 2 || $1 == --help ]]; then
  echo "Use: $0 SRCDIR DSTDIR"
  exit 1
fi
convert_dir "$1" "$2"
