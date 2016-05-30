#!/usr/bin/env bash
# Display menus to the user and then run the selected Hadoop job.

do_enter_clear()
{
  echo -en "\nPress Enter to continue"
  read
  clear
}

display_top_menu()
{
  clear
  echo "Hadoop Cluster Testing Menu"
  echo ""
  echo "You may run a test job, or display various information about the system."
  echo ""
  echo "J - choose a Job to run"
  echo "V - display Hadoop, Java and OS Version information"
  echo "S - Start the Hadoop cluster software"
  echo "H - Halt (shutdown) the Hadoop cluster software"
  echo "Q - Quit"
}

display_job_menu()
{
  clear
  echo "Choose a job type to run,"
  echo "then choose the parameters for the job."
  echo ""
  echo "The job will be run and you will see the progress output."
  echo ""
  echo "P - Pi calculation"
  echo "W - Word count"
  echo "Q - Quit"
}

picalc_menu()
{
  clear
  echo "Calculate Pi"
  echo ""
  echo "This sample Hadoop job uses a quasi-Monte Carlo method to calculate an estimate of Pi"
  echo "It takes 2 parameters:"
  echo "  nMaps - the number of map processes to use"
  echo "  nSamples - the number of samples per map to use for the calculation"
  echo ""
  echo "On a 3 or 4 node cluster we will use 8 Maps"
  echo ""
  echo "At the end of the job, the elapsed time and estimate of Pi are displayed."
  echo ""
  echo "You can choose the number of samples."
  echo "More samples take longer to process, but give a better estimate."
  echo "On the RPi much of the time is taken setting up the job."
  echo "A million samples takes about 50 seconds and gives about 6 digits of Pi."
  echo "100 million samples takes about 100 seconds and gives about 8 digits of Pi."
  echo ""
  echo -n "Enter number of samples: "
  read samples
  case $samples in
    *[!0-9]* ) echo "You must enter a valid positive integer";;
    0 ) echo "You cannot have zero samples";;
    "" ) echo "You must enter a positive integer";;
    * ) hadoop jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar pi 8 $samples
  esac
}

wordcount_menu()
{
  clear
  textoption=

  until [ "$textoption" = "Q" ]; do
    echo "Wordcount"
    echo ""
    echo "This example counts the number of occurrences of the different words in a document"
    echo ""
    echo "The following texts are available:"
    echo ""
    echo "S - small text file (1.2MB)"
    echo "M - medium text file (35MB)"
    echo "U - Ulysses by James Joyce (1.5MB)"
    echo "H - Huckleberry Finn by Mark Twain (0.6MB)"
    echo "W - War and Peace by Leo Tolstoy (1.2MB)"
    echo ""
    echo "Q - Quit"
    echo ""
    echo -n "Enter selection: "
    read textoption
    echo ""
    # Get just the 1st character
    textoption=${textoption:0:1}
    # Convert to uppercase
    textoption=${textoption^}
    tfn=
    case $textoption in
      S ) tfd="small text file";tfn="smallfile";;
      M ) tfd="medium text file";tfn="mediumfile";;
      U ) tfd="Ulysses";tfn="4300";;
      H ) tfd="Huckleberry Finn";tfn="76";;
      W ) tfd="War and Peace";tfn="2600";;
      "" ) clear;;
      Q ) clear;;
      * ) echo "Enter a valid Wordcount text file option"; do_enter_clear;;
    esac
    if [ -n "$tfn" ]; then
      echo "Doing Wordcount for $tfd"
      time hadoop jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar wordcount /textfiles/${tfn}.txt /${tfn}-out
      do_enter_clear
    fi
  done
}

job_menu()
{
  job=

  until [ "$job" = "Q" ]; do
    display_job_menu
    echo -n "Enter selection: "
    read job
    echo ""
    # Get just the 1st character
    job=${job:0:1}
    # Convert to uppercase
    job=${job^}
    case $job in
      P ) picalc_menu; do_enter_clear;;
      W ) wordcount_menu; clear;;
      "" ) clear;;
      Q ) clear;;
      * ) echo "Enter a valid Job menu option"; do_enter_clear;;
    esac
  done
}

display_versions()
{
  hadoop version
  echo ""
  java -version
  echo ""
  cat /proc/version
  echo ""
  if [ -f /etc/os-release ]; then
    cat /etc/os-release
  fi
}

selection=

until [ "$selection" = "Q" ]; do
  display_top_menu
  echo -n "Enter selection: "
  read selection
  echo ""
  # Get just the 1st character
  selection=${selection:0:1}
  # Convert to uppercase
  selection=${selection^}
  case $selection in
    J ) job_menu;;
    V ) display_versions; do_enter_clear;;
    S ) start-dfs.sh; start-yarn.sh; do_enter_clear;;
    H ) stop-yarn.sh; stop-dfs.sh; do_enter_clear;;
    "" ) clear;;
    Q ) exit;;
    * ) echo "Enter a valid menu option"; do_enter_clear;;
  esac
done

# eof
