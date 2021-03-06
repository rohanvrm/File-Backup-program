#program to return all the directories in a directory
list-directory () {

if [ ! -n "$1" ] && [ ! -d "$1" ]; then
	echo "usage: list-directory directory" >&2
	return 1;
fi

local temp_folder

temp_folder="/var/tmp/temp_project_find"

mkdir -p "$temp_folder"
if [[ -d "$temp_folder" ]]; then
	rm "$temp_folder/direct*.txt"		2> /dev/null
	rm "$temp_folder/regular_files*.txt"	2> /dev/null
	rm "$temp_folder/symbolic_links.txt"  	2> /dev/null
	 #mkdir ~/temp_project_find/	
else
	echo "Error creating temporary folder needed, quitting now"
	exit
fi	

echo "Temporary folder created! proceeding with further execution"

# Funtion
local depth=0

depth=0
cd "$1"
depth=$((depth+1))
(( count$depth = 0))

directory_list () {
	curr_directory=$(pwd)           # returns current directory, to further check
	if [ -f "$temp_folder/directory_$depth.txt" ]; then
		rm "$temp_folder/directory_$depth.txt"
	fi
	((count$depth=0))
	for i in * ; do
			if [[ -L "$i" ]] ; then
			echo "$curr_directory/$i" >> "$temp_folder/symbolic_links.txt"		
			elif [[ -d "$i" ]] ; then
			echo "$curr_directory/$i" >> "$temp_folder/directory_$depth.txt"
			((count$depth= $((count$depth + 1)) )) 		
		elif [[ -f "$i" ]]; then
			echo "File $i"
			echo "$curr_directory/$i" >> "$temp_folder/regular_files.txt"
		fi
	done
	# echo "Function completed"
 	return 
 	}
	
directory_list

echo "Scanning $curr_directory"

while (( count1 > 0 )); do	
	directory="$(head -1 $temp_folder/directory_$depth.txt)"
	if [ -n "$directory" ]; then
		cd "$directory"
		depth=$(( depth + 1 ))
		directory_list	
	echo "Scanning $curr_directory"
	fi
	if (( count$depth == 0 )); then
		cd ..
		depth=$(( depth - 1 ))
		(( count$depth =  $((count$depth - 1)) )) 
		echo "$(tail -n +2 $temp_folder/directory_$depth.txt)" > $temp_folder/directory_$depth.txt
	fi
done
echo "Directory scan completed"
printf "List stored in %s\n" $temp_folder
}
