
#program to return all the directories in a directory
mkdir -p /var/tmp/temp_project_find
if [[ -d /var/tmp/temp ]]; then
	rm /var/tmp/temp_project_find/direct*.txt		2> /dev/null
	rm /var/tmp/regular_files*.txt	2> /dev/null
	rm /var/temp/temp_project_find/symbolic_links.txt  	2> /dev/null
	 #mkdir ~/temp_project_find/	
else
	mkdir ~/temp_project_find/
fi	
echo "Temporary folder created! proceeding with further execution"

# Funtion
depth=0
prev_directory=$pwd
cd "$1"
depth=$((depth+1))
(( count$depth = 0))

directory_list () {
	curr_directory=$(pwd)           # returns current directory, to further check
	if [ -f /var/tmp/temp_project_find/directory_$depth.txt ]; then
		rm /var/tmp/temp_project_find/directory_$depth.txt
	fi
	((count$depth=0))
	for i in * ; do
			if [[ -L "$i" ]] ; then
			echo "$curr_directory/$i" >> /var/tmp/temp_project_find/symbolic_links.txt		
			elif [[ -d "$i" ]] ; then
			echo "$curr_directory/$i" >> /var/tmp/temp_project_find/directory_$depth.txt
			((count$depth= $((count$depth + 1)) )) 		
		elif [[ -f "$i" ]]; then
			echo $curr_directory/"$i" >> /var/tmp/temp_project_find/regular_files.txt
		fi
	done
	echo "Function completed"
 	return 
 	}
#Test: required to test if variables are working as expected
#echo $depth                  
#echo $((count$depth))

directory_list 
echo "depth = $depth , directory :- $curr_directory count = $((count$depth))"
while (( count1 > 0 )); do	
	directory="$(head -1 ~/temp_project_find/directory_$depth.txt)"
	if [ -n "$directory" ]; then
		cd "$directory"
		depth=$(( depth + 1 ))
		directory_list	
	echo "depth = $depth , directory :- $curr_directory count = $((count$depth))"
	fi
	if (( count$depth == 0 )); then
		echo "traversing back $directory done"		# Testing...!!!
		cd ..
		depth=$(( depth - 1 ))
		(( count$depth =  $((count$depth - 1)) )) 
		echo "$(tail -n +2 ~/temp_project_find/directory_$depth.txt)" > /var/tmp/temp_project_find/directory_$depth.txt
	fi
done

