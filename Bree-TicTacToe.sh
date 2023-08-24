#!/bin/bash


cells=(" " " " " " " " " " " " " " " " " ")


Int_check=()

player=${1}
winner=" "
typeset -i count=0

game_board () {

    echo " "

    echo " ${cells[0]} | ${cells[1]} | ${cells[2]}    "

    echo " ---------"

    echo " ${cells[3]} | ${cells[4]} | ${cells[5]}    "

    echo " ---------"

    echo " ${cells[6]} | ${cells[7]} | ${cells[8]}    "

    echo " "

}

 dashes () {
      for ((i=0; i<${#cells[@]}; i++)) 
      do
        if [[ ${cells[$i]} == " " ]]
        then
          cells[$i]="-"
        fi
      done
  }

check_Winner () {
  if [[ ${cells[0]} == ${player} && ${cells[4]} == ${player} && ${cells[8]} == ${player} ]] || [[ ${cells[2]} == ${player} && ${cells[4]} == ${player} && ${cells[6]} == ${player} ]]
  then
    return 0
  fi

  if [[ ${cells[0]} == ${player} && ${cells[1]} == ${player} && ${cells[2]} == ${player} ]] || [[ ${cells[3]} == ${player} && ${cells[4]} == ${player} && ${cells[5]} == ${player} ]] ||  [[ ${cells[6]} == ${player} && ${cells[7]} == ${player} && ${cells[8]} == ${player} ]]
  then
    return 0
  fi
  
  if [[ ${cells[0]} == ${player} && ${cells[3]} == ${player} && ${cells[6]} == ${player} ]] || [[ ${cells[1]} == ${player} && ${cells[4]} == ${player} && ${cells[7]} == ${player} ]] ||  [[ ${cells[2]} == ${player} && ${cells[5]} == ${player} && ${cells[8]} == ${player} ]]
  then
    return 0
  fi

  return 1

}



if ! [[ ${1} == "X" || ${1} == "O" ]]
then
  echo "Arg 1: must be X or O" > /dev/stderr
  echo " "
  exit 1
fi

if [[ ! -f ${2} && ! -r ${2} ]]
then
  echo "Arg 2: Must be a readable file" > /dev/stderr
  echo " "
  exit 2
fi

#Checking if file is empty
if [[ ! -s ${2} ]]
then
  echo "Arg 2: File must contain integers 1-9" > /dev/stderr
  echo " "
  exit 3
fi
while read line
do
count=$(echo "${line}" | wc -w)
  for i in ${line[@]}
  do
  #If it contains numbers 1-9
  if [[ $i -gt 0 && $i -lt 10 ]]
    then
    #To check unique numbers
    if [[ ${Int_check[$i]} ]]
    then 
      echo "Arg 2: File must contain integers 1-9" > /dev/stderr
      echo " "
      exit 3
    else
      Int_check[$i]=1
    fi
  else 
    echo "Arg 2: File must contain integers 1-9" > /dev/stderr
    echo " "
    exit 3
  fi
  done
  #If it contains 9 numbers
    if [[ ${count} -ne 9 ]]  
    then 
      echo "Arg 2: File must contain integers 1-9" > /dev/stderr
      echo " "
      exit 3
    fi
done <${2}

    


while read line
do
 for i in ${line}
  do
   # Assigning each of the values in the cells first then changing 
   cells[i-1]=${player} 
    
   
   if check_Winner  
   then
      winner=${player}
      dashes 
      break # To stop the loop from continuing after finding 3 in a row, column, or diagonal
   fi
   #Switching the player after checking if there is any winner 
    if [[ ${player} == "X" ]]
   then
      player="O"
   else 
      player="X"
   fi
 done
 

 
 if [[ ${winner} == "X" ]]
 then
    echo " "
    echo "${winner} is the winner!"
    game_board
    exit 4
 elif [[ ${winner} == "O" ]]
 then
    echo " "
    echo "${winner} is the winner!"
    game_board
    exit 5
 else
    echo " " 
    echo "The game ends in a tie."
    game_board
    exit 6
 fi
done <${2}


