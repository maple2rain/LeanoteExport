#!/bin/bash
#This is for export markdown and modify its name of leanote

_work_dir=/opt/Leanote4MD
_tmp_dir=/opt/Leanote4MD/tmp
_date=`date +%Y-%m-%d`
_date_dir=${_work_dir}/${_date}
_img_dir=../post_img
logfile=${_date}.log

mkdir -p ${_date_dir}
mkdir -p ${_img_dir}

# execute leanote export py
python2 Leanote4MD.py export

# below deal for jekyll

ls *.md | while read file; do
    old_file_name=${file}
    new_file_name=`echo ${old_file_name} | tr -d ' '`
    mv "${old_file_name}" "${new_file_name}"
done

files=`\ls *.md`

# modify date format's separator from '/' to '-'
for file in $files; do
    echo $file >> $logfile
    sed '1,3s/\//-/g' "$file" -i
done

# cut date field
for file in $files; do
    file_suffix=$file
    time=`head -n 2 "$file" | tail -n 1| cut -f 2 -d ' '`
    name=$time"-"$file_suffix
    echo "name is" $name >> $logfile
    mv $file $name
done

# remove suffix of .PNG
pngs=`\ls *.PNG`
for file in $pngs; do
    name=$(basename $file .PNG)
    echo "name is" $name >> $logfile
    mv $file $name
    mv $name ${_img_dir}/
done

# remove suffix of .GIF
gifs=`\ls *.GIF`
for file in $gifs; do
    name=$(basename $file .GIF)
    echo "name is" $name >> $logfile
    mv $file $name
    mv $name ${_img_dir}/
done


# modify picture link
files=`\ls *.md`
for file in $files; do
    echo $file >> $logfile
    sed 's/https:\/\/leanote.com\/api\/file\/getImage?fileId=/..\/post_img\//g' "$file" -i
done

# move files
mv ${_tmp_dir}/* ${_date_dir}

# remove script and logfile
mv ${_date_dir}/*.sh ${_date_dir}/Leanote* ${_date_dir}/*.log ${_tmp_dir}/
